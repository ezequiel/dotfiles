// hide-footer — TUI entrypoint (auto-discovered as <global-config>/plugins/hide-footer/tui.tsx).
// Replaces the entire prompt.footer slot, hiding the built-in
// "…/dir:branch  ↓ N shell · 136.4K (13%)" status row — but re-renders a
// minimal working indicator while the agent is running. slot({ replace })
// suppresses the slot's original content AND every other claim inside it, so
// a plain `render: () => null` also hides the built-in "⠹ esc interrupt"
// progress row. This render recreates just that indicator.
// Slot docs: https://opencode.ai/v2/docs/build/plugins/cli#slots
import { Plugin } from "@opencode/plugin/tui";
import { createSignal, onCleanup, Show } from "solid-js";

const FRAMES = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];

export default Plugin.define({
  id: "hide-footer",
  setup(context) {
    return context.ui.slot({
      replace: "prompt.footer",
      render: (input) => {
        const running = () =>
          !!input.sessionID && context.data.session.status(input.sessionID!) === "running";
        const [frame, setFrame] = createSignal(0);
        const timer = setInterval(() => setFrame((value) => (value + 1) % FRAMES.length), 80);
        onCleanup(() => clearInterval(timer));
        return (
          <Show when={running()}>
            <box flexDirection="row" gap={1}>
              <box marginLeft={1}>
                <text fg={context.theme.text.muted}>{FRAMES[frame()]}</text>
              </box>
              <text fg={context.theme.text.base} wrapMode="none" truncate flexShrink={1}>
                esc <span style={{ fg: context.theme.text.muted }}>interrupt</span>
              </text>
            </box>
          </Show>
        );
      },
    });
  },
});
