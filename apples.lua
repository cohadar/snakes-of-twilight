--- @module apples
local m_apples = {}

local a_apples = 0
local b_apples = 0

local max_apples = 17
local apple_count = 0

-------------------------------------------------------------------------------
function m_apples.a_eats(num_eaten)
	a_apples = a_apples + num_eaten
	apple_count = apple_count - 1
end

-------------------------------------------------------------------------------
function m_apples.a_digesting()
	if a_apples > 0 then
		a_apples = a_apples - 1
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
