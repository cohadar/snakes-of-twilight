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
return m_draw
