io.stdout:setvbuf("no")

m_apples = require "apples"
m_draw   = require "draw"
m_color  = require "color"

g_offset_x = 0
g_offset_y = 50.0

g_rect = 20
g_width = 0
g_height = 0
g_matrix = {}

MAX_SCORE = 5
g_score_a = 0
g_score_b = 0
g_ended = false
g_game_end = false 

g_pause = true

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
function reset_level()
	for x = 0, g_width-1 do 
	for y = 0, g_height-1 do 
		g_matrix[ y * g_width + x ] = {}
	end
	end
	a_snake.init(SNAKE_A, 10, 10, EAST, 5)
	b_snake.init(SNAKE_B, 10, 20, EAST, 5)
	m_apples.init()
end

-------------------------------------------------------------------------------
function love.load()
	g_width = math.floor((love.graphics.getWidth() - g_offset_x) / g_rect)
	g_height = math.floor((love.graphics.getHeight() - g_offset_y) / g_rect) 
	local font = love.graphics.newFont("OpenSans-Regular.ttf", 40)
	love.graphics.setFont(font)
	reset_level()
end

-------------------------------------------------------------------------------
function love.update(dt)
	if g_ended or g_pause then
		return 
	end
	if not m_apples.full() then
		local x = math.floor( love.math.random() * g_width )
		local y = math.floor( love.math.random() * g_height )
		if not M(x, y).apples then
			m_apples.add()
			M(x, y).apples = APPLE_SIZE
		end
	end
	a_snake.update(dt)
	b_snake.update(dt)

	if a_snake.is_dead() then
		g_score_b = g_score_b + 1
	end
	if b_snake.is_dead() then
		g_score_a = g_score_a + 1
	end
	if g_score_a == MAX_SCORE or g_score_b == MAX_SCORE then
		g_the_end = true
	end 
end

-------------------------------------------------------------------------------
function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
		return
	end	
	if key == " " then
		if g_the_end then
			love.event.push("quit")
			return
		end
		g_pause = not g_pause
		if g_ended then
			g_ended = false
			reset_level()
		end
	end
	if g_pause then
		return
	end

	if key == "up" then
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
	m_color.black()
	love.graphics.rectangle("fill", 0, 0, g_width * g_rect, g_offset_y)
	if g_pause then
		m_draw.pause_message()
	end
	m_draw.score()

	love.graphics.push()
	love.graphics.translate(g_offset_x, g_offset_y)
	for x = 0, g_width-1 do 
		for y = 0, g_height-1 do 
			m_draw.cell(x, y)
		end
	end
	love.graphics.pop()
end

-------------------------------------------------------------------------------
function love.quit()
	print("asta la vista baby")
end

