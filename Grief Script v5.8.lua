function math_sqrt(i)
	return i^0.5
end
function math_distancetosqr(vec1, vec2)
	return ((vec2.x - vec1.x)^2) + ((vec2.y - vec1.y)^2) + ((vec2.z - vec1.z)^2)
end
function math_distance2(vec1, vec2)
	return math_sqrt(math_distancetosqr(vec1, vec2))
end 
function math_floor(num)
	return num//1
end
function player_is_player(ped)
	if ped == nil or ped:get_pedtype() >= 4 then
		return false
	end
	return true
end
function player_is_npc(ped)
	if ped == nil or ped:get_pedtype() < 4 then
		return false
	end
	return true
end
function table_dump(o)
    if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. table_dump(v) .. ','
    end
    return s .. '} '
    else
    return tostring(o)
    end
end
function dump(item)
    if item == nil then return "nil" end
    if type(item) == "table" then
        return table_dump(item)
    elseif type(item) == "bool" then
        if item == true then return "true" elseif item == false then return "false" end
    end
    return tostring(item)
end

function player_is_modder(ply)
	if not player_is_player(ply) then return false end
	if ply:get_max_health() < 100 then return true end
	if ply:is_in_vehicle() and ply:get_godmode() then return true end
	if ply:get_run_speed() > 1.0 or ply:get_swim_speed() > 1.0 then return true end
	if ply:get_infinite_clip()then return true end
	if ply:get_no_ragdoll() then return true end
	if ply:get_seatbelt() and ply:is_in_vehicle() then return true end
	if ply:get_current_weapon() and ply:get_current_weapon():get_current_ammo() > 0 and ply:get_infinite_ammo() then return true end
	return false
end

local function TeleportToPlayer(ply, seconds)
	if not ply or ply == nil then return end 
	local pos = ply:get_position()
	if seconds then
		if localplayer:is_in_vehicle() then
			return
		end
 
		local oldpos = localplayer:get_position()
		localplayer:set_position(pos)
		sleep(seconds)
		localplayer:set_freeze_momentum(true) 
		localplayer:set_config_flag(292,true)
		localplayer:set_position(oldpos)
		localplayer:set_freeze_momentum(false) 
		localplayer:set_config_flag(292,false)
		return
	end
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	local pos = ply:get_position()
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
	sleep(0.1)
	if not localplayer:is_in_vehicle() then
		localplayer:set_position(pos)
	else
		localplayer:get_current_vehicle():set_position(pos)
	end
end

local function TeleportClosestVehicleToPlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local veh = localplayer:get_nearest_vehicle()
	if not veh or localplayer:get_nearest_vehicle()==localplayer:get_current_vehicle() then return end
	veh:set_position(ply:get_position()+vector3(2*disX, 2*disY, disZ))
end

local function TeleportClosestVehicleUnderPlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	
	local breakx = 0
	for veh in replayinterface.get_vehicles() do
		if localplayer ~= nil and localplayer:get_current_vehicle() then
		else
			veh:set_acceleration(0)
			veh:set_gravity(0)
			newpos = ply:get_position()+vector3(disX, disY, disZ-0.2)
			veh:set_rotation(vector3(0,0,0))
			veh:set_position(newpos)
			veh:set_rotation(vector3(0,0,0))
			if breakx == 7 then
				break
			end
			if veh:get_position() == newpos then
				breakx = breakx +1
			end
			sleep(0.005)
		end
	end
end

local function TeleportPedsToPlayer(ply, dead)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	for ped in replayinterface.get_peds() do
		if player_is_npc(ped) then
			if not ped:is_in_vehicle() then
				ped:set_position(ply:get_position()+vector3(2*disX, 2*disY, disZ))
			end
		end
	end
