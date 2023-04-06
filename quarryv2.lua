x,y,z = gps.locate()
facing = 0 -- direction facing, 0 = start (north), 1-3 clockwise
minDepth = -58

dCx = 0
dCy = 0
dCz = 0
fCx = 0
fCy = 0
fCz = 0
dCx, dCy, dCz = -847, 62, 99
fCx, fCy, fCz = 0, 0, 0

function report() 

end

function CW() 
    turtle.turnRight()
    facing = (facing + 1) % 4
end

function CCW()
    turtle.turnLeft()
    facing = (facing - 1) % 4
end

function NORTH()
    while(facing ~= 0) do
        CW()
    end
end

function DOWN(dist)
    for i = 1, dist, 1 do
        turtle.digDown()
        turtle.down()
    end
end

function UP(dist)
    for i = 1, dist, 1 do
        turtle.digUp()
        turtle.up()
    end
end

function FW(dist)
    for i = 1, dist, 1 do
        turtle.dig()
        turtle.forward()
    end
end

function Home() 
    write("Turtle Returning Home")
end

function goToCoords(xt, yt, zt)
    x, y, z = gps.locate()
    write(x)
    write(" ")
    write(y)
    write(" ")
    write(z)
    write(" ")

    dx = xt - x
    dy = yt - y
    dz = zt - z

    UP(dy + 2)
    NORTH()
    if dz < 0 then
        FW(-1 * dz)
    else
        CW()
        CW()
        FW(dz)
    end
    NORTH()
    if dx < 0 then
        CCW()
        FW(-1 * dx)
    else
        CW()
        FW(dx)
    end
    DOWN(2)

    x,y,z = gps.locate()
    write(x)
    write(" ")
    write(y)
    write(" ")
    write(z)
    write(" ")
end

function checkInvFull()
    for i=1, 16, 1 do
        turtle.select(i)
        ct = turtle.getItemCount()
        if ct == 0 then 
            write("Inventory is not full.")
            return false
        end
    end
    write("Inventory is full.")
    return true
end

function digSquare(sLen)
    local digDist = sLen - 1
    local duoEnd = sLen / 2
    for i = 0, duoEnd-1, 1 do
        FW(digDist)
        CCW()
        FW(1)
        CCW()
        FW(digDist)
        CW()
        if i ~= (duoEnd - 1) then
            FW(1)
        end
        CW()
    end
    CW()
end

function dumpAll()
    for i=1, 16, 1 do
        turtle.select(i)
        turtle.drop()
    end
end

function Quarry(side)
    x, y, z = gps.locate()
    while(y >= minDepth) do
        digSquare(side)
        rx, ry, rz = gps.locate()
        rfacing = facing
        
        if checkInvFull() then
            goToCoords(dCx, dCy, dCz)
            NORTH()
            dumpAll()
            goToCoords(rx, ry, rz)
            NORTH()
            for i=0, rfacing, 1 do
                CW()
            end
        end
        DOWN(1)
    end
end
checkInvFull()
turtle.select(1)
goToCoords(-841, 61, 104)
NORTH()
Quarry(8)

dumpAll()
