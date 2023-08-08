local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
	return nil
end

gitsigns.setup()
