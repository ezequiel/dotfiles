// branch-session-title
//
// Managed by chezmoi: dot_config/opencode/plugins/branch-session-title.js
// (unlike bottlerocket-plugin.ts and herdr-agent-state.js beside it, which
// stay local/work-only). Edit the chezmoi source, then `chezmoi apply`.
//
// Renames sessions to "{branch} - {title}" whenever the title changes
// (auto-generated after the first reply, or manual rename), so every
// session name carries the branch it belongs to.
//
// How it works: OpenCode v2 publishes `session.renamed` with
// data { sessionID, title } on every title change (verified on v2.0.22).
// Plugins load per location but the event stream is server-wide, and some
// publishes (e.g. plugin-initiated updates) arrive without
// `event.location`, so scoping resolves the session itself and compares
// session.location.directory to this instance's ctx.location.directory.
//
// Notes:
// - ctx.vcs.get() returns an envelope: { data: { branch: { current } } }.
// - Our own ctx.session.update re-fires `session.renamed`; the title then
//   already starts with the prefix, so the loop stops after one no-op pass.
// - Subagent (child) sessions keep their own titles (parentID is set).
// - The last applied prefix is kept in ctx.storage per session, so a
//   rename after switching branches replaces "old - x" with "new - x"
//   instead of stacking "new - old - x".
//
// Every failure degrades to "title left unchanged", never a broken opencode.

export default {
  id: "branch-session-title",

  // OpenCode v2 entrypoint only; no v1 server() hook.
  async setup(ctx) {
    if (typeof ctx?.event?.subscribe !== "function") return;
    if (typeof ctx?.session?.get !== "function") return;
    if (typeof ctx?.session?.update !== "function") return;
    if (typeof ctx?.vcs?.get !== "function") return;

    const directory = ctx.location?.directory;

    async function currentBranch() {
      try {
        const info = await ctx.vcs.get();
        const branch = info?.data?.branch?.current ?? info?.branch?.current;
        return typeof branch === "string" && branch ? branch : undefined;
      } catch {
        return undefined; // not a repo / detection unavailable: skip
      }
    }

    async function applyPrefix(sessionID, title) {
      if (typeof sessionID !== "string" || !sessionID) return;
      if (typeof title !== "string" || !title.trim()) return;

      let session;
      try {
        session = await ctx.session.get({ sessionID });
      } catch {
        return;
      }
      const info = session?.data ?? session;
      if (info?.parentID) return; // subagent sessions keep their own titles
      const sessionDir = info?.location?.directory;
      if (directory && sessionDir && sessionDir !== directory) return;

      const branch = await currentBranch();
      if (!branch) return;

      const prefix = `${branch} - `;
      if (title.startsWith(prefix)) return; // already correct (incl. our own update)

      let applied;
      try {
        applied = await ctx.storage.get(sessionID);
      } catch {
        applied = undefined;
      }
      const base =
        typeof applied === "string" && applied && title.startsWith(applied)
          ? title.slice(applied.length)
          : title;

      const next = `${prefix}${base}`;
      if (next === title) return;

      const ok = await ctx.session
        .update({ sessionID, title: next })
        .then(() => true, () => false);
      if (ok) {
        try {
          await ctx.storage.set(sessionID, prefix);
        } catch {}
      }
    }

    const controller = new AbortController();
    void (async () => {
      try {
        for await (const event of ctx.event.subscribe({ signal: controller.signal })) {
          if (event?.type !== "session.renamed") continue;
          await applyPrefix(event?.data?.sessionID, event?.data?.title).catch(() => {});
        }
      } catch {
        // Stream overflow or abort: degrade silently like herdr-agent-state.
      }
    })();

    return () => controller.abort();
  },
};
