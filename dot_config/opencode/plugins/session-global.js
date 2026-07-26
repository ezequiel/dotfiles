// Disable session directory filtering so all sessions show regardless of cwd
export const SessionGlobalPlugin = async ({ $ }) => {
  if ($.kv) {
    $.kv.set("session_directory_filter_enabled", false)
  }
}