end
local function ExplodePlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local currentvehicle = nil 
	if localplayer:is_in_vehicle() then
		currentvehicle = localplayer:get_current_vehicle()
	end
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not player_get_vehicle(veh) then
			acc=veh:get_acceleration()
			veh:set_acceleration(0)
			veh:set_rotation(vector3(0,0,180))
			veh:set_health(-1)
			veh:set_position(ply:get_position()+vector3(disX, disY, disZ))
			veh:set_acceleration(acc)
		end
		end
	end
end
function player_get_vehicle(veh)
	for i = 0, 31 do
		ply = player.get_player_ped(i)
		if ply then if ply:get_current_vehicle()==veh then
		return true else return false end end
	end
end
local function LaunchPlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local currentvehicle = nil 
        if localplayer~=nil then
	      if localplayer:is_in_vehicle() then
		      currentvehicle = localplayer:get_current_vehicle()
	      end
        end
	local i = 0
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not player_get_vehicle(veh) then
			acc=veh:get_acceleration()
			veh:set_godmode(true)
			veh:set_acceleration(0)
			veh:set_rotation(vector3(0,0,0))
			veh:set_gravity(-100)
			veh:set_position(ply:get_position()+vector3(2.5*disX, 2.5*disY, disZ-5))
			veh:set_acceleration(acc)
		end
		end
	end
	sleep(1)
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
			veh:set_gravity(9.8)
		end
	end
end

local function SlamPlayer(ply)
	if not ply or ply == nil then return end
	pos2=ply:get_position()
	sleep(0.1)
	pos1=ply:get_position()
	disX=(pos1.x-pos2.x) disY=(pos1.y-pos2.y) disZ=(pos1.z-pos2.z)
	local currentvehicle = nil 
        if localplayer~=nil then
	       if localplayer:is_in_vehicle() then
	             currentvehicle = localplayer:get_current_vehicle()
	      end
        end
	local i = 0
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not player_get_vehicle(veh) then
			acc=veh:get_acceleration()
			veh:set_godmode(true)
			veh:set_acceleration(0)
			veh:set_rotation(vector3(0,0,0))
			veh:set_gravity(10000)
			veh:set_position(ply:get_position()+vector3(5*disX, 5*disY, disZ + 100))
			veh:set_acceleration(acc)
		end
		end
	end
	sleep(1)
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
		if not ply:get_current_vehicle() or ply:get_current_vehicle() ~= veh then
			veh:set_gravity(9.8)
		end
		end
	end
end

local function TeleportVehiclesToPlayer(ply)
	if not ply or ply == nil then
		return
	end
	local pos = ply:get_position()
	local currentvehicle = nil
	if localplayer:is_in_vehicle() then
		currentvehicle = localplayer:get_current_vehicle()
	end
	for veh in replayinterface.get_vehicles() do
		if not currentvehicle or currentvehicle ~= veh then
			veh:set_position(pos)
		end
	end
end



local playerlist2 = nil
local initlist2 = false
local players2 = {}
local seclectedpedped = nil
local selectedplayer2 = -1

local option = 1
local options = {
"TP-TO-PL",
"xGravity",
"Car Slam",
"All Carss",
"All Pedss",
"Bug a Car",
"Explodee"
}

