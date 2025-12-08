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

              -- collect indices to remove (in descending order to avoid index shifting issues)
              local indices_to_remove = {}
              for _, item in ipairs(selected) do
                if item.harpoon_idx then
                  table.insert(indices_to_remove, item.harpoon_idx)
                end
              end
              table.sort(indices_to_remove, function(a, b)
                return a > b
              end)

              -- collect all items except the ones to remove, preserving order
              local new_items = {}
              local remove_set = {}
              for _, idx in ipairs(indices_to_remove) do
                remove_set[idx] = true
              end

              for idx = 1, harpoon_list:length() do
                local item = harpoon_list.items[idx]
                if item ~= nil and not remove_set[idx] then
                  table.insert(new_items, item)
                end
              end

              -- clear and re-add all items to get a compact list
              harpoon_list:clear()
              for _, item in ipairs(new_items) do
                harpoon_list:add(item)
              end

              -- close picker if list is now empty, otherwise refresh
              if next(harpoon_list.items) == nil then
                picker:close()
              else
                picker:refresh()
              end
            end,
            move_up = function(picker, _)
              local current = picker:current()
              if not current or not current.harpoon_idx then
                return
              end

              local harpoon_list = harpoon:list()

              -- collect all non-nil items into a compact array
              local items = {}
              for idx = 1, harpoon_list:length() do
                local item = harpoon_list.items[idx]
                if item ~= nil then
                  table.insert(items, item)
                end
              end

              -- find current position in compact array
              local current_pos = nil
              for i, item in ipairs(items) do
                if item.value == current.text then
                  current_pos = i
                  break
                end
              end

              if not current_pos or #items < 2 then
                return
              end

              -- calculate new position (move up = decrease index, wrap to end if at first)
              local new_pos = current_pos == 1 and #items or current_pos - 1

              -- swap items
              items[current_pos], items[new_pos] = items[new_pos], items[current_pos]

              -- rebuild harpoon list
              harpoon_list:clear()
              for _, item in ipairs(items) do
                harpoon_list:add(item)
              end

              picker:refresh()

              -- move cursor to follow the item
              if current_pos == 1 then
                Snacks.picker.actions.list_bottom(picker)
              else
                Snacks.picker.actions.list_up(picker)
              end
            end,
            move_down = function(picker, _)
              local current = picker:current()
              if not current or not current.harpoon_idx then
                return
              end

              local harpoon_list = harpoon:list()

              -- collect all non-nil items into a compact array
              local items = {}
              for idx = 1, harpoon_list:length() do
                local item = harpoon_list.items[idx]
                if item ~= nil then
                  table.insert(items, item)
                end
              end

              -- find current position in compact array
              local current_pos = nil
              for i, item in ipairs(items) do
                if item.value == current.text then
                  current_pos = i
                  break
                end
              end

              if not current_pos or #items < 2 then
                return
              end

              -- calculate new position (move down = increase index, wrap to first if at last)
              local new_pos = current_pos == #items and 1 or current_pos + 1

              -- swap items
              items[current_pos], items[new_pos] = items[new_pos], items[current_pos]

              -- rebuild harpoon list
              harpoon_list:clear()
              for _, item in ipairs(items) do
                harpoon_list:add(item)
              end

              picker:refresh()

              -- move cursor to follow the item
              if current_pos == #items then
                Snacks.picker.actions.list_top(picker)
              else
                Snacks.picker.actions.list_down(picker)
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<C-X>"] = { "delete_mark", mode = { "i", "n" }, desc = "Delete Harpoon Mark" },
                ["<C-U>"] = { "move_up", mode = { "i", "n" }, desc = "Move Mark Up" },
                ["<C-D>"] = { "move_down", mode = { "i", "n" }, desc = "Move Mark Down" },
              },
            },
            list = {
              keys = {
                ["<C-X>"] = { "delete_mark", mode = { "n" }, desc = "Delete Harpoon Mark" },
                ["<C-U>"] = { "move_up", mode = { "n" }, desc = "Move Mark Up" },
                ["<C-D>"] = { "move_down", mode = { "n" }, desc = "Move Mark Down" },
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
