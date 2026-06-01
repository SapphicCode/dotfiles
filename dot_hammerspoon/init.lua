-- Auto-close specific applications if they have zero windows and lose focus
local function table_contains(tbl, element)
  for _, value in ipairs(tbl) do
    if value == element then
      return true
    end
  end
  return false
end

local function closeIfZero(appName)
  local app = hs.application.get(appName)
  if app and #app:allWindows() == 0 then
    app:kill()
  end
end

local excludedApps = {
  "Steam",
  "Music",
  "Overcast",
}

hs.application.watcher.new(function(name, event, app)
  if event == hs.application.watcher.deactivated and not table_contains(excludedApps, name) then
    closeIfZero(name)
  end
end):start()

-- Automatically align some windows when focused
local windowRatios = {
  ["Helium"] = "twoThirds",
  ["Zen"] = "twoThirds",
  ["Code"] = "fullscreen",
  ["Microsoft Teams"] = "fullscreen",
}

local screenRatios = {
  ["LG ULTRAGEAR (2)"] = "twoThirdsRight",
  ["LG ULTRAGEAR (1)"] = "twoThirdsLeft",
}

local function alignWindow(win)
  if not win:isStandard() then
    return -- not a standard window, do nothing
  end

  local screen = win:screen()
  local screenFrame = screen:frame()
  local screenFrameUsable = hs.geometry.rect(screenFrame.x + 12, screenFrame.y + 12, screenFrame.w - 24,
    screenFrame.h - 24)

  local twoThirdsLeft = hs.geometry.rect(screenFrameUsable.x, screenFrameUsable.y, screenFrameUsable.w * 2 / 3,
    screenFrameUsable.h)
  local twoThirdsRight = hs.geometry.rect(screenFrameUsable.x + screenFrameUsable.w / 3, screenFrameUsable.y,
    screenFrameUsable.w * 2 / 3,
    screenFrameUsable.h)

  local targetRatio = windowRatios[win:application():name()]
  if not targetRatio then
    return -- no match for this app, do nothing
  end

  local targetRatioByScreen = screenRatios[screen:name()]
  if targetRatio == "fullscreen" then
    win:setFrame(screenFrameUsable)
  elseif targetRatio == "twoThirds" and targetRatioByScreen == "twoThirdsLeft" then
    win:setFrame(twoThirdsLeft)
  elseif targetRatio == "twoThirds" and targetRatioByScreen == "twoThirdsRight" then
    win:setFrame(twoThirdsRight)
  end
end

-- Automatically assign some windows to specific spaces based on window title
local spaceAssignments = {
  ["~/dev/work/"] = { 3, 4 },
  ["simone"] = { 3, 4 },
}

local function assignSpace(win)
  local title = win:title()

  -- check if window not already in allowed space
  local currentSpace = win:space()

  for pattern, spaces in pairs(spaceAssignments) do
    if string.match(title, pattern) then
      local space = spaces[1] -- For simplicity, just use the first space in the list
      hs.spaces.moveWindowToSpace(win:id(), space)
      break
    end
  end
end

-- Subscribe event handlers
local windowFilter = hs.window.filter.new()
windowFilter:subscribe(hs.window.filter.windowCreated, function(win)
  alignWindow(win)
end)
windowFilter:subscribe(hs.window.filter.windowFocused, function(win)
  alignWindow(win)
end)
