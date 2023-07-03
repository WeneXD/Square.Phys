require("wFunc")
require("sound")
sq=
{
	sz=42,	--Size
	x=0,	--X-coordinate
	y=0,	--Y-coordinate
	mX=0,	--Middle of the square (X-axis)
	mY=0,	--Middle of the square (Y-axis)
	m=	--Momentum
	{
		x=0,	--Amount of momentum on the X-axis
		y=0,	--Amount of momentum on the Y-axis
	},
	ground=false,
	bnc=0.5, --bounce
	throwPwr=1, --throwing power
	drag=1, --drag
	drawMV=true, --Draw Momentum Vector
	UI=true,
	bounces=0,
	tm=0,
	distTravel=0,
	throws=0,
	boosts=0
}
stop=false

function SquareMiddle()
	sq.mX=sq.x+sq.sz/2
	sq.mY=sq.y+sq.sz/2
end

sq.x=wnd.wd/2-sq.sz/2
sq.y=15

function Stats(Dt)
	sq.tm=sq.tm+Dt
	a=math.sqrt(sq.m.x^2+sq.m.y^2)
	if a>10 then
		sq.distTravel=sq.distTravel+a/10000
	end
end

function Physics(Dt)
	sq.m.y=sq.m.y-(50+(sq.m.y^2)/1000000)*Dt*gSpd
	if sq.y+sq.sz>wnd.hg-15 and sq.m.y<0 then
		sq.m.y=sq.m.y*(-sq.bnc)
		Stomp(sq.m.y)
	elseif sq.y<15 and sq.m.y>0 then
		sq.m.y=sq.m.y*(-sq.bnc)
		Stomp(sq.m.y)
	end
	if sq.x+sq.sz>wnd.wd-15 and sq.m.x>0 then
		sq.m.x=sq.m.x*(-sq.bnc)
		Stomp(sq.m.x)
	elseif sq.x<15 and sq.m.x<0 then
		sq.m.x=sq.m.x*(-sq.bnc)
		Stomp(sq.m.x)
	end
	sq.m.y=sq.m.y+(sq.m.y*-0.05)*Dt*gSpd*sq.drag
	sq.m.x=sq.m.x+(sq.m.x*-0.05)*Dt*gSpd*sq.drag
	if math.sqrt(sq.m.x^2)>3 then
		sq.x=sq.x+sq.m.x*Dt
	end
	if math.sqrt(sq.m.y^2)>3 then
		sq.y=sq.y-sq.m.y*Dt
	end
end

function Stomp(spd)
	spd=math.sqrt(spd^2)
	if sound.stomp:isPlaying() and spd>20*sq.bnc then
		sound.stomp:stop()
	end
	sound.stomp:setPitch(cMath.clamp(spd/100,0.75,1.1))
	sound.stomp:setVolume(cMath.clamp(spd/10,0,1))
	if spd>20*sq.bnc then
		sq.bounces=sq.bounces+1
		sound.stomp:play()
	end
end