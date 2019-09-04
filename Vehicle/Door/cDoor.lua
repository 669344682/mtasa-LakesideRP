local screenWidth, screenHeight = guiGetScreenSize()
local root = getRootElement();
local player = getLocalPlayer();
local minDistance = 5;
local interactButton = "L";
local isDebug = "false";
local lookAtVehicle = nil;
local doorName = "";
        
function interactVehicle()
    lookAtVehicle = getPedTarget(player);
    
    if not (isPedInVehicle(player)) then
        if (lookAtVehicle) and (getElementType(lookAtVehicle) == "vehicle" ) then
            --local dx, dy, dz = getVehicleComponentPosition(lookAtVehicle, "door_1"); -- wont work at the moment BugTracker ID:7487
            local vx, vy, vz = getElementPosition(lookAtVehicle);
            local rxv, ryv, rzv = getElementRotation(lookAtVehicle)
            local px, py, pz = getElementPosition(player);
            local distanceToVehicle = getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz);

            if (isDebug == "true") then
                --showPlayerHudComponent("all", false);
                dxDrawText("Vehicle: " .. getVehicleName(lookAtVehicle) .. ", ID: " .. getElementModel(lookAtVehicle), screenWidth/2, screenHeight/2 - 200, screenWidth/2, screenHeight/2 - 200, tocolor(255, 255, 255, 255), 1, "arial", "center", "center", false, false, true);
                dxDrawText("Vehicle type: " .. getInteractableVehicleType(lookAtVehicle), screenWidth/2, screenHeight/2 - 185, screenWidth/2, screenHeight/2 - 185, tocolor(110, 200, 200, 255), 1, "arial", "center", "center", false, false, true);
                dxDrawText("Distance: " .. string.format("%.2f", distanceToVehicle) .. " m", screenWidth/2, screenHeight/2 - 170, screenWidth/2, screenHeight/2 - 170, tocolor(0, 255, 0, 255), 1, "arial", "center", "center", false, false, true);
                dxDrawText("Player rotation: " .. getPlayerToVehicleRelatedPosition(), screenWidth/2, screenHeight/2 - 155, screenWidth/2, screenHeight/2 - 155, tocolor(110, 110, 200, 255), 1, "arial", "center", "center", false, false, true);
                
                if(isInteractableVehicle(lookAtVehicle) == "true") then
                    dxDrawText("Interactions possible for this vehicle.", screenWidth/2, screenHeight/2 - 140, screenWidth/2, screenHeight/2 - 140, tocolor(255, 0, 255, 255), 1, "arial", "center", "center", false, false, true);
                else
                    dxDrawText("No interactions possible for this vehicle!", screenWidth/2, screenHeight/2 - 140, screenWidth/2, screenHeight/2 - 140, tocolor(255, 0, 0, 255), 1, "arial", "center", "center", false, false, true);
                end
                
                dxDrawLine3D(vx, vy, vz, px, py, vz, tocolor(0, 120, 0, 150), 2);
            end
                
            if(isInteractableVehicle(lookAtVehicle) == "true") then                
                if (distanceToVehicle < minDistance) and (getDoor(lookAtVehicle)) then
                    if (not isVehicleLocked(lookAtVehicle)) then
                        local checkDoor = getVehicleDoorState(lookAtVehicle, getDoor(lookAtVehicle));
                        
                        -- 0 (hood), 1 (trunk), 2 (front left), 3 (front right), 4 (rear left), 5 (rear right)
                        if (getDoor(lookAtVehicle) == 0) then
                            doorName = "hood";
                        elseif (getDoor(lookAtVehicle) == 1) then
                            doorName = "trunk";
                        elseif (getDoor(lookAtVehicle) == 2) then
                            doorName = "front left door";
                        elseif (getDoor(lookAtVehicle) == 3) then
                            doorName = "front right door";
                        elseif (getDoor(lookAtVehicle) == 4) then
                            doorName = "rear left door";
                        elseif (getDoor(lookAtVehicle) == 5) then
                            doorName = "rear right door";
                        end
                        
                        if (checkDoor ~= 4 ) then
                            local doorRatio = getVehicleDoorOpenRatio(lookAtVehicle, getDoor(lookAtVehicle));
                            dxDrawRectangle ( screenWidth/2 - 100, screenHeight/2 - 8, 200, 16, tocolor( 0, 0, 0, 90 ));
                            
                            if (doorRatio <= 0) then
                                dxDrawText("#FFFFFFPress #00FF00" .. interactButton .. "#FFFFFF to open #00FF00" .. doorName .. "#FFFFFF!", screenWidth/2, screenHeight/2, screenWidth/2, screenHeight/2, tocolor(255, 255, 255, 255), 1, "arial", "center", "center", false, false, false, true, true);
                            else
                                dxDrawText("#FFFFFFPress #00FF00" .. interactButton .. "#FFFFFF to close #00FF00" .. doorName .. "#FFFFFF!", screenWidth/2, screenHeight/2, screenWidth/2, screenHeight/2, tocolor(255, 255, 255, 255), 1, "arial", "center", "center", false, false, false, true, true);
                            end 
                        end
                    else
                        dxDrawRectangle ( screenWidth/2 - 100, screenHeight/2 - 8, 200, 16, tocolor( 0, 0, 0, 90 ));
                        dxDrawText("#FF0000 Vehicle is locked!", screenWidth/2, screenHeight/2, screenWidth/2, screenHeight/2, tocolor(255, 255, 255, 255), 1, "arial", "center", "center", false, false, false, true, true);
                    end           
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, interactVehicle);


