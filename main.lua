io.stdout:setvbuf("no")

m_apples = require "apples"
m_draw   = require "draw"

g_rect = 20
g_width = 0
g_height = 0
g_matrix = {}

g_ended = false

SNAKE_A = "SNAKE_A"
SNAKE_B = "SNAKE_B"

a_snake = require "snake"
package.loaded["snake"] = nil
b_snake = require "snake"
package.loaded["snake"] = nil

NORTH = "NORTH"
SOUTH = "SOUTH"
EAST  = "EAST"
WEST  = "WEST"

APPLE_SIZE = 4 -- number of snake segments eating one apple gives 

-------------------------------------------------------------------------------
function M(x, y) 
	return g_matrix[ y * g_width + x ]
end

-------------------------------------------------------------------------------
function love.load()
	g_width = math.floor(love.graphics.getWidth() / g_rect)
	g_height = math.floor(love.graphics.getHeight() / g_rect)

	for x = 0, g_width-1 do 
	for y = 0, g_height-1 do 
		g_matrix[ y * g_width + x ] = {}
	end
	end

	a_snake.init(SNAKE_A, 10, 10, EAST, 5)
	b_snake.init(SNAKE_B, 10, 20, EAST, 5)
end

-------------------------------------------------------------------------------
function love.update(dt)
	if g_ended then
		return 
	end
	a_snake.update(dt)
	b_snake.update(dt)
	if not m_apples.full() then
		local x = math.floor( love.math.random() * g_width )
		local y = math.floor( love.math.random() * g_height )
		if not M(x, y).apples then
			m_apples.add()
			M(x, y).apples = APPLE_SIZE
		end
	end
end

-------------------------------------------------------------------------------
function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	elseif key == "up" then
		a_snake.up()
	elseif key == "down" then
		a_snake.down()
	elseif key == "left" then
		a_snake.left()
	elseif key == "right" then
		a_snake.right()
	elseif key == "w" then
		b_snake.up()
	elseif key == "s" then
		b_snake.down()
	elseif key == "a" then
		b_snake.left()
	elseif key == "d" then
		b_snake.right()		
	end
end

-------------------------------------------------------------------------------
function love.draw()
	for x = 0, g_width-1 do 
		for y = 0, g_height-1 do 
			if M(x, y).apples then
				m_draw.apple(x, y)
			elseif M(x, y).data == SNAKE_A then
				if a_snake.is_head(x, y) then
					m_draw.head_a(x, y)
				else
					m_draw.tail_a(x, y)	
				end
			elseif M(x, y).data == SNAKE_B then
				if b_snake.is_head(x, y) then
					m_draw.head_b(x, y)
				else
					m_draw.tail_b(x, y)	
				end
			elseif x % 2 == 0 and y % 2 == 0 then
				m_draw.background_2(x, y)
			else
				m_draw.background_1(x, y)
			end
			m_draw.lines(x, y)
		end
	end
	-- love.graphics.print("x=".. a_head_x ..", y=" .. a_head_y, 100, 100)
end

-------------------------------------------------------------------------------
function love.quit()
	print("asta la vista baby")
end

