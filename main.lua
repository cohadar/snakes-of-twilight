io.stdout:setvbuf("no")

g_rect = 20
g_width = 0
g_height = 0
g_matrix = {}

g_tick = 0
g_speed = 0.2 -- seconds

SNAKE_A = "SNAKE_A"
SNAKE_B = "SNAKE_B"

NORTH = "NORTH"
SOUTH = "SOUTH"
EAST  = "EAST"
WEST  = "WEST"

a_direction = EAST
b_direction = EAST

a_head = { x = 0, y = 0 }
b_head = { x = 0, y = 0 }

-------------------------------------------------------------------------------
function get_property(x, y, name) 
	return g_matrix[ y * g_width + x ][ name ]
end

-------------------------------------------------------------------------------
function set_property(x, y, name, value) 
	g_matrix[ y * g_width + x ][ name ] = value
end

-------------------------------------------------------------------------------
function love.load()
	-- g_background1 = love.graphics.newImage("tennis_ball.png")

	g_width = math.floor(love.graphics.getWidth() / g_rect)
	g_height = math.floor(love.graphics.getHeight() / g_rect)

	for x = 0, g_width-1 do 
	for y = 0, g_height-1 do 
		g_matrix[ y * g_width + x ] = {}
	end
	end
	a_head.x = 10
	a_head.y = 10

	b_head.x = 10
	b_head.y = 20
	set_property(a_head.x,   a_head.y, SNAKE_A, true)
	set_property(a_head.x-1, a_head.y, SNAKE_A, true)
	set_property(a_head.x-2, a_head.y, SNAKE_A, true)
	set_property(a_head.x-3, a_head.y, SNAKE_A, true)
	set_property(a_head.x-4, a_head.y, SNAKE_A, true)

	set_property(b_head.x, b_head.y, SNAKE_B, true)
end

-------------------------------------------------------------------------------
function update_snake_a()
	local dx = 0
	local dy = 0
	if     a_direction == NORTH then
		dx = 0
		dy = -1
	elseif a_direction == SOUTH then
		dx = 0
		dy = 1
	elseif a_direction == EAST then
		dx = 1
		dy = 0
	elseif a_direction == WEST then
		dx = -1
		dy = 0
	end
	set_property(a_head.x, a_head.y, SNAKE_A, false)
	a_head.x = math.floor((a_head.x + dx + g_width) % g_width)
	a_head.y = math.floor((a_head.y + dy + g_height) % g_height)
	set_property(a_head.x, a_head.y, SNAKE_A, true)
end 

-------------------------------------------------------------------------------
function update_snake_b()
end 

-------------------------------------------------------------------------------
function love.update(dt)
	g_tick = g_tick + dt
	if g_tick < g_speed then
		return
	end
	g_tick = g_tick - g_speed
	update_snake_a()
	update_snake_b()
end

-------------------------------------------------------------------------------
function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	elseif key == "up" then
		a_direction = NORTH
	elseif key == "down" then
		a_direction = SOUTH
	elseif key == "left" then
		a_direction = WEST
	elseif key == "right" then
		a_direction = EAST
	end
end


-------------------------------------------------------------------------------
function draw_background_1(x, y)
	love.graphics.setColor(0xFF, 0xCC, 0x00, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
	love.graphics.setColor(0x00, 0x00, 0x00, 0x80)
	love.graphics.rectangle("line", x*g_rect, y*g_rect, g_rect, g_rect)
end 


-------------------------------------------------------------------------------
function draw_background_2(x, y)
	love.graphics.setColor(0xEE, 0xBB, 0x00, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
	love.graphics.setColor(0x00, 0x00, 0x00, 0x80)
	love.graphics.rectangle("line", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function draw_head_a(x, y)
	love.graphics.setColor(0xDD, 0xFF, 0xDD, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function draw_tail_a(x, y)
	love.graphics.setColor(0x77, 0x50, 0xDD, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function draw_head_b(x, y)
	love.graphics.setColor(0xDD, 0xDD, 0xFF, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function love.draw()
	for x = 0, g_width-1 do 
		for y = 0, g_height-1 do 
			if get_property(x, y, SNAKE_A) then
				draw_head_a(x, y)
			elseif get_property(x, y, SNAKE_A) then
				draw_tail_a(x, y)	
			elseif get_property(x, y, SNAKE_B) then
				draw_head_b(x, y)
			elseif x % 2 == 0 and y % 2 == 0 then
				draw_background_2(x, y)
			else
				draw_background_1(x, y)
			end
			love.graphics.setColor(0x00, 0x00, 0x00, 0x80)
			love.graphics.rectangle("line", x*g_rect, y*g_rect, g_rect, g_rect)
		end
	end
	love.graphics.print("x=".. a_head.x ..", y=" .. a_head.y, 100, 100)
end

-------------------------------------------------------------------------------
function love.quit()
	print("asta la vista baby")
end

