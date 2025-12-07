return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  lazy = true,
  dependencies = {
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon Mark File",
    },
    {
      "<leader>fh",
      function()
        local harpoon = require("harpoon")
        local devicons = require("nvim-web-devicons")

        Snacks.picker.pick({
          source = "harpoon",
          title = "Harpoon Marks",
          finder = function()
            local items = {}
            local harpoon_list = harpoon:list()
            local display_num = 0
            -- iterate up to the list length to handle sparse arrays properly
            for idx = 1, harpoon_list:length() do
              local item = harpoon_list.items[idx]
              if item ~= nil then
                display_num = display_num + 1
                local file_path = item.value
                table.insert(items, {
                  harpoon_idx = idx, -- actual index in harpoon's sparse array
                  display_num = display_num, -- sequential number for display
                  text = file_path,
                  file = file_path,
                  preview = { file = file_path },
                })
              end
            end
            return items
          end,
          format = function(item, _)
            local ret = {}
            table.insert(ret, { item.display_num .. ". ", "SnacksPickerIdx" })
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
              harpoon:list():select(item.harpoon_idx)
            end
          end,
          actions = {
            delete_mark = function(picker, _)
              local selected = picker:selected({ fallback = true })
              local harpoon_list = harpoon:list()
              for _, item in ipairs(selected) do
                if item.harpoon_idx then
                  harpoon_list:remove_at(item.harpoon_idx)
                end
              end
              -- close picker if list is now empty, otherwise refresh
              if next(harpoon_list.items) == nil then
                picker:close()
              else
                picker:refresh()
              end
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
      end,
      desc = "Find Harpoon Marks",
    },
    {
      "<C-B>",
      function()
        require("harpoon"):list():prev({ ui_nav_wrap = true })
      end,
      desc = "Harpoon Previous/Backwards Mark",
    },
    {
      "<C-F>",
      function()
        require("harpoon"):list():next({ ui_nav_wrap = true })
      end,
      desc = "Harpoon Next/Forward Mark",
    },
  },
  opts = {},
}
