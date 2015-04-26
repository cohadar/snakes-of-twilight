--- @module snake
local m_snake = {}

local tick = 0
-- affected by haste/slow items
local speed = 0.15 -- seconds

local head_x = 0
local head_y = 0

local tail_x = 0
local tail_y = 0

local id = "x"

local dead = false

local direction = EAST

-------------------------------------------------------------------------------
function m_snake.init(snake_id, x, y, _direction, size)
	direction = _direction
	id = snake_id

	head_x = x
	head_y = y

	local head  = M(head_x, head_y)
	head.data   = snake_id
	head.prev_x = nil
	head.prev_y = nil
	head.next_x = nil
	head.next_y = nil

	tail_x = head_x
	tail_y = head_y

	m_apples.eats(snake_id, size - 1)
end

-------------------------------------------------------------------------------
local function update_snake()
	local dx = 0
	local dy = 0
	if     direction == NORTH then
		dx = 0
		dy = -1
	elseif direction == SOUTH then
		dx = 0
		dy = 1
	elseif direction == EAST then
		dx = 1
		dy = 0
	elseif direction == WEST then
		dx = -1
		dy = 0
	end
	local old_x = head_x
	local old_y = head_y
	local old_head = M(head_x, head_y)
	head_x = math.floor((head_x + dx + g_width) % g_width)
	head_y = math.floor((head_y + dy + g_height) % g_height)
	local head = M(head_x, head_y)
	if head.data then
		dead = true
		g_ended = true
	end 
	head.data = id
	head.prev_x = nil
	head.prev_y = nil	
	head.next_x = old_x
	head.next_y = old_y
	old_head.prev_x = head_x
	old_head.prev_y = head_y
	local tail = M(tail_x, tail_y)
	if M(head_x, head_y).apples then
		m_apples.eats(id, M(head_x, head_y).apples)
		M(head_x, head_y).apples = nil
	end
	if not m_apples.digesting(id) then
		tail.data = false
		tail_x = tail.prev_x
		tail_y = tail.prev_y
	end
end 

-------------------------------------------------------------------------------
function m_snake.update(dt)
	tick = tick + dt
	if tick >= speed then
		tick = tick - speed
		update_snake()
	end
end

-------------------------------------------------------------------------------
function m_snake.up()
	if M(head_x, head_y).next_x ~= head_x then
		direction = NORTH
	end
end

-------------------------------------------------------------------------------
function m_snake.down()
	if M(head_x, head_y).next_x ~= head_x then
		direction = SOUTH
	end	
end

-------------------------------------------------------------------------------
function m_snake.left()
	if M(head_x, head_y).next_y ~= head_y then
		direction = WEST
	end
end

-------------------------------------------------------------------------------
function m_snake.right()
	if M(head_x, head_y).next_y ~= head_y then
		direction = EAST
	end	
end

-------------------------------------------------------------------------------
function m_snake.is_head(x, y)
	return x == head_x and y == head_y
end

-------------------------------------------------------------------------------
function m_snake.is_dead()
	return dead
end

-------------------------------------------------------------------------------
return m_snake
