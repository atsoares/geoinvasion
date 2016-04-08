
local gameIsActive = true
local physics = require("physics")
    physics.setScale( 60 )
    physics.start()
    physics.setGravity( 0, 0.5)
physics.start()


    local vilao = {}
    local i = 1
    local vilaoTimer
	local score
	
	local function updateTexto()
    textScore.text = "Score: "..score
end
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

		
	-- local function onTouch(event)
		 -- print("POS.X = " .. event.x, "POS.Y = ".. event.y);
	-- end

	-- Runtime:addEventListener("touch",onTouch);

------- Saber posicionamento da tela x e y fim ---------


	local arma = {'quadrado', 'triangulo'}
	
------- Sprite bolaheroi pulando --------------------
		local mrbola = {
		   width = 82,
		   height = 82,
		   numFrames = 28
		}
		local sheet_heroi = graphics.newImageSheet( "images/mrball.png", mrbola )
		
		-- tabela de sequencia dos frames
		local sequencia_heroi = {
			-- sequencia dos frames
			{
				name = "pulando",
				start = 1,
				count = 28,
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "parado",
				frames = {16},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			}
		}
		
		local heroi = display.newSprite( sheet_heroi, sequencia_heroi )
		heroi.x = 160
		heroi.y = 400
		arma.quadrado = 1
		arma.triangulo = 2
		heroi.arma = 1
		---physics.addBody(heroi, "kinematic", {bounce = 0})
		heroi:setSequence("pulando")
		heroi:play()
		heroi.collision = onCollision
		heroi:addEventListener("collision", heroi)
------- Sprite bolaheroi pulando fim--------------------		
		
		function heroi:tap(event)
		if (event.numTaps == 2) then	
			if (heroi.arma == 1) then
			heroi.arma = 2
			heroi:setSequence("parado")
			print( "Arma vermelha" )
			return true;
			end
			elseif (heroi.arma == 2) then
			heroi:setSequence("pulando")
			heroi:play()
			heroi.arma = 1
			print( "Arma verde" )
			return true;
			end
		end

		heroi:addEventListener( "tap" )
		
-- local levelGroup = display.newGroup()

		-- local function onCollision(self, event)
		
		-- if self.name == "heroi" and event.other.name == "vilao" then

	        -- local gameoverText = display.newText("Game Over!", 0, 0, "HelveticaNeue", 35)
	        -- gameoverText:setTextColor(255, 255, 255)
	        -- gameoverText.x = display.contentCenterX
	        -- gameoverText.y = display.contentCenterY
	        -- gameLayer:insert(gameoverText)

	        -- This will stop the gameLoop
	        -- gameIsActive = false
	    -- end
	
		-- end

------- Spawning quadrados ----------------------------

function onTouch(self, event)
	if (heroi.arma == self.id) then
	score=score+10
	updateTexto()
    display.remove(self)
	return true;
	end	
end

		
local function andando(self,event)
	if (self.y ~= nil) then
		self.y = self.y + 2
		if (self.y == heroi.y) then
		gameIsActive = false
		print (gameIsActive)
		return gameIsActive
		
		end
		
	end
end
		
		
score = 0
textScore = display.newText("Score: "..score, 5, 2, "VarelaRound-Regular", 15)
    textScore:setTextColor(0,0,255)
local spawnQuad = function()

if (gameIsActive == true) then

------ Sprite quadradovilao pulando --------------------
		local quadradovilao= {
		   width = 82,
		   height = 82,
		   numFrames = 18
		}
		-- local viloes = math.random(1,2)
		local sheet_quad = graphics.newImageSheet( "images/squarehead_1.png", quadradovilao )
		local sheet_quad2 = graphics.newImageSheet( "images/squarehead_2.png", quadradovilao )
		
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
		local monstro = math.random(1, 2)
		if (monstro == 1) then
			vilao[i] = display.newSprite(sheet_quad, quad_pulando )
			vilao[i].id = 1
			elseif (monstro == 2) then
			vilao[i] = display.newSprite(sheet_quad2, quad_pulando )
			vilao[i].id = 2
		end
			vilao[i].x = Fall
			vilao[i].y = -30   	   	
			vilao[i].value = i 

			
			--physics.addBody(vilao[i], "dynamic", {bounce = 0}) 
			vilao[i]:setSequence("pulando")
			vilao[i]:play()	
			vilao[i].touch = onTouch
			vilao[i]:addEventListener("touch")
			vilao[i].enterFrame = andando
			
			Runtime:addEventListener("enterFrame", vilao[i])

			
    	
	
		
	
    	i = i + 1
	
		
end

	
			
    end
	
	
    vilaoTimer = timer.performWithDelay( 800, spawnQuad, -1 ) -- this is a time and 1000 is 1 second and 1000 miliseconds.. it will spawn one circle every one second.. you can change this at your own liking..

------- Spawning quadrados fim -------------------------

		


