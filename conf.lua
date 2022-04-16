function lovr.conf(t)
    -- set the project version and identity
    t.version = "0.15.0"
    t.identity = "default"

    -- set save directory precedence
    t.saveprecedence = true

    -- enable or disable different modules
    t.modules.audio = true
    t.modules.data = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.headset = true
    t.modules.math = true
    t.modules.physics = true
    t.modules.system = true
    t.modules.thread = true
    t.modules.timer = true

    -- audio
    t.audio.spatializer = nil
    t.audio.start = true

    -- graphics
    t.graphics.debug = false

    -- headset settings
    t.headset.drivers = { "openxr", "oculus", "vrapi", "pico", "openvr", "webxr", "desktop" }
    t.headset.supersample = false
    t.headset.offset = 1.7
    t.headset.msaa = 4

    -- math settings
    t.math.globals = true

    -- configure the desktop window
    t.window.width = 1080
    t.window.height = 600
    t.window.fullscreen = false
    t.window.msaa = 0
    t.window.vsync = 1
    t.window.title = "openmind"
    t.window.icon = "res/icon.png"
end
