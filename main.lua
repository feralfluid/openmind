local banner

function lovr.load()
    banner = lovr.graphics.newMaterial(lovr.graphics.newTexture("res/banner.png"))
end

function lovr.update(dt)

end

function lovr.draw()
    lovr.graphics.plane(banner, 0, 2, -1, 2, 1, math.pi / 2, 0, 0, 0)
    lovr.graphics.print("you are feeling verrryyy kitty...", 0, 1, -1, 0.5)
end
