return {
  {
    "nvim-lua/plenary.nvim", -- Dependencia necesaria para algunas funciones útiles
    config = function()
      local terminals = {} -- Tabla para rastrear terminales abiertas

      local function toggle_terminal(split_type)
        local buf_name = "Terminal " .. split_type
        for _, term in pairs(terminals) do
          if vim.api.nvim_buf_is_valid(term.buf) and vim.api.nvim_buf_get_name(term.buf) == buf_name then
            local win = vim.fn.bufwinid(term.buf)
            if win ~= -1 then
              vim.api.nvim_win_close(win, true)
            else
              vim.cmd(split_type .. " split")
              vim.api.nvim_win_set_buf(0, term.buf)
              vim.api.nvim_command("startinsert")
            end
            return
          end
        end

        vim.cmd(split_type .. " split")
        local buf = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_buf_set_name(buf, buf_name)
        vim.api.nvim_win_set_buf(0, buf)
        vim.fn.termopen(vim.o.shell)
        vim.api.nvim_command("startinsert")
        vim.bo[buf].buflisted = true -- Asegura que el buffer aparezca en la lista
        terminals[split_type] = { buf = buf }
      end

      vim.keymap.set("n", "<leader>fv", function()
        toggle_terminal("vertical")
      end, { desc = "Toggle Vertical Terminal" })

      vim.keymap.set("n", "<leader>fh", function()
        toggle_terminal("")
      end, { desc = "Toggle Horizontal Terminal" })
    end,
  },
  {
    "akinsho/toggleterm.nvim", -- Asegúrate de tener el plugin para terminales
    config = function()
      require("toggleterm").setup({
        -- Configuración predeterminada
        open_mapping = [[<leader>tx]],
        direction = "float", -- Configuración flotante como ejemplo
        float_opts = {
          border = "curved",
        },
      })

      -- Salir del modo terminal con <Esc><Esc>
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = true })
        end,
      })
    end,
  },
}
