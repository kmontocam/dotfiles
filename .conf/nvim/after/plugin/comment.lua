local setup, comment = pcall(require, "Comment")
if not setup then
	return nil
end

comment.setup()
