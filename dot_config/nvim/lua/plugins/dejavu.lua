return {
  'juk3-min/dejavu.nvim',
  lazy = false,
  opts = {
    enabled = true,
    callback = function(command)
      local key = command:sub(1, 1)
      if key:match('^[%.fFtTgGvVhHjJkKlL]$') then
        return
      end
      vim.keymap.set('n', '.', function()
        local keys = vim.api.nvim_replace_termcodes(command, true, true, true)
        vim.api.nvim_feedkeys(keys, 'm', false)
      end)
    end,
    notify = function() end,
  },
}
