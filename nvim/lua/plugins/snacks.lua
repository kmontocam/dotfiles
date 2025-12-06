return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    gh = { enabled = true },
    gitbrowse = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    keymap = { enabled = true },
    layout = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    terminal = { enabled = true },
    toggle = { enabled = true },
  },
  config = function(_, opts)
    vim.g.snacks_animate = false
    require("snacks").setup(opts)
    -- prevent cursor from becoming thin in insert mode
    vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20"
    local M = { format = {} }

    -- ref: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/format.lua
    function M.format.enable(enable, buf)
      if enable == nil then
        enable = true
      end
      if buf then
        vim.b.autoformat = enable
      else
        vim.g.autoformat = enable
        vim.b.autoformat = nil
      end
    end

    function M.format.enabled(buf)
      buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
      local gaf = vim.g.autoformat
      local baf = vim.b[buf].autoformat

      -- If the buffer has a local value, use that
      if baf ~= nil then
        return baf
      end

      -- Otherwise use the global value if set, or true by default
      return gaf == nil or gaf
    end

    function M.format.snacks_toggle(buf)
      return Snacks.toggle({
        name = "Auto Format (" .. (buf and "Buffer" or "Global") .. ")",
        get = function()
          if not buf then
            return vim.g.autoformat == nil or vim.g.autoformat
          end
          return M.format.enabled()
        end,
        set = function(state)
          M.format.enable(state, buf)
        end,
      })
    end

    M.format.snacks_toggle():map("<leader>uf")
    M.format.snacks_toggle(true):map("<leader>uF")
  end,
  keys = {
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Find Recent",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.grep()
      end,
      desc = "Find Grep",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Find Current Word",
    },
    {
      "<leader>f?",
      function()
        Snacks.picker.help()
      end,
      desc = "Find Help",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Find Keymaps",
    },
    {
      "<leader>fq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Find Quickfix List",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Find Quickfix List",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Git Log Line",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff (Hunks)",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Git Log File",
    },
    {
      "<leader>gU",
      function()
        Snacks.gitbrowse({
          open = function(url)
            vim.fn.setreg("+", url)
          end,
          what = "branch",
          notify = false,
        })
      end,
      desc = "Git Yank Remote URL",
    },
    {
      "<leader>gR",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Remote Buffer Reference",
      mode = { "n", "v" },
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (open)",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({ state = "all" })
      end,
      desc = "GitHub Issues (all)",
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (open)",
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({ state = "all" })
      end,
      desc = "GitHub Pull Requests (all)",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.diagnostics():map("<leader>uw")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>ud")
      end,
    })
  end,
}