function getPlayerToVehicleRelatedPosition()    
    if (lookAtVehicle) and (getElementType(lookAtVehicle) == "vehicle") then   
        local vx, vy, vz = getElementPosition(lookAtVehicle);
        local rxv, ryv, rzv = getElementRotation(lookAtVehicle);
        local px, py, pz = getElementPosition(player);
        local anglePlayerToVehicle = math.atan2(px - vx, py - vy);
        local formattedAnglePlayerToVehicle = math.deg(anglePlayerToVehicle) + 180;
        local vehicleRelatedPosition = formattedAnglePlayerToVehicle + rzv;
        
        if (vehicleRelatedPosition < 0) then
            vehicleRelatedPosition = vehicleRelatedPosition + 360
        elseif (vehicleRelatedPosition > 360) then
            vehicleRelatedPosition = vehicleRelatedPosition - 360
        end
        
        return math.floor(vehicleRelatedPosition) + 0.5;
    else
        return "false";
    end
end


function getDoor(lookAtVehicle)
    local vehicle = lookAtVehicle;
    
    if (getInteractableVehicleType(vehicle)) == "2 doors" then
        -- 0 (hood), 1 (trunk), 2 (front left), 3 (front right)
        if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
            return 0;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360)  or (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
            return 1;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 65) and (getPlayerToVehicleRelatedPosition() <= 120) then
            return 2;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 295) then
            return 3;
        end
    elseif (getInteractableVehicleType(vehicle)) == "2 doors, no trunk" then
        -- 0 (hood), 2 (front left), 3 (front right)
        if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
            return 0;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 65) and (getPlayerToVehicleRelatedPosition() <= 120) then
            return 2;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 295) then
            return 3;
        end
    elseif (getInteractableVehicleType(vehicle)) == "4 doors" then
        -- 0 (hood), 1 (trunk), 2 (front left), 3 (front right), 4 (rear left), 5 (rear right)
        if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
            return 0;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360)  or (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
            return 1;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 91) and (getPlayerToVehicleRelatedPosition() <= 120) then
            return 2;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 270) then
            return 3;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 60) and (getPlayerToVehicleRelatedPosition() <= 90) then
            return 4;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 271) and (getPlayerToVehicleRelatedPosition() <= 300) then
            return 5;
        end
    elseif (getInteractableVehicleType(vehicle)) == "Van" then
        -- 0 (hood), 2 (front left), 3 (front right), 4 (rear left at back), 5 (rear right at back)
        if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
            return 0;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 91) and (getPlayerToVehicleRelatedPosition() <= 130) then
            return 2;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 230) and (getPlayerToVehicleRelatedPosition() <= 270) then
            return 3;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
            return 4;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360) then
            return 5;
        end
    elseif (getInteractableVehicleType(vehicle)) == "Truck" then
        -- 0 (hood), 2 (front left), 3 (front right)
        if (getPlayerToVehicleRelatedPosition() >= 160) and (getPlayerToVehicleRelatedPosition() <= 200) then
            return 0;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 120) and (getPlayerToVehicleRelatedPosition() <= 155) then
            return 2;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 205) and (getPlayerToVehicleRelatedPosition() <= 230) then
            return 3;
        end
    elseif (getInteractableVehicleType(vehicle)) == "Special" then
        -- 2 (front left), 3 (front right)       
        if (getPlayerToVehicleRelatedPosition() >= 120) and (getPlayerToVehicleRelatedPosition() <= 155) then
            return 2;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 205) and (getPlayerToVehicleRelatedPosition() <= 230) then
            return 3;
        end
    elseif (getInteractableVehicleType(vehicle)) == "Stretch" then
        -- 0 (hood), 1 (trunk), 2 (front left), 3 (front right), 4 (rear left), 5 (rear right)
        if (getPlayerToVehicleRelatedPosition() >= 140) and (getPlayerToVehicleRelatedPosition() <= 220) then
            return 0;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 330) and (getPlayerToVehicleRelatedPosition() <= 360)  or (getPlayerToVehicleRelatedPosition() >= 0) and (getPlayerToVehicleRelatedPosition() <= 30) then
            return 1;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 91) and (getPlayerToVehicleRelatedPosition() <= 120) then
            return 2;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 240) and (getPlayerToVehicleRelatedPosition() <= 270) then
            return 3;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 60) and (getPlayerToVehicleRelatedPosition() <= 90) then
            return 4;
        end
            
        if (getPlayerToVehicleRelatedPosition() >= 271) and (getPlayerToVehicleRelatedPosition() <= 300) then
            return 5;
        end
    end

    return nil;
