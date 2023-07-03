require("wFunc")
require("square")
require("control")
require("background")
require("texture")

function love.load()
	mouse.setGrabbed(true)
	sound.song0:setLooping(true)
	sound.song0:play()
	love.mouse.setCursor(texture.cursor)
end

function love.update(Dt)
	if not stop then
		Physics(Dt)
	end
	SquareMiddle()
	Mouse(Dt)
	Keyboard(Dt)
	Particles(Dt)
	Stats(Dt)
end

function love.draw()
	drawParticles()
		--Draw window boundaries
	gR.setLineWidth(30)
	gR.setColor(0.25,0.25,0.25,1)
	gR.rectangle("line",0,0,wnd.wd,wnd.hg)
	
		--Draw the square
	gR.setColor(1,1,1,1)
	gR.rectangle("fill",sq.x,sq.y,sq.sz,sq.sz)
	gR.setColor(0.15,0.15,0.15,0.75)
	gR.setLineWidth(6)
	gR.rectangle("line",sq.x,sq.y,sq.sz,sq.sz)
		
		--Draw the vector
	gR.setLineWidth(3)
	if sq.drawMV then
		gR.setColor(1,0,0,cMath.clamp(0.5*(math.sqrt((sq.mX-(sq.mX+sq.m.x))^2+(sq.mY-(sq.mY+sq.m.y))^2)/600),0,0.5))
		gR.line(sq.mX,sq.mY,sq.mX+sq.m.x/8,sq.mY-sq.m.y/8)
	end
	
		--Draw the throw vector
	gR.setColor(0,1,1,0.5)
	--gR.line(sq.mX,sq.mY,sq.mX-n.posDif[1]/4,sq.mY-n.posDif[2]/4)
	gR.line(n.pos1[1],n.pos1[2],n.pos2[1],n.pos2[2])
	
		--Draw the UI
	if sq.UI then
		gR.setColor(1,0,1,0.5)
		gR.rectangle("fill",0,wnd.hg-UI.offset1,150,UI.offset1)
		gR.setColor(1,1,1,1)
		gR.setLineWidth(2)
		gR.rectangle("line",0,wnd.hg-UI.offset1,150,UI.offset1)
		gR.setColor(0,1,0,1)
		gR.print("SPD[X/Y]: " .. math.floor(sq.m.x) .. "/" .. math.floor(sq.m.y),5,wnd.hg-20)
		gR.print("POS[X/Y]: " .. math.floor(sq.x) .. "/" .. math.floor(sq.y),5,wnd.hg-35)
		gR.print("---------------------",5,wnd.hg-50)
		gR.print("GameSPD/Grav: " .. gSpd,5,wnd.hg-65)
		gR.print("Bounce: " .. sq.bnc,5,wnd.hg-80)
		gR.print("ThrowPwr: " .. sq.throwPwr,5,wnd.hg-95)
		gR.print("Drag: " .. sq.drag,5,wnd.hg-110)
		gR.print("FPS: " .. love.timer.getFPS(),5,wnd.hg-130,0,1.25,1.25)
	end
	
		--Draw stats
	if tab then
		gR.setColor(1,1,1,0.5)
		gR.rectangle("fill",wnd.wd/2-UI.offset2/2,wnd.hg/2-UI.offset2/2,UI.offset2,UI.offset2)
		gR.setColor(0.25,0.75,1,1)
		gR.setLineWidth(4)
		gR.rectangle("line",wnd.wd/2-UI.offset2/2,wnd.hg/2-UI.offset2/2,UI.offset2,UI.offset2)
		gR.setColor(0.25,0.1,1,1)
		gR.print("Time: " .. math.floor(sq.tm) .. "s",wnd.wd/2-UI.offset2/3,wnd.hg/2-UI.offset2/3,0,1.3,1.3)
		gR.print("Bounces: " .. sq.bounces,wnd.wd/2-UI.offset2/3,(wnd.hg/2-UI.offset2/3)+23,0,1.3,1.3)
		gR.print("Distance: " .. math.floor(sq.distTravel),wnd.wd/2-UI.offset2/3,(wnd.hg/2-UI.offset2/3)+46,0,1.3,1.3)
		gR.print("Throws: " .. sq.throws,wnd.wd/2-UI.offset2/3,(wnd.hg/2-UI.offset2/3)+69,0,1.3,1.3)
		gR.print("Boosts: " .. sq.boosts,wnd.wd/2-UI.offset2/3,(wnd.hg/2-UI.offset2/3)+92,0,1.3,1.3)
	end
end
UI={
offset1=135,
offset2=175
}