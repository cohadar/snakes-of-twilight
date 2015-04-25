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

a_head_x = 0
a_head_y = 0

b_head_x = 0
b_head_y = 0

-------------------------------------------------------------------------------
function M(x, y) 
	return g_matrix[ y * g_width + x ]
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
	a_head_x = 10
	a_head_y = 10

	b_head_x = 10
	b_head_y = 20

	local head = M(a_head_x, a_head_y)
	head.a =  true
	head.a_prev_x = nil
	head.a_prev_y = nil
	head.a_next_x = a_head_x - 1
	head.a_next_y = a_head_y
	
	local body = M(a_head_x-1, a_head_y)
	body.a =  true
	body.a_prev_x = a_head_x
	body.a_prev_y = a_head_y
	body.a_next_x = a_head_x - 2
	body.a_next_y = a_head_y

	local tail = M(a_head_x-2, a_head_y)
	tail.a =  true
	tail.a_prev_x = a_head_x - 1
	tail.a_prev_y = a_head_y 
	tail.a_next_x = nil
	tail.a_next_y = nil

	a_tail_x = a_head_x - 2
	a_tail_y = a_head_y

	M(b_head_x, b_head_y).b = true
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
	local old_x = a_head_x
	local old_y = a_head_y
	local old_head = M(a_head_x, a_head_y)
	a_head_x = math.floor((a_head_x + dx + g_width) % g_width)
	a_head_y = math.floor((a_head_y + dy + g_height) % g_height)
	local head = M(a_head_x, a_head_y)
	head.a = true
	head.a_prev_x = nil
	head.a_prev_y = nil	
	head.a_next_x = old_x
	head.a_next_y = old_y
	old_head.a_prev_x = a_head_x
	old_head.a_prev_y = a_head_y
	local tail = M(a_tail_x, a_tail_y)
	tail.a = false
	a_tail_x = tail.a_prev_x
	a_tail_y = tail.a_prev_y
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
		if M(a_head_x, a_head_y).a_next_x ~= a_head_x then
			a_direction = NORTH
		end
	elseif key == "down" then
		if M(a_head_x, a_head_y).a_next_x ~= a_head_x then
			a_direction = SOUTH
		end
	elseif key == "left" then
		if M(a_head_x, a_head_y).a_next_y ~= a_head_y then
			a_direction = WEST
		end
	elseif key == "right" then
		if M(a_head_x, a_head_y).a_next_y ~= a_head_y then
			a_direction = EAST
		end
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
			if x == a_head_x and y == a_head_y then
				draw_head_a(x, y)
			elseif M(x, y).a then
				draw_tail_a(x, y)	
			elseif x == b_head_x and y == b_head_y then
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
	love.graphics.print("x=".. a_head_x ..", y=" .. a_head_y, 100, 100)
end

-------------------------------------------------------------------------------
function love.quit()
	print("asta la vista baby")
end

