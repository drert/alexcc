x,y,z = gps.locate()
facing = 0 -- direction facing, 0 = start (north), 1-3 clockwise

function report() 

end

function CC() 
    turtle.turnRight()
    facing = (facing + 1) % 4
end

function CCW()
    turtle.turnRight()
    facing = (facing - 1) % 4
end

function NORTH()
    while(facing ~= 0) do
        CC()
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
    dy = yt - y
    dx = xt - x
    dz = zt - z

    UP(dy + 2)
    NORTH()
    if dz < 0 then
        FW(dz)
    else
        CC()
        CC()
        FW(dz)
    end
    NORTH()
    if dx < 0 then
        CCW()
        FW(dz)
    else
        CC()
        FW(dz)
    end
    DOWN(2)

    write(gps.locate())
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

checkInvFull()
goToCoords(-833, 63, 87)
