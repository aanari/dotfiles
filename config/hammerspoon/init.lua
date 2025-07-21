local spaces = require("hs.spaces") -- https://github.com/asmagill/hs._asm.spaces

-- Switch alacritty
hs.hotkey.bind({ "command" }, "escape", function()
	local BUNDLE_ID = "org.alacritty" -- more accurate to avoid mismatching on browser titles
	function moveWindow(alacritty, space, mainScreen)
		-- move to main space
		local win = nil
		while win == nil do
			win = alacritty:mainWindow()
		end
		print("win=" .. tostring(win))
		print("space=" .. tostring(space))
		print("screen=" .. tostring(win:screen()))
		print("mainScr=" .. tostring(mainScreen))
		if win:isFullScreen() then
			hs.eventtap.keyStroke("cmd", "return", 0, alacritty)
		end
		winFrame = win:frame()
		scrFrame = mainScreen:fullFrame()
		winFrame.w = scrFrame.w
		winFrame.y = scrFrame.y
		winFrame.x = scrFrame.x
		print("winFrame=" .. tostring(winFrame))
		win:setFrame(winFrame, 0)
		print("win:frame=" .. tostring(win:frame()))
		spaces.moveWindowToSpace(win, space)
		if win:isFullScreen() then
			hs.eventtap.keyStroke("cmd", "return", 0, alacritty)
		end
		win:focus()
	end
	local alacritty = hs.application.get(BUNDLE_ID)
	if alacritty ~= nil and alacritty:isFrontmost() then
		alacritty:hide()
	else
		local space = spaces.activeSpaceOnScreen()
		local mainScreen = hs.screen.mainScreen()
		if alacritty == nil and hs.application.launchOrFocusByBundleID(BUNDLE_ID) then
			local appWatcher = nil
			print("create app watcher")
			appWatcher = hs.application.watcher.new(function(name, event, app)
				print("name=" .. name)
				print("event=" .. event)
				if event == hs.application.watcher.launched and app:bundleID() == BUNDLE_ID then
					app:hide()
					moveWindow(app, space, mainScreen)
					print("stop watcher")
					appWatcher:stop()
				end
			end)
			print("start watcher")
			appWatcher:start()
		end
		if alacritty ~= nil then
			moveWindow(alacritty, space, mainScreen)
		end
	end
end)
