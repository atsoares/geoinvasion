
local gameIsActive = true
local physics = require("physics")
    physics.setScale( 60 )
    physics.start()
    physics.setGravity( 0, 0.5)
physics.start()


    local vilao = {}
    local i = 1
    local vilaoTimer
------- Background beginning --------------------

    --Hide status bar from the beginning
    display.setStatusBar( display.HiddenStatusBar )
     
    -- Set Variables
    _W = display.contentWidth; -- Get the width of the screen
    _H = display.contentHeight; -- Get the height of the screen
    scrollSpeed = 0.7; -- Set Scroll Speed of background
     
    -- Add First Background
    local bg1 = display.newImageRect("images/rua.png", 320, 480)
    bg1:setReferencePoint(display.CenterLeftReferencePoint)
    bg1.x = 0; bg1.y = _H/2;
     
    -- Add Second Background
    local bg2 = display.newImageRect("images/rua.png", 320, 480)
    bg2:setReferencePoint(display.CenterLeftReferencePoint)
    bg2.x = 0; bg2.y = bg1.y+480;
     
    -- Add Third Background
    local bg3 = display.newImageRect("images/rua.png", 320, 480)
    bg3:setReferencePoint(display.CenterLeftReferencePoint)
    bg3.x = 0; bg3.y = bg2.y+480;
     
    local function move(event)
     
    -- move backgrounds to the left by scrollSpeed, default is 8
    bg1.y = bg1.y + scrollSpeed
    bg2.y = bg2.y + scrollSpeed
    bg3.y = bg3.y + scrollSpeed
     
    -- Set up listeners so when backgrounds hits a certain point off the screen,
    -- move the background to the right off screen
    if (bg1.y + bg1.contentWidth) > 1040 then
    bg1:translate( 0, -960 )
    end
    if (bg2.y + bg2.contentWidth) > 1040 then
    bg2:translate( 0, -960 )
    end
    if (bg3.y + bg3.contentWidth) > 1040 then
    bg3:translate( 0, -960 )
    end
    end
     
    -- Create a runtime event to move backgrounds
    Runtime:addEventListener( "enterFrame", move )
	
------- Background end ----------------------

------- Reconhecimento de toque na tela -----------------

   -- local player = display.newRect(0, 0, 250, 250)
   -- player.strokeWidth = 3
   -- player:setFillColor(140, 140, 140)
   -- player:setStrokeColor(180, 180, 180)
   -- player.x = display.contentWidth/2
   -- player.y = display.contentHeight/2
     
   -- function player:tap( event )
   --  if (event.numTaps == 2 ) then
   --  print( "The object was double-tapped." )
   --  return true;
   --  elseif (event.numTaps == 1 ) then
   --  print("The object was tapped once.")
   --  end
   -- end
     
   -- player:addEventListener( "tap" )
	
------- Reconhecimento de toque na tela fim	--------

------- Saber posicionamento da tela x e y ---------

		
	local function onTouch(event)
		 print("POS.X = " .. event.x, "POS.Y = ".. event.y);
	end

	Runtime:addEventListener("touch",onTouch);

------- Saber posicionamento da tela x e y fim ---------


------- Sprite bolaheroi pulando --------------------
		local mrbola = {
		   width = 82,
		   height = 82,
		   numFrames = 28
		}
		local sheet_heroi = graphics.newImageSheet( "images/mrball.png", mrbola )
		
		-- tabela de sequencia dos frames
		local pulando_heroi = {
			-- sequencia dos frames
			{
				name = "pulando",
				start = 1,
				count = 28,
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			}
		}
		
		local heroi = display.newSprite( sheet_heroi, pulando_heroi )
		heroi.x = 160
		heroi.y = 370
		--physics.addBody(heroi, "kinematic", {bounce = 0})
		heroi:setSequence("pulando")
		heroi:play()
		heroi.collision = onCollision
		heroi:addEventListener("collision", heroi)
------- Sprite bolaheroi pulando fim--------------------		

local levelGroup = display.newGroup()

		local function onCollision(self, event)
		
		if self.name == "heroi" and event.other.name == "vilao" then

	        local gameoverText = display.newText("Game Over!", 0, 0, "HelveticaNeue", 35)
	        gameoverText:setTextColor(255, 255, 255)
	        gameoverText.x = display.contentCenterX
	        gameoverText.y = display.contentCenterY
	        gameLayer:insert(gameoverText)

	        -- This will stop the gameLoop
	        gameIsActive = false
	    end
	
		end

------- Spawning quadrados ----------------------------

local function onTouch(self, event)
	
    display.remove(self)
	return true
end

		-- local andando = function(event)
		-- vilao[i].y = vilao[i].y +0.4
		-- return true
		-- end		
		
local spawnQuad = function()

if gameIsActive then
------ Sprite quadradovilao pulando --------------------
		local quadradovilao= {
		   width = 82,
		   height = 82,
		   numFrames = 18
		}
		local viloes = math.random(1,2)
		local sheet_quad = graphics.newImageSheet( "images/squarehead_"..viloes..".png", quadradovilao )
		
		-- tabela de sequencia dos frames
		local quad_pulando = {
			-- sequencia dos frames
			{
				name = "pulando",
				start = 1,
				count = 18,
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			}
		}
------- Sprite quadradovilao pulando fim--------------------



    	local Fall = math.random(2) == 1 and 220 or 100
		vilao[i] = display.newSprite( sheet_quad, quad_pulando )
    	vilao[i].x = Fall
    	vilao[i].y = -30   	   	
		
    	vilao[i].value = i 
		physics.addBody(vilao[i], "dynamic", {bounce = 0}) 
		vilao[i]:setSequence("pulando")
		vilao[i]:play()	
		vilao[i].touch = onTouch
		vilao[i]:addEventListener("touch")
		
    	i = i + 1		
		
	
end
	
    end
    vilaoTimer = timer.performWithDelay( 1500, spawnQuad, -1 ) -- this is a time and 1000 is 1 second and 1000 miliseconds.. it will spawn one circle every one second.. you can change this at your own liking..

------- Spawning quadrados fim -------------------------

		


