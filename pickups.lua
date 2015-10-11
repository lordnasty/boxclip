pickups = {}

pickups.w = 40
pickups.h = 40

function pickups:random(path)
	return love.graphics.newImage( path .. string.format("%04d",math.random(1, 7)) .. ".png")
end

function pickups:add(x,y,item)
	if item == "gem" then
		table.insert(pickups, {
			x =x or 0,
			y =y or 0,
			w = pickups.w,
			h = pickups.h,
			name = "gem",
			gfx = self:random("graphics/gems/"),
			collected = false
		})	
	elseif item =="life" then
		table.insert(pickups, {
			x =x or 0,
			y =y or 0,
			w = pickups.w,
			h = pickups.w,
			name = "life",
			gfx = love.graphics.newImage( "graphics/gems/" .. string.format("%04d",math.random(1, 7))  .. ".png"),
			collected = false
		})
	else
		util:dprint("error: unknown pickup type")
	end
end


function pickups:draw()
	local count = 0
	local i, pickup
	for i, pickup in ipairs(pickups) do
		if not pickup.collected and world:inview(pickup) then
			count = count + 1
			
			if pickup.name == "gem" then
				love.graphics.setColor(255,255,255,200)	
				love.graphics.draw(
					pickup.gfx, pickup.x, 
					pickup.y, 0, 1, 1
				)
			end
			
			if pickup.name == "life" then
				love.graphics.setColor(255,0,0, 255)	
				love.graphics.draw(
					pickup.gfx, pickup.x, 
					pickup.y, 0, 1, 1
				)
			end
		
			if editing then
				pickups:drawDebug(pickup, i)
			end
		end
	end
	world.pickups = count
end



function pickups:drawDebug(pickup, i)
	--requires graphic, implement all pickups as graphics/image
	love.graphics.setColor(100,255,100,100)
	love.graphics.rectangle(
		"line", 
		pickup.x, 
		pickup.y, 
		pickup.gfx:getWidth(), 
		pickup.gfx:getHeight()
	)
	util:drawid(pickup, i)
	util:drawCoordinates(pickup)
end

function pickups:destroy(pickups, i)
	-- fade/collect animation can be added
	table.remove(pickups, i)
end