end


function isInteractableVehicle(lookAtVehicle)
    local vehicle = lookAtVehicle;
    local interactableVehicles = {  602, 429, 402, 541, 415, 480, 562, 587, 565, 559, 603, 506, 558, 555, 536, 575,
                                    518, 419, 534, 576, 412, 496, 401, 527, 542, 533, 526, 474, 545, 517, 410, 436,
                                    475, 439, 549, 491, 599, 552, 499, 422, 414, 600, 543, 478, 456, 554, 589, 500, 
                                    489, 442, 495, 560, 567, 445, 438, 507, 585, 466, 492, 546, 551, 516, 467, 426, 
                                    547, 405, 580, 550, 566, 420, 540, 421, 529, 490, 596, 598, 597, 418, 579, 400, 
                                    470, 404, 479, 458, 561, 411, 451, 477, 535, 528, 525, 508, 494, 502, 503, 423,
                                    416, 427, 609, 498, 428, 459, 482, 582, 413, 440, 433, 524, 455, 403, 443, 515, 
                                    514, 408, 407, 544, 601, 573, 574, 483, 588, 434, 444, 583, 409};
    
    for i, v in pairs(interactableVehicles) do
        if (v == getElementModel(vehicle)) then
            return "true";
        end
    end  
end


function getInteractableVehicleType(lookAtVehicle)
    local vehicle = lookAtVehicle;
    
    -- front doors, hood, trunk 
    local twoDoors = {  602, 429, 402, 541, 415, 480, 562, 587, 565, 559, 603, 506, 558, 555, 536, 575,
                        518, 419, 534, 576, 412, 496, 401, 527, 542, 533, 526, 474, 545, 517, 410, 436,
                        475, 439, 549, 491, 599, 552, 499, 422, 414, 600, 543, 478, 456, 554, 589, 500, 
                        489, 442, 495, };
    
    -- front doors, rear doors, hood, trunk                        
    local fourDoors = { 560, 567, 445, 438, 507, 585, 466, 492, 546, 551, 516, 467, 426, 547, 405, 580,
                        550, 566, 420, 540, 421, 529, 490, 596, 598, 597, 418, 579, 400, 470, 404, 479,
                        458, 561};
    
    -- front doors, hood  (small cars)                   
    local twoDoorsNoTrunk = {411, 451, 477, 535, 528, 525, 508, 494, 502, 503, 423};
                  
    -- front doors, hood, rear doors at backside    
    local vans = {416, 427, 609, 498, 428, 459, 482, 582, 413, 440}; 
    
    -- front doors, hood (big cars)
    local trucks = {433, 524, 455, 403, 443, 515, 514, 408};
    
    -- front doors
    -- 407 and 544 firetrucks, 601 swat tank , 574 sweeper, 483 camper, 588 hotdog, 434 hotrod, 444 monstertruck, 583 tug
    local special = {407, 544, 601, 573, 574, 483, 588, 434, 444, 583};
    
    -- stretch                         
    local stretch = {409};
    
    if (isInteractableVehicle(vehicle)) == "true" then
        for i, v in pairs(twoDoors) do
            if (v == getElementModel(vehicle)) then
                return "2 doors";
            end
        end
        
        for i, v in pairs(twoDoorsNoTrunk) do
            if (v == getElementModel(vehicle)) then
                return "2 doors, no trunk";
            end
        end
        
        for i, v in pairs(fourDoors) do
            if (v == getElementModel(vehicle)) then
                return "4 doors";
            end
        end
        
        for i, v in pairs(vans) do
            if (v == getElementModel(vehicle)) then
                return "Van";
            end
        end
        
        for i, v in pairs(trucks) do
            if (v == getElementModel(vehicle)) then
                return "Truck";
            end
        end
        
        for i, v in pairs(special) do
            if (v == getElementModel(vehicle)) then
                return "Special";
            end
        end
        
        for i, v in pairs(stretch) do
            if (v == getElementModel(vehicle)) then
                return "Stretch";
            end
        end
    else
        return "not useable";
    end
