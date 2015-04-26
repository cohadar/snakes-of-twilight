--- @module draw
local m_draw = {}

-------------------------------------------------------------------------------
function m_draw.background_1(x, y)
	m_color.background_1()
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.background_2(x, y)
	m_color.background_2()
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.head_a(x, y)
	m_color.snake_a_head()
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.tail_a(x, y)
	m_color.snake_a()
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.head_b(x, y)
	m_color.snake_b_head()
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.tail_b(x, y)
	m_color.snake_b()
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.apple(x, y)
	love.graphics.setColor(0xE0, 0x00, 0x00, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.big_apple(x, y)
	love.graphics.setColor(0x7E, 0x1E, 0x9C, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect-1, g_rect-1)
end 

-------------------------------------------------------------------------------
function m_draw.pause_message()
	local x = math.floor(g_width * g_rect / 2)
	if g_the_end then
		if g_score_a > g_score_b then
			m_color.snake_a()
			love.graphics.print("Blue Wins", 0, -5)
		elseif g_score_a < g_score_b then
			m_color.snake_b()
			love.graphics.print("Green Wins", 0, -5)
		else
			m_color.white()
			love.graphics.print("It is a DRAW", 0, -5)
		end 
	else
		m_color.white()
		love.graphics.print("Press space" , 0, -5)
	end
end

-------------------------------------------------------------------------------
function m_draw.score()
	local x = math.floor(g_width * g_rect / 2)
	m_color.snake_a()
	love.graphics.print("" .. g_score_a, x-50, -5)
	m_color.white()
	love.graphics.print(":"            , x, -5)
	m_color.snake_b()
	love.graphics.print("" .. g_score_b, x + 35, -5)
end

-------------------------------------------------------------------------------
function m_draw.cell(x, y)
	if M(x, y).apples then
		if M(x, y).apples == APPLE_SIZE then
			m_draw.apple(x, y)
		else
			m_draw.big_apple(x, y)
		end
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
end

-------------------------------------------------------------------------------
return m_draw
