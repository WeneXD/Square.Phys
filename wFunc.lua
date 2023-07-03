gR=love.graphics
wnd={wd=gR.getWidth(),hg=gR.getHeight()} --window resoltuon width, height
gSpd=10 --10=normal speed
cMath={}
--wenefunctions :3
function cMath.clamp(x,min,max)
	if x>max then x=max end
	if x<min then x=min end
	return x
end

function cMath.dist(x1,y1,x2,y2)
	return math.sqrt((x1-x2)^2+(y1-y2)^2)
end