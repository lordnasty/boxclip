--[[
 * Copyright (C) 2016 Ricky K. Thomson
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * u should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 --]]
 
traps = {}

traps_textures = {
	["log"] = love.graphics.newImage("data/images/traps/log.png"),
	["bridge"] = love.graphics.newImage("data/images/traps/bridge.png"),
	["brick"] = love.graphics.newImage("data/images/traps/brick.png"),
}


function traps:add(x,y,name)

	local gfx = traps_textures[name]

	if name == "brick" then
		table.insert(traps, {
			--dimensions
			x = x or 0,
			y = y or 0,
			w = gfx:getWidth()*2,
			h = gfx:getHeight()*2,
			--properties
			name = name,
			gfx = gfx,
			falling = false,
			timer = 0.00,
			mass = 800,
			segments = {
				[1] = {x=0,y=0 } ,
				[2] = {x=gfx:getWidth(),y=0 } ,
				[3] = {x=0,y=gfx:getHeight() } ,
				[4] = {x=gfx:getWidth(),y=gfx:getHeight() } ,
			},
			xvel = 100,
			yvel = 0,
			score = 100,
		})
		print(name .." added @  X:"..x.." Y: "..y)
	
		return
	end

	table.insert(traps, {
		--dimensions
		x = x or 0,
		y = y or 0,
		w = gfx:getWidth(),
		h = gfx:getHeight(),
		--properties
		name = name,
		gfx = gfx,
		falling = false,
		timer = 0.05,
		mass = 800,
		xvel = 0,
		yvel = 0,
	})
	print(name .." added @  X:"..x.." Y: "..y)
	
end

function traps:draw()
	local count = 0
	
	for i, trap in ipairs(traps) do
		if world:inview(trap) then
			count = count +1
					
			love.graphics.setColor(255,255,255,255)

			if trap.name == "brick"  then
				love.graphics.draw(trap.gfx, trap.x+trap.segments[1].x,trap.y+trap.segments[1].y,0, 1, 1)
				love.graphics.draw(trap.gfx, trap.x+trap.segments[2].x,trap.y+trap.segments[2].y,0, 1, 1)
				love.graphics.draw(trap.gfx, trap.x+trap.segments[3].x,trap.y+trap.segments[3].y,0, 1, 1)
				love.graphics.draw(trap.gfx, trap.x+trap.segments[4].x,trap.y+trap.segments[4].y,0, 1, 1)
			else
			
				love.graphics.draw(trap.gfx, trap.x,trap.y,0, 1, 1)
			end

			if editing or debug then
				traps:drawDebug(trap, i)
			end

		end
	end

	world.traps = count
end


function traps:drawDebug(trap, i)
	love.graphics.setColor(255,0,155,100)
	love.graphics.rectangle(
		"line", 
		trap.x, 
		trap.y, 
		trap.w, 
		trap.h
	)
	
	editor:drawid(trap, i)
	editor:drawCoordinates(trap)
end



