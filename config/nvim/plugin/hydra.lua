local Hydra = require('hydra')
require('hydra.statusline')

local hint = [[
                Window mode
 _v_ vsplit   _h_ <C-w>h   _H_ <C-w>>   _>_ <C-w>5>
 _s_ split    _j_ <C-w>j   _J_ <C-w>-   _-_ <C-w>- 
 _=_ =        _k_ <C-w>k   _K_ <C-w>+   _+_ <C-w>+   
 _x_ :q<CR>   _l_ <C-w>l   _L_ <C-w><   _<_ <C-w>5<
 _<Esc>_ / _q_
]]

local heads = {
      { 's', ':split <CR> <C-w>j' }, 
      { 'v', ':vsplit <CR> <C-w>l' }, 
      { '=', '<C-w>=' },
      { 'x', ':q <CR>' },

      { 'h', '<C-w>h' },
      { 'j', '<C-w>j' },
      { 'k', '<C-w>k' },
      { 'l', '<C-w>l' },

      { '>', '<C-w>5>' },
      { '-', '<C-w>-' },
      { '+', '<C-w>+' },
      { '<', '<C-w>5<' },

      { 'H', '<C-w>H' },
      { 'J', '<C-w>J' },
      { 'K', '<C-w>K' },
      { 'L', '<C-w>L' },

      { 'q', nil, {exit=true} },
      { '<Esc>', nil, {exit=true} },
   }
Hydra({
   name = 'Window mode',
   mode = 'n',
   hint = hint,
   config = {
      color = 'amaranth',
      hint = {
         position = 'bottom',
         border = 'rounded',
      },
   },
   body = '<leader>W',
   heads = heads,
})

Hydra({
   name = 'Window mode',
   mode = 'n',
   config = {
      color = 'blue',
      hint = {
         position = 'bottom',
         border = 'rounded',
      },
   },
   body = '<leader>w',
   heads = heads,
})
