-- -- append path to custom lua modules
package.path = package.path .. ";/Users/kmontocam/git/nvim-conda/lua/?.lua"
package.path = package.path .. ";/Users/kmontocam/git/nvim-conda/?.lua"

-- clear cache debugging function
package.loaded["plugin.conda"] = nil
package.loaded["conda.utils"] = nil
package.loaded["conda.envs"] = nil
package.loaded["conda.ui"] = nil
package.loaded["conda.lsps"] = nil

require("kmontocam.plugins-setup")
require("kmontocam.core.options")
require("kmontocam.core.keymaps")
require("kmontocam.core.colorscheme")
require("plugin.conda")
require("conda.utils")
