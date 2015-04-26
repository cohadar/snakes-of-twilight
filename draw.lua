--- @module draw
local m_draw = {}

-------------------------------------------------------------------------------
function m_draw.background_1(x, y)
	love.graphics.setColor(0xFF, 0xCC, 0x00, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function m_draw.background_2(x, y)
	love.graphics.setColor(0xEE, 0xBB, 0x00, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function m_draw.head_a(x, y)
	love.graphics.setColor(0xDD, 0xFF, 0xDD, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function m_draw.tail_a(x, y)
	love.graphics.setColor(0x77, 0x50, 0xDD, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function m_draw.head_b(x, y)
	love.graphics.setColor(0xDD, 0xDD, 0xFF, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function m_draw.apple(x, y)
	love.graphics.setColor(0xE0, 0x00, 0x00, 0xFF)
	love.graphics.rectangle("fill", x*g_rect, y*g_rect, g_rect, g_rect)
end 

-------------------------------------------------------------------------------
function m_draw.lines(x, y)
	love.graphics.setColor(0x00, 0x00, 0x00, 0x80)
	love.graphics.rectangle("line", x*g_rect, y*g_rect, g_rect, g_rect)
end

-------------------------------------------------------------------------------
return m_draw
