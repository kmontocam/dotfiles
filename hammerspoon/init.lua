---@diagnostic disable: undefined-global
---@enum directions
local DIRECTIONS = {
	LEFT = "left",
	DOWN = "down",
	UP = "up",
	RIGHT = "right",
}

---@param dir directions
---@diagnostic disable-next-line: lowercase-global
function focusWindowInDirection(dir)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end
	local nextWin = nil

	if dir == DIRECTIONS.LEFT then
		nextWin = win:windowsToWest()[1]
	elseif dir == DIRECTIONS.DOWN then
		nextWin = win:windowsToSouth()[1]
	elseif dir == DIRECTIONS.UP then
		nextWin = win:windowsToNorth()[1]
	elseif dir == DIRECTIONS.RIGHT then
		nextWin = win:windowsToEast()[1]
	end

	if nextWin then
		nextWin:focus()
	end
end

hs.hotkey.bind({ "alt" }, "h", function()
	focusWindowInDirection(DIRECTIONS.LEFT)
end)
hs.hotkey.bind({ "alt" }, "l", function()
	focusWindowInDirection(DIRECTIONS.RIGHT)
end)
hs.hotkey.bind({ "alt" }, "k", function()
	focusWindowInDirection(DIRECTIONS.UP)
end)
hs.hotkey.bind({ "alt" }, "j", function()
	focusWindowInDirection(DIRECTIONS.DOWN)
end)