function table_count(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
local function cur_option_str()	
	if option > 0 and option <= table_count(options) then
		if options[option] ~= nil then
			return options[option]
		end
	end
	return "SELECT OPTION"
end

local function titleopt(pll)
	ply = pll[1]
	ply_name = pll[2]
	if ply == nil then return "empty" end
	if ply_name == nil then return "empty" end
	local text = ""
		text = text..""..dump(ply_name)..""
	if player_is_modder(ply) then
		text = text.." *"
	end
	if ply:get_godmode() then
		text = text.."|GOD"
	else
		text = text.."|"..string.format("%3.0f",(ply:get_health()/ply:get_max_health())*100).."%" .. "" ..string.format("%2.0f",ply:get_armour()*2).."%"
	end
		if ply:is_in_vehicle() then
		local veh = ply:get_current_vehicle()
		if veh ~= nil then
			text = text.."|🚗"
			if veh:get_godmode() then
				text = text.."*"
			end
		else
			text = text.."|🚗"
		end
	else 
		text = text.."|🚶"
	end
	local wanted_level = ply:get_wanted_level()
	if wanted_level > 0 then text = text.."|"..wanted_level.."✰" end
	local mypos = localplayer:get_position()
	local plypos = ply:get_position()
	local distance = math.floor(math_distance2(plypos, mypos))
	if distance > 0 then text = text.."|"..distance.."m" end
	return text .."|"..   ""..cur_option_str()..""
end

local function titleoptall()
	return "All players" .."|"..   "|"..cur_option_str()..""
end 

local function tp_me_to_player(ply)
	 if localplayer ~= nil then
		localplayer:set_position(ply:get_position())
	 end
end

local function performaction(plynm,opt)
	name = nil
	ped = nil
	for i = 0, 31 do
		p_ped = player.get_player_ped(i)
		p_name =player.get_player_name(i)
		if plynm == p_name then
			ped = p_ped
			name = p_name
			break
		end
	end
	if ped == nil then return end
	local listty = 1
	if opt == listty then
		tp_me_to_player(ped)
		TeleportToPlayer(ped)
	end
	listty = listty + 1
	if opt == listty then
		LaunchPlayer(ped)	
	end
	listty = listty + 1
	if opt == listty then
		SlamPlayer(ped)	
	end
	listty = listty + 1
	if opt == listty then
		TeleportVehiclesToPlayer(ped)	
	end
	listty = listty + 1
	if opt == listty then
		TeleportPedsToPlayer(ped)	
	end
	listty = listty + 1
    if opt == listty then
		TeleportClosestVehicleUnderPlayer(ped)	
	end
	listty = listty + 1
	if opt == listty then
		ExplodePlayer(ped)	
	end
	listty = listty + 1
end

local function relist2()

	local function reloader(cc)
		if cc then relist2() end
		return "Reload list"
	end

	if not initlist2 then
		playerlist2 = menu.add_submenu("--- PLAYER TROLLER v0.1 --- | "..player.get_number_of_players(),function() relist2() end)
		initlist2 = true
	end
	playerlist2:clear()
	players2 = {}
	for i = 0, 31 do
		local ply = player.get_player_ped(i)
		if ply then players2[i] = {ply, player.get_player_name(i)} end
	end
	
	playerlist2:add_bare_item(reloader(false), function() return reloader(false) end, function() return reloader(true) end,function()  return reloader(false) end, function() return reloader(false) end)
	
	
	playerlist2:add_bare_item("Troller Made by kataraxluna", function() return "Troller Made by kataraxluna" end, function() return "Troller Made by kataraxluna" end,function()  return "Troller Made by kataraxunla" end, function() return "Troller Made by kataraXluna" end)
 
	playerlist2:add_bare_item(titleoptall(),
	function() return titleoptall() end,
	function()
		for i = 0, 31 do
			local ply = player.get_player_ped(i)
			if ply then
				if localplayer ~= nil and localplayer == ply then 
					--nothing
				else
					performaction(player.get_player_name(i),option)
				end
			end
		end
	end,
	function() if option > 1 then option = option - 1 end return titleoptall() end,
	function() if option < table_count(options) then  option = option + 1 end return titleoptall() end)

	for id, player in pairs(players2) do
		playerlist2:add_bare_item(titleopt(player),
		function() return titleopt(player) end,
		function()
		    local pp1 = player[1];seclectedpedped = pp1;
		    local pp2 = player[2];selectedplayer2 = pp2;
			performaction(selectedplayer2,option)
		end,
		function() if option > 1 then option = option - 1 end return titleopt(player) end,
		function() if option < table_count(options) then  option = option + 1 end return titleopt(player) end)
	end

	playerlist2:add_bare_item(reloader(false), function() return reloader(false) end, function() return reloader(true) end,function()  return reloader(false) end, function() return reloader(false) end)
 
end
relist2()