return {
  'kevinhwang91/nvim-hlslens',
  dependencies = {
    'rapan931/lasterisk.nvim',
  },
  keys = {
    {
      'n',
      function()
        local count = vim.v.count1
        local key = (count > 1 and count or '') .. 'n'
        local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
        vim.api.nvim_feedkeys(keys, 'n', false)
        require('hlslens').start()
      end,
      desc = 'Next search result (lens)',
      silent = true,
      noremap = true,
    },
    {
      'N',
      function()
        local count = vim.v.count1
        local key = (count > 1 and count or '') .. 'N'
        local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
        vim.api.nvim_feedkeys(keys, 'n', false)
        require('hlslens').start()
      end,
      desc = 'Prev search result (lens)',
      silent = true,
      noremap = true,
    },
    {
      '*',
      function()
        require('lasterisk').search({ is_whole = true })
        require('hlslens').start()
      end,
      desc = 'Search word under cursor (lens)',
      silent = true,
      noremap = true,
    },
    {
      '*',
      function()
        require('lasterisk').search({ is_whole = false })
        require('hlslens').start()
      end,
      mode = 'x',
      desc = 'Search selection (lens)',
      silent = true,
      noremap = true,
    },
  },
  opts = {
    calm_down = {
      default = true,
    },
    nearest_only = {
      default = true,
    },
    override_lens = function(render, posList, nearest, idx, _)
      local lnum, col = unpack(posList[idx])
      local cnt = #posList
      local text = ('[%d/%d]'):format(idx, cnt)
      local chunks
      if nearest then
        chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
      else
        chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
      end
      render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end,
  },
}