end


bindKey(interactButton, "down",
function()
    if (lookAtVehicle) and (getElementType(lookAtVehicle) == "vehicle") and (getDoor(lookAtVehicle)) then
        local checkDoor = getVehicleDoorState(lookAtVehicle, getDoor(lookAtVehicle));
        if (checkDoor ~= 4 ) then
            if not(isVehicleLocked(lookAtVehicle)) then
                triggerServerEvent("onInteractVehicleDoor", player, tonumber(getDoor(lookAtVehicle)));
                local x, y, z = getElementPosition(player);
                triggerEvent("onDoorOpened", root, x, y, z);
            end
        end
    end
end);


-- custom triggered events
-- hood
function onHoodOpened()
    if (isDebug == "true") then
        outputChatBox("Hood was opened.");
    end
end
addEvent("onHoodOpened", true);
addEventHandler("onHoodOpened", root, onHoodOpened);

function onHoodClosed()
    if (isDebug == "true") then
        outputChatBox("Hood was closed.");
    end
end
addEvent("onHoodClosed", true);
addEventHandler("onHoodClosed", root, onHoodClosed);

-- trunk
function onTrunkOpened()
    if (isDebug == "true") then
        outputChatBox("Trunk was opened.");
    end
end
addEvent("onTrunkOpened", true);
addEventHandler("onTrunkOpened", root, onTrunkOpened);

function onTrunkClosed()
    if (isDebug == "true") then
        outputChatBox("Trunk was closed.");
    end
end
addEvent("onTrunkClosed", true);
addEventHandler("onTrunkClosed", root, onTrunkClosed);

-- left front door
function onLeftFrontDoorOpened()
    if (isDebug == "true") then
        outputChatBox("Left front door was opened.");
    end
end
addEvent("onLeftFrontDoorOpened", true);
addEventHandler("onLeftFrontDoorOpened", root, onLeftFrontDoorOpened);

function onLeftFrontDoorClosed()
    if (isDebug == "true") then
        outputChatBox("Left front door was closed.");
    end
end
addEvent("onLeftFrontDoorClosed", true);
addEventHandler("onLeftFrontDoorClosed", root, onLeftFrontDoorClosed);

-- right front door
function onRightFrontDoorOpened()
    if (isDebug == "true") then
        outputChatBox("Right front door was opened.");
    end
end
addEvent("onRightFrontDoorOpened", true);
addEventHandler("onRightFrontDoorOpened", root, onRightFrontDoorOpened);

function onRightFrontDoorClosed()
    if (isDebug == "true") then
        outputChatBox("Right front door was closed.");
    end
end
addEvent("onRightFrontDoorClosed", true);
addEventHandler("onRightFrontDoorClosed", root, onRightFrontDoorClosed);

-- left rear door
function onLeftRearDoorOpened()
    if (isDebug == "true") then
        outputChatBox("Left rear door was opened.");
    end
end
addEvent("onLeftRearDoorOpened", true);
addEventHandler("onLeftRearDoorOpened", root, onLeftRearDoorOpened);

function onLeftRearDoorClosed()
    if (isDebug == "true") then
        outputChatBox("Left rear door was closed.");
    end
end
addEvent("onLeftRearDoorClosed", true);
addEventHandler("onLeftRearDoorClosed", root, onLeftRearDoorClosed);

-- right rear door
function onRightRearDoorOpened()
    if (isDebug == "true") then
        outputChatBox("Right rear door was opened.");
    end
end
addEvent("onRightRearDoorOpened", true);
addEventHandler("onRightRearDoorOpened", root, onRightRearDoorOpened);

function onRightRearDoorClosed()
    if (isDebug == "true") then
        outputChatBox("Right rear door was closed.");
    end
end
addEvent("onRightRearDoorClosed", true);
addEventHandler("onRightRearDoorClosed", root, onRightRearDoorClosed);

-- door sounds
function onDoorOpened(x, y, z)
    local sound = playSound3D("Files/Sounds/DoorOpen.wav", x, y, z, false)
    setSoundMaxDistance(sound, 5);
end
addEvent("onDoorOpened", true);
addEventHandler("onDoorOpened", root, onDoorOpened);

function onDoorClosed(x, y, z)
    local sound = playSound3D("Files/Sounds/DoorClose.wav", x, y, z, false)
    setSoundMaxDistance(sound, 5);
end
addEvent("onDoorClosed", true);
addEventHandler("onDoorClosed", root, onDoorClosed);