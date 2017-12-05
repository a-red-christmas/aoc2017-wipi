EAST = 0
NORTH = 1
WEST = 2
SOUTH = 3

-- I know there's an O(1) formula that can calculate this, but I'm lazy and drinking.
function distance_from(n)
    local position = {x = 0, y = 0}
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

        -- print(position.x .. " " .. position.y)
    end

    return math.abs(position.x) + math.abs(position.y)
end

print(distance_from(325489))