
local pgram = Material( "VGUI/Burger/PGram" )
local pgramstopper = Material( "VGUI/Burger/PGramStopper")


local boxarrow = Material( "VGUI/Burger/BoxArrow" )
local chevarrow = Material( "VGUI/Burger/ChevArrow" )
local chevbox = Material( "VGUI/Burger/ChevBox" )
local righttri = Material( "VGUI/Burger/RightTriangle" )

local diamond = Material( "VGUI/Burger/Diamond" )
local diamondstop = Material( "VGUI/Burger/DiamondStopper" )

surface.CreateFont( "BurgerHUD2a", {
	font = "roboto condensed", 
	size = 60, 
	weight = 0, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
} )

surface.CreateFont( "BurgerHUD2b", {
	font = "roboto condensed", 
	size = 64, 
	weight = 0, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
} )


print("Loaded")

function OnSucessfullyLoaded()
	function GAMEMODE:HUDDrawTargetID()


	end
end


hook.Add("OnGamemodeLoaded","Gamemode Loaded",OnSucessfullyLoaded)

local fadetime = 0
local update


function CustomTargetID()
		
	local x = ScrW()
	local y = ScrH()	
	
	local target = LocalPlayer():GetEyeTrace().Entity
	
	
	if target:IsValid() then
	
		if not IsValid(update) then
			if target:IsPlayer() then
				update = target
				fadetime = CurTime() + 5
			end
		elseif target ~= update then
			if target:IsPlayer() then
				update = target
				fadetime = CurTime() + 5
			end
		elseif target == update then
			if target:IsPlayer() then
				fadetime = CurTime() + 5
			end
		end
		
	end
	
	if IsValid(update) then
		if fadetime < CurTime() then
			update = nil
			fadetime = 0
		end
	end
	
	
	
	local max = 10
	local xpos = x / 2
	local ypos = y / 16
	local xsize = 64
	local ysize = 32
	local xbonus = -20
	local ybonus = 0
	local center = false
	local mat = pgram
	local alpha = math.Clamp((fadetime - CurTime())*51, 0 , 255)
	

	
	

	if IsValid(update) then
	
		--if update:IsBot() then
		--	name = "African American (Level " .. update:Frags() .. ")"
		--else
			name = update:Nick()
		--end
	
	
	
	
	
		draw.DrawText( name, "BurgerHUD2b" , xpos , ypos + 10 , Color(255,255,255,alpha) , TEXT_ALIGN_CENTER )
	end
	
	if IsValid(update) then
		HUDGenerateHealthTop(target,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,alpha)
	end
	
	
end


hook.Add("HUDDrawTargetID","Custom Target ID",CustomTargetID)



function BurgerHUD2()

	local x = ScrW()
	local y = ScrH()


	local ply = LocalPlayer()

	local ammo1
	local ammo1max = -1
	local ammo1count
	
	local health
	local armor
	
	local weapon = ply:GetActiveWeapon()
	
	if ply:Alive() then
	
		if weapon:IsValid() then
		
			ammo1 = weapon:Clip1()
			ammo1count = ply:GetAmmoCount(weapon:GetPrimaryAmmoType())
		
			if weapon:IsScripted() then
				ammo1max = weapon.Primary.ClipSize
			end
			
		end
	
		health = ply:Health()
		armor = ply:Armor()
	end
	

	
	if ply:Alive() then
	
		--[[
		local value = health
		local max = 20
		local xpos = x / 2
		local ypos = y / 16
		local xsize = 64 --* 3/4
		local ysize = 32 --* 3/4
		local xbonus = -20 --* 3/4
		local ybonus = 0
		local center = true
		local mat = pgram
		local color = Color(255 - health*2.55,health*2.55,0,255)
		HUDGenerateHealthTop(value,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,color)
		
		local value = armor
		local max = 18
		local xpos = x / 2 + 16
		local ypos = y / 16 + 32
		local xsize = 64 --* 3/4
		local ysize = 32 --* 3/4
		local xbonus = -16 --* 3/4
		local ybonus = 0
		local center = true
		local mat = pgram
		local color = Color(0,armor*2.55,armor*2.55,255)
		HUDGenerateArmorTop(value,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,color)
		--]]
		
		
		local value = health
		local max = 10
		local xpos = x / 16
		local ypos = y - y/16 - 64
		local xsize = 64
		local ysize = 32
		local xbonus = -20
		local ybonus = 0
		local center = false
		local mat = pgram
		local color = Color(255 - health*2.55,health*2.55,0,200)
		HUDGenerateHealth(value,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,color)
		
		local value = armor
		local max = 11
		local xpos = x / 16 - 24
		local ypos = y - y/16
		local xsize = 64
		local ysize = 32
		local xbonus = -17
		local ybonus = 0
		local center = false
		local mat = pgram
		local color = Color(0,armor*2.55,armor*2.55,200)
		HUDGenerateArmor(value,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,color)

		local value1 = ammo1
		local value2 = ammo1max
		local value3 = ammo1count
		local xpos = x - x/8 - x/64
		local ypos = y - y/8 - y/64
		
		HUDGenerateAmmo(value1,value2,value3,xpos,ypos)
		
		
	end

end

hook.Add( "HUDPaint", "HUDPaint_DrawABox",  BurgerHUD2 )

