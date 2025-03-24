local function get_lsp_client_names(have_feature)
  local client_names = {}
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(attached_clients) do
    if have_feature(client) then
      table.insert(client_names, client.name)
    end
  end
  return client_names
end

local function lsp_buf_rename(client_name)
  vim.lsp.buf.rename(nil, { name = client_name })
end

local function lsp_buf_rename_use_one(fallback)
  local client_names = get_lsp_client_names(function(client)
    return client.supports_method("textDocument/rename")
  end)
  if #client_names == 1 then
    lsp_buf_rename(client_names[1])
    return
  end
  if fallback then
    fallback()
  end
end

local function lsp_buf_rename_use_select(fallback)
  local client_names = get_lsp_client_names(function(client)
    return client.supports_method("textDocument/rename")
  end)
  local prompt = "Select LSP client for rename operation"
  local function on_choice(client_name)
    if client_name then
      lsp_buf_rename(client_name)
      return
    end
    if fallback then
      fallback()
    end
  end
  vim.ui.select(client_names, { prompt = prompt }, on_choice)
end

local function lsp_buf_rename_use_priority(lsp_priority, fallback)
  local client_names = get_lsp_client_names(function(client)
    return client.supports_method("textDocument/rename")
  end)
  for _, client_priority_name in ipairs(lsp_priority) do
    for _, client_name in ipairs(client_names) do
      if client_priority_name == client_name then
        lsp_buf_rename(client_priority_name)
        return
      end
    end
  end
  if fallback then
    fallback()
  end
end

local function lsp_buf_rename_use_priority_or_select(lsp_priority)
  lsp_buf_rename_use_one(function()
    lsp_buf_rename_use_priority(lsp_priority, function()
      lsp_buf_rename_use_select()
    end)
  end)
end

vim.keymap.set("n", "<leader>rn", function()
  lsp_buf_rename_use_priority_or_select({ "angularls", "vtsls" })
end)
