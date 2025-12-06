return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local function harpoon_picker()
      local devicons = require("nvim-web-devicons")

      Snacks.picker.pick({
        source = "harpoon",
        title = "Harpoon Marks",
        finder = function()
          local items = {}
          local harpoon_list = harpoon:list()
          for idx, item in ipairs(harpoon_list.items) do
            local file_path = item.value
            table.insert(items, {
              idx = idx,
              text = file_path,
              file = file_path,
              preview = { file = file_path },
            })
          end
          return items
        end,
        format = function(item, _)
          local ret = {}
          table.insert(ret, { item.idx .. ". ", "SnacksPickerIdx" })
          -- add icons
          local icon, hl = devicons.get_icon(item.text, vim.fn.fnamemodify(item.text, ":e"), { default = true })
          if icon then
            table.insert(ret, { icon .. " ", hl or "DevIconDefault" })
          end
          table.insert(ret, { item.text, "SnacksPickerFile" })
          return ret
        end,
        preview = "file",
        confirm = function(picker, item)
          picker:close()
          if item then
            harpoon:list():select(item.idx)
          end
        end,
        actions = {
          delete_mark = function(picker, _)
            local selected = picker:selected({ fallback = true })
            for _, item in ipairs(selected) do
              if item.idx then
                harpoon:list():remove_at(item.idx)
              end
            end
            picker:refresh()
          end,
        },
        win = {
          input = {
            keys = {
              ["<C-X>"] = { "delete_mark", mode = { "i", "n" }, desc = "Delete Harpoon Mark" },
            },
          },
          list = {
            keys = {
              ["<C-X>"] = { "delete_mark", mode = { "n" }, desc = "Delete Harpoon Mark" },
            },
          },
        },
      })
    end

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harppon Mark File" })

    vim.keymap.set("n", "<leader>fh", harpoon_picker, { desc = "Harpoon Marks" })

    vim.keymap.set("n", "<C-B>", function()
      harpoon:list():prev({ ui_nav_wrap = true })
    end, { desc = "Harpoon Previous/Backwards Mark" })

    vim.keymap.set("n", "<C-F>", function()
      harpoon:list():next({ ui_nav_wrap = true })
    end, { desc = "Harpoon Next/Forward Mark" })
  end,
}
