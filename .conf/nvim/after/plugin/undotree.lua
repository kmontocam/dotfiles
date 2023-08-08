local status, undotree = pcall(require, "undotree")
if not status then
	return nil
end

undotree.setup()
