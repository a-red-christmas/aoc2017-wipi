EAST = 0
NORTH = 1
WEST = 2
SOUTH = 3

Position = {}
Position.__index = Position
function Position:new(x, y)
    return setmetatable({x = x, y = y}, self)
end

function Position:to_string()
    return "{x=" .. self.x .. ",y=" .. self.y .. "}"
end

-- I know there's an O(1) formula that can calculate this, but I'm lazy and drinking.
function distance_from(n)
    local position = Position:new(0, 0)
    local direction = EAST
    local turning_counter = 0
    local turning_counter_max = 1
    local high = false
    for i = 1, n - 1 do
        if direction == EAST then
            position.x = position.x + 1
        elseif direction == NORTH then
            position.y = position.y - 1
        elseif direction == WEST then
            position.x = position.x - 1
        else
            position.y = position.y + 1
        end

        turning_counter = turning_counter - 1
        if turning_counter < 1 then
            if high then
                turning_counter_max = turning_counter_max + 1
            end

            high = not high
            turning_counter = turning_counter_max
            direction = (direction + 1) % 4
        end

        -- print(position:to_string())
    end

    return math.abs(position.x) + math.abs(position.y)
end

-- I know there's an O(1) formula that can calculate this, but I'm lazy and drinking.
function value_larger_than(n)
    local position = Position:new(0, 0)
    local values = {}
    values[position:to_string()] = 1
    local direction = EAST
    local turning_counter = 0
    local turning_counter_max = 1
    local high = false
    local i = 1
    while true do
        if direction == EAST then
            position.x = position.x + 1
        elseif direction == NORTH then
            position.y = position.y - 1
        elseif direction == WEST then
            position.x = position.x - 1
        else
            position.y = position.y + 1
        end

        local value = 0
        for x = -1, 1 do
            for y = -1, 1 do
                local other_position = Position:new(position.x + x, position.y + y)
                local other_position_key = other_position:to_string()
                if values[other_position_key] then
                    value = value + values[other_position_key]
                end
            end
        end

        if value > n then return value end
        values[position:to_string()] = value

        turning_counter = turning_counter - 1
        if turning_counter < 1 then
            if high then
                turning_counter_max = turning_counter_max + 1
            end

            high = not high
            turning_counter = turning_counter_max
            direction = (direction + 1) % 4
        end

        print(position:to_string())
    end

    return values[position:to_string()]
end

print(value_larger_than(325489))