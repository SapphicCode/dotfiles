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