function HUDGenerateAmmo(value1,value2,value3,xpos,ypos)
	if value2 > 0 then
	
		local bonus = 75
		
		surface.SetDrawColor( Color(255,255,255,255) )
		surface.SetMaterial( diamondstop )
		surface.DrawTexturedRectRotated( xpos + 64*3 , ypos + bonus, 64*2 , 32*2, 180  )
		surface.DrawTexturedRectRotated( xpos - 64*3 , ypos + bonus, 64*2 , 32*2, 0  )
		
		local percent = value1/value2
		
		
		surface.SetDrawColor( Color(255,255 * percent,0,200) )
		surface.SetMaterial( diamond )
		surface.DrawTexturedRectRotated( xpos , ypos + bonus, 64*5*percent , 32*4 * percent, 0  )
		
		
		draw.DrawText( value1 .. " / " .. value2 , "BurgerHUD2a" , xpos, ypos, Color(255,255,255,255) , TEXT_ALIGN_CENTER )
		draw.DrawText( value3 , "BurgerHUD2a" ,  xpos, ypos + 60, Color(255,255,255,255) , TEXT_ALIGN_CENTER )
		
	end
	
	
end





function HUDGenerateHealth(value,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,color)

	if value > 0 then
	
		surface.SetDrawColor( Color(255,255,255,255) )
		surface.SetMaterial( diamond )
		surface.DrawTexturedRectRotated( xpos , ypos, xsize , ysize, 0  )
		
		
		surface.SetMaterial( diamondstop )
		surface.DrawTexturedRectRotated( xpos - (1*xsize - xsize) - (1*xbonus - xbonus) - xsize/2 , ypos, xsize , ysize, 0  )
		surface.DrawTexturedRectRotated( xpos + ((max+1)*xsize - xsize) + ((max+1)*xbonus - xbonus) + xsize/2 , ypos, xsize , ysize, 180  )
		
		
		surface.SetDrawColor( color )
		surface.SetMaterial( chevarrow )
		
		
		
			
		--local centermath = (xsize * max * 0.5) + (xbonus * max * 0.5) - xsize	
			
		for i=0, max do
			if i*(100/max) < value then
				surface.DrawTexturedRectRotated( xpos + (i*xsize) + (i*xbonus) + xsize/2 , ypos, xsize , ysize, 0  )
			end
		end
			
		
	
			
			
			
	end

	draw.DrawText( value, "BurgerHUD2b" , xpos + ((max/2)*xsize - xsize) + ((max/2)*xbonus - xbonus) + xsize/2 , ypos - 32 , Color(255,255,255,255) , TEXT_ALIGN_CENTER )


end

function HUDGenerateHealthTop(target,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,alpha)

	local value = update:Health()
	


	

	if value > 0 then
	
		--print(alpha)
	
		surface.SetDrawColor( Color(255,255,255,alpha) )
		surface.SetMaterial( diamond )
		surface.DrawTexturedRectRotated( xpos , ypos, xsize , ysize, 0  )
		
		
		surface.SetMaterial( diamondstop )
		surface.DrawTexturedRectRotated( xpos - ((max+1)*xsize - xsize) - ((max+1)*xbonus - xbonus) - xsize/2 , ypos, xsize , ysize, 0  )
		surface.DrawTexturedRectRotated( xpos + ((max+1)*xsize - xsize) + ((max+1)*xbonus - xbonus) + xsize/2 , ypos, xsize , ysize, 180  )
		
		
		surface.SetDrawColor( Color(255,0,0,alpha) )
		surface.SetMaterial( chevarrow )
			
		--local centermath = (xsize * max * 0.5) + (xbonus * max * 0.5) - xsize	
			
		for i=0, max do
			if i*(100/max) < value then
				surface.DrawTexturedRectRotated( xpos + (i*xsize) + (i*xbonus) + xsize/2 , ypos, xsize , ysize, 0  )
			end
		end
		
		for i=0, max do
			if i*(100/max) < value then
				surface.DrawTexturedRectRotated( xpos + (-i*xsize) + (-i*xbonus) - xsize/2 , ypos, xsize , ysize, 180  )
			end
		end	
			
			
	end

end

function HUDGenerateArmor(value,max,xpos,ypos,xsize,ysize,xbonus,ybonus,center,mat,color)

	local centermath
			
	if center then
		centermath = (xsize * max * 0.5) + (xbonus * max * 0.5)
	else
		centermath = 0
	end

	
	surface.SetDrawColor( Color(255,255,255,255) )
		
	surface.SetMaterial( pgramstopper )
		
	surface.DrawTexturedRectRotated( xpos + (1*xsize - xsize) + (1*xbonus - xbonus) - centermath + xsize/2 , ypos, xsize , ysize, 0 )
	surface.DrawTexturedRectRotated( xpos + ((max-1)*xsize - xsize) + ((max-1)*xbonus - xbonus) - centermath + xsize/2 , ypos, xsize , ysize, 180 )
	
	
	if value > 0 then

		surface.SetDrawColor( color )
		surface.SetMaterial( mat )
	
		
		for i=1, max do
			if i*(100/max) < value then
				surface.DrawTexturedRectRotated( xpos + (i*xsize - xsize) + (i*xbonus - xbonus) - centermath + xsize/2 , ypos, xsize , ysize, 0 )
			end
		end
			
			
			
	end

	draw.DrawText( value, "BurgerHUD2b" , -8 + xpos + ((max/2)*xsize - xsize) + ((max/2)*xbonus - xbonus) + xsize/2 , ypos - 32 , Color(255,255,255,255) , TEXT_ALIGN_CENTER )
	
end






hook.Add( "HUDShouldDraw", "Hide Battery and Health", function( name )
	
	 if ( name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" ) then
		 return false
	 end
	
end )