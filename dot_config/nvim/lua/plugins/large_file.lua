return {
  'mireq/large_file',
  opts = {
    size_limit = 512 * 1024, -- 512kiB
    on_large_file_read_pre = function(_)
      vim.notify('Opening a large file!', vim.log.levels.WARN)
    end,
  },
}
