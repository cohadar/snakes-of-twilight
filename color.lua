--- @module color
local m_color = {}

-------------------------------------------------------------------------------
function m_color.white()
	love.graphics.setColor(0xFF, 0xFF, 0xFF, 0xFF)
end

-------------------------------------------------------------------------------
function m_color.black()
	love.graphics.setColor(0x00, 0x00, 0x00, 0xFF)
end

-------------------------------------------------------------------------------
function m_color.snake_a()
	love.graphics.setColor(0x03, 0x43, 0xDF, 0xFF)
end

-------------------------------------------------------------------------------
function m_color.snake_a_head()
	love.graphics.setColor(0x95, 0xD0, 0xFC, 0xFF)
end

-------------------------------------------------------------------------------
function m_color.snake_b()
	love.graphics.setColor(0x15, 0xB0, 0x1A, 0xFF)
end

-------------------------------------------------------------------------------
function m_color.snake_b_head()
	love.graphics.setColor(0x96, 0xF9, 0x7B, 0xFF)
end

-------------------------------------------------------------------------------
function m_color.background_1()
	love.graphics.setColor(0xD1, 0xB2, 0x6F, 0xFF)
end

-------------------------------------------------------------------------------
function m_color.background_2()
	love.graphics.setColor(0xC1, 0xA2, 0x5F, 0xFF)
end

-------------------------------------------------------------------------------
return m_color
