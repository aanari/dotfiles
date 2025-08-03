local spaces = require("hs.spaces") -- https://github.com/asmagill/hs._asm.spaces

-- Switch wezterm (Quake-style dropdown)
hs.hotkey.bind({ "command" }, "escape", function()
	local BUNDLE_ID = "com.github.wez.wezterm"
	local QUAKE_HEIGHT_RATIO = 0.4  -- Terminal takes up 40% of screen height
	
	function setupQuakeWindow(wezterm, space, mainScreen)
		-- Setup quake-style window
		local win = nil
		while win == nil do
			win = wezterm:mainWindow()
		end
		
		-- Exit fullscreen if needed
		if win:isFullScreen() then
			hs.eventtap.keyStroke("cmd", "return", 0, wezterm)
		end
		
		-- Set window frame to drop-down style
		local scrFrame = mainScreen:fullFrame()
		local winFrame = {}
		winFrame.w = scrFrame.w
		winFrame.h = scrFrame.h * QUAKE_HEIGHT_RATIO
		winFrame.x = scrFrame.x
		winFrame.y = scrFrame.y
		
		win:setFrame(winFrame, 0)
		spaces.moveWindowToSpace(win, space)
		win:focus()
		
		-- Raise window to front
		win:raise()
	end
	
	local wezterm = hs.application.get(BUNDLE_ID)
	if wezterm ~= nil and wezterm:isFrontmost() then
		wezterm:hide()
	else
		local space = spaces.activeSpaceOnScreen()
		local mainScreen = hs.screen.mainScreen()
		if wezterm == nil and hs.application.launchOrFocusByBundleID(BUNDLE_ID) then
			local appWatcher = nil
			appWatcher = hs.application.watcher.new(function(name, event, app)
				if event == hs.application.watcher.launched and app:bundleID() == BUNDLE_ID then
					app:hide()
					setupQuakeWindow(app, space, mainScreen)
					appWatcher:stop()
				end
			end)
			appWatcher:start()
		end
		if wezterm ~= nil then
			setupQuakeWindow(wezterm, space, mainScreen)
		end
	end
end)
