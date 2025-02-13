---@diagnostic disable-next-line: lowercase-global
hs = hs

hs.hotkey.bind({ "alt" }, "h", function()
	local focus = hs.window.focusedWindow()

	if #focus:windowsToWest() == 0 then
		local eastWindows = focus.windowsToEast()
		if #eastWindows == 0 then
			-- trying to access unavailable windows
			return nil
		end
		eastWindows[#eastWindows]:focus()
		return nil
	end

	hs.window.filter.focusWest(nil, false)
end)

hs.hotkey.bind({ "alt" }, "j", function()
	local focus = hs.window.focusedWindow()

	if #focus:windowsToSouth() == 0 then
		local northWindows = focus.windowsToNorth()
		if #northWindows == 0 then
			-- trying to access unavailable windows
			return nil
		end
		northWindows[#northWindows]:focus()
		return nil
	end

	hs.window.filter.focusSouth(nil, false)
end)

hs.hotkey.bind({ "alt" }, "k", function()
	local focus = hs.window.focusedWindow()

	if #focus:windowsToNorth() == 0 then
		local southWindows = focus.windowsToSouth()
		if #southWindows == 0 then
			-- trying to access unavailable windows
			return nil
		end
		southWindows[#southWindows]:focus()
		return nil
	end

	hs.window.filter.focusNorth(nil, false)
end)

hs.hotkey.bind({ "alt" }, "l", function()
	local focus = hs.window.focusedWindow()

	if #focus:windowsToEast() == 0 then
		local westWindows = focus.windowsToWest()
		if #westWindows == 0 then
			-- trying to access unavailable windows
			return nil
		end
		westWindows[#westWindows]:focus()
		return nil
	end

	hs.window.filter.focusEast(nil, false)
end)

hs.hotkey.bind({ "alt" }, "n", function()
	local windows = hs.window.orderedWindows()
	if #windows > 0 then
		windows[#windows]:focus()
	end
end)

hs.hotkey.bind({ "alt" }, "b", function()
	local windows = hs.window.orderedWindows()
	if #windows > 0 then
		windows[#windows]:focus()
	end
end)
