require("wFunc")
particles={}
t=0

function Particles(Dt)
	for i,v in pairs(particles)do
		v.x=v.x+v.spd.x*Dt
		v.y=v.y+v.spd.y*Dt
		v.life=v.life-Dt
		if v.life<0 then
			table.remove(particles,i)
		end
	end
	t=t+Dt
	if t>0.1 then
		addParticle()
		t=0
	end
end

function drawParticles()
	for i,v in pairs(particles)do
		gR.setColor(1,0.25,0.5,v.alpha*(v.life/v.maxLife))
		gR.circle("fill",v.x,v.y,v.sz)
	end
end

function addParticle()
	newPart={
		x=love.math.random(0,wnd.wd),
		y=wnd.hg+5,
		sz=love.math.random(2,7),
		spd={
		x=0,
		y=love.math.random(-20,-5)
		},
		maxLife=love.math.random(10,30),
		life=0,
		alpha=love.math.random(0.5,1)
	}
	newPart.life=newPart.maxLife
	table.insert(particles,newPart)
end