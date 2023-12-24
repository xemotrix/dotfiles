local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function prepare_output_table()
  local scripts = vim.api.nvim_exec("!find *", true)

  local lines = {} 
  function exists(file)
     local ok, err, code = os.rename(file, file)
     if not ok then
        if code == 13 then
           -- Permission denied, but it exists
           return true
        end
     end
     return ok, err
  end
  function isdir(path)
     return exists(path.."/")
  end

  for script in scripts:gmatch("[^\r\n]+") do
    if isdir(script) then
      table.insert(lines, script)
    end
  end 
  table.remove(lines, 1)
  return lines
end


local action_oil = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    vim.api.nvim_command("e " .. selection[1])
  end)
  return true
end



local findfolder = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "DIRECTORIES",
    finder = finders.new_table {
      results = prepare_output_table(),
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = action_dive,
  }):find()
end

vim.keymap.set('n', '<leader>fe', function() findfolder() end)

