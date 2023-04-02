-- Quarry Script 

function fDM(int) 
    local lEnd = int - 1
    for i = 0, lEnd, 1 do
        turtle.dig()
        turtle.forward()
    end
end

function digSquare(sLen)
    local digDist = sLen - 1
    local duoEnd = sLen / 2
    for i = 0, duoEnd-1, 1 do
        fDM(digDist)
        turtle.turnLeft()
        fDM(1)
        turtle.turnLeft()
        fDM(digDist)
        turtle.turnRight()
        if i ~= (duoEnd - 1) then
            fDigMove(1)
        end
        turtle.turnRight()
    end
    turtle.turnRight()
end

-- downward quarry given side, depth
function Quarry(side, depth)
    for i = 0, depth-2, 1 do
        digSquare(side)
        turtle.digDown()
        turtle.down()
    end
    for i = 0, depth-2, 1 do
        turtle.up()
    end
end

Quarry(8, 8)

