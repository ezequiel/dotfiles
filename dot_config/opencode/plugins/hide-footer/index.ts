// hide-footer — server entrypoint (no-op; the CLI plugin lives in tui.tsx).
// Removes the built-in prompt footer ("dir:branch · sync · N shell · tokens (ctx%)")
// but keeps a minimal "agent is working" indicator.
export default {
  id: "hide-footer",
  async setup() {},
};
