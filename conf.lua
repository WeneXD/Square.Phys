require("asetukset")
function love.conf(t)
	t.window.title = "Square.phys"
	t.window.width = asetus.Width
	t.window.height = asetus.Height
	t.window.borderless = asetus.Borderless
	t.window.vsync = asetus.VSync
end
