-- NOTE: various, non-plugin config
require("piratenpete.opts")
require("piratenpete.keymaps")
require("piratenpete.autocommands")

-- NOTE: register an extra lze handler with the spec_field 'for_cat'
-- that makes enabling an lze spec for a category slightly nicer
require("lze").register_handlers(require("nixCatsUtils.lzUtils").for_cat)

-- NOTE: Register another one from lzextras. This one makes it so that
-- you can set up lsps within lze specs,
-- and trigger lspconfig setup hooks only on the correct filetypes
require("lze").register_handlers(require("lzextras").lsp)
-- demonstrated in ./LSPs/init.lua

require("piratenpete.plugins")
require("piratenpete.LSPs")
require("piratenpete.lint")
require("piratenpete.format")

if nixCats("debug") then
  require("piratenpete.debug")
end
