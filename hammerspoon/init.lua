hs.hotkey.bind({"cmd", "alt", "ctrl"}, "E", function()
  hs.alert.show("Hello World!")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  --     local win = hs.window.focusedWindow()
  --     local app = win:application()
  --     local bundleID = app:bundleID()
  -- local title = "Emacs"
  -- local informativeText = bundleID
  -- hs.notify.new({title=title, informativeText=informativeText}):send()
      -- hs.application.launchOrFocusByBundleID("org.gnu.Emacs")
      local windows = hs.window.allWindows()
      -- 在Lua中遍历表的方法：https://www.jianshu.com/p/de5a4b132918
      for _, win in pairs(windows) do
         local app = win:application()
         local bundleID = app:bundleID()
         if bundleID == "org.gnu.Emacs" then
            win:focus()
            -- hs.notify.new({title="title", informativeText="找到Emacs的窗口了"}):send()
         end
      end
end)

-- 来自这里：https://www.hammerspoon.org/go/#window-sizing
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- 检查窗口所属的应用是否为 Emacs。
  local app = win:application() -- 方法文档见[这里](https://www.hammerspoon.org/docs/hs.window.html#application)。
  local bundleID = app:bundleID() -- 方法文档见[这里](https://www.hammerspoon.org/docs/hs.application.html#bundleID)。
  local isEmacs = bundleID == "org.gnu.Emacs"

  -- f.x 表示窗口的左上角的横坐标，正方向为右。
  if isEmacs then
     f.x = max.x + (max.w / 3)
  else
     f.x = max.x + (max.w / 2)
  end

  -- f.y 表示窗口的左上角的纵坐标，正方向为下。
  f.y = max.y

  if isEmacs then
     f.w = max.w / 3 * 2
  else
     f.w = max.w / 2
  end

  f.h = max.h
  win:setFrame(f)
end)

-- 来自这里：https://www.hammerspoon.org/go/#window-sizing
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

