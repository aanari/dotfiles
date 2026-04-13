local create_cmd = vim.api.nvim_create_user_command
local autosave_group = vim.api.nvim_create_augroup("Autosave", { clear = true })

create_cmd("AutosaveToggle", function()
  vim.g.autosave = not vim.g.autosave
  vim.api.nvim_clear_autocmds { group = autosave_group }

  if not vim.g.autosave then
    return
  end

  vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    group = autosave_group,
    callback = function()
      if vim.api.nvim_buf_get_name(0) ~= "" and vim.bo.buftype == "" then
        vim.cmd "silent w"
        vim.api.nvim_echo(
          { { "󰄳", "LazyProgressDone" }, { " file autosaved at " .. os.date("%I:%M %p") } },
          false,
          {}
        )

        vim.defer_fn(function()
          vim.api.nvim_echo({}, false, {})
        end, 800)
      end
    end,
  })
end, { desc = "Toggle autosave" })
