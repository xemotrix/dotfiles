require'hop'.setup()

local hop = require('hop')

local directions = require('hop.hint').HintDirection

vim.keymap.set('n', '<C-f>', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('n', '<C-S-f>', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('n', '<C-t>', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, {remap=true})

vim.keymap.set('n', '<C-S-T>', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, {remap=true})

