export const NotificationPlugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "permission.asked") {
        await $`osascript -e 'if application "kitty" is not frontmost then display notification "Needs input" with title "OpenCode" sound name "Ping"'`
      }
    },
  }
}
