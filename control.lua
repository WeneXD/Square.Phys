mouse=love.mouse
kb=love.keyboard
shft=false
tab=false
require("square")
require("wFunc")
require("sound")
dt=0
n=
{
pos1={0,0},
pos2={0,0},
posGot=false,
posDif={0,0}
}
function Mouse(Dt)
	dt=Dt
	dwn=mouse.isDown(1)
	dwnM=mouse.isDown(2)
	--Add momentum to square
	if dwn then
		if not n.posGot then
			n.pos1[1],n.pos1[2]=mouse.getPosition()
			n.posGot=true
		end
		n.pos2[1],n.pos2[2]=mouse.getPosition()
	end
	--Throw Square
	if dwnM and not dwn then
		stop=true
		if not n.posGot then
			n.pos1[1],n.pos1[2]=mouse.getPosition()
			sq.x=n.pos1[1]-sq.sz/2
			sq.y=n.pos1[2]-sq.sz/2
			n.posGot=true
			sq.m.x=0
			sq.m.y=0
		end
		n.pos2[1],n.pos2[2]=mouse.getPosition()
	end
	n.posDif[1]=n.pos1[1]-n.pos2[1]
	n.posDif[2]=n.pos1[2]-n.pos2[2]
	if not dwn and not stop and n.posGot then
		sq.m.x=sq.m.x-n.posDif[1]*2*gSpd/10
		sq.m.y=sq.m.y+n.posDif[2]*2*gSpd/10
		sq.boosts=sq.boosts+1
		n=
		{
		pos1={0,0},
		pos2={0,0},
		posGot=false,
		posDif={0,0}
		}
	end
	if not dwnM and stop then
		n.posGot=false
		stop=false
		if sound.throw:isPlaying() then
			sound.throw:stop()
		end
		sound.throw:setPitch(cMath.clamp(cMath.dist(n.pos1[1],n.pos1[2],n.pos2[1],n.pos2[2])/250,0.8,1.5)+love.math.random(-3,3)/10)
		sound.throw:play()
		sq.throws=sq.throws+1
		print(n.posDif[1])
		print(n.posDif[2])
		sq.m.x=n.posDif[1]*(2*gSpd/10)*sq.throwPwr
		sq.m.y=-n.posDif[2]*(2*gSpd/10)*sq.throwPwr
		n=
		{
		pos1={0,0},
		pos2={0,0},
		posGot=false,
		posDif={0,0}
		}
	end
end

function Keyboard(Dt)
	if kb.isDown("lshift") then
		shft=true
	else
		shft=false
	end
	if kb.isDown("tab") then
		tab=true
	else
		tab=false
	end
	print(tab)
end

function love.keypressed(k)
	if k=="up" then
		if not shft then
			gSpd=cMath.clamp(gSpd+1,1,50)
		else
			sq.throwPwr=cMath.clamp(sq.throwPwr+0.1,0.1,3)
		end
	end
	if k=="down" then
		if not shft then
			gSpd=cMath.clamp(gSpd-1,1,50)
		else
			sq.throwPwr=cMath.clamp(sq.throwPwr-0.1,0.1,3)
		end
	end
	if k=="left" then
		if not shft then
			sq.bnc=cMath.clamp(sq.bnc-0.05,0,1.5)
		else
			sq.drag=cMath.clamp(sq.drag-0.05,0.1,2)
		end
	end
	if k=="right" then
		if not shft then
			sq.bnc=cMath.clamp(sq.bnc+0.05,0,1.5)
		else
			sq.drag=cMath.clamp(sq.drag+0.05,0.1,2)
		end
	end
	if k=="q" then
		if not shft then
			sq.drawMV=not sq.drawMV
		else
			sq.UI=not sq.UI
		end
	end
	if k=="m" then
		if not shft then
			if sound.song0:isPlaying() then
				sound.song0:pause()
			else
				sound.song0:play()
			end
		else
			if love.audio.getVolume()>0 then
				love.audio.setVolume(0)
			else
				love.audio.setVolume(1)
			end
		end
	end
end