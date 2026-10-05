// hide-footer — TUI entrypoint (auto-discovered as <global-config>/plugins/hide-footer/tui.ts).
// Replaces the entire prompt.footer slot with nothing, hiding the built-in
// "…/dir:branch  ↓ N shell · 136.4K (13%)" status row. Slot docs:
// https://opencode.ai/v2/docs/build/plugins/cli#slots (prepend/append/before/after/replace).
import { Plugin } from "@opencode/plugin/tui";

export default Plugin.define({
  id: "hide-footer",
  setup(context) {
    return context.ui.slot({ replace: "prompt.footer", render: () => null });
  },
});
