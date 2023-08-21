local Hydra = require('hydra')

Hydra({
   name = 'Side scroll',
   mode = 'n',
   body = 'z',
   heads = {
      { 'h', '5zh' },
      { 'l', '5zl', { desc = '←/→' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen ←/→' } },
   }
})

Hydra({
   name = 'Resize win',
   mode = 'n',
   body = '<C-w>',
   heads = {
      { '+', '5<C-w>+', { desc = "🠝 / Increase Height" } },
      { '-', '5<C-w>-', { desc = "🠟 / Decrease Height" } },
      { '_', '<C-w>_',  { desc = " / Max Out Height" } },
      { '=', '<C-w>=',   { desc = "  / Equally High and Wide" } },
      { '>', '5<C-w>>', { desc = "🠞 / Increase Width" } },
      { '<', '5<C-w><', { desc = "🠜 / Decrease Width�������������" } },
      { '|', '<C-w>|',  { desc = "⟺  / Max Out Width�������������" } },
   }
})
