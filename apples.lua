--- @module apples
local m_apples = {}

local apples = {}

local max_apples = 0
local apple_count = 0

-------------------------------------------------------------------------------
function m_apples.init()
	max_apples = 17
	apple_count = 0
end

-------------------------------------------------------------------------------
function m_apples.eats(snake_id, num_eaten)
	if not apples[snake_id] then
		apples[snake_id] = 0
	end
	apples[snake_id] = apples[snake_id] + num_eaten
	apple_count = apple_count - 1
end

-------------------------------------------------------------------------------
function m_apples.digesting(snake_id)
	if not apples[snake_id] then
		apples[snake_id] = 0
	end
	if apples[snake_id] > 0 then
		apples[snake_id] = apples[snake_id] - 1
		return true
	end
	return false
end

-------------------------------------------------------------------------------
function m_apples.full()
	return apple_count >= max_apples
end

-------------------------------------------------------------------------------
function m_apples.add()
	apple_count = apple_count + 1
end 

-------------------------------------------------------------------------------
return m_apples
