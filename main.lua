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



	local gameIsActive = true
	local vilao = {}
    local i = 1
    local vilaoTimer, score, distancia, verificador, verifica
	local metro = false
	local arma = {'quadrado', 'triangulo'}
	local sentido = {'esquerda', 'direita'}
	local physics = require("physics")
    physics.setScale( 60 )
    physics.start()
    physics.setGravity( 0, 0.5)
	physics.start()
	score = 0
	distancia = 0
	verifica = 10
	
	local function updateTexto()
    textScore.text = "Score: "..score
    textDistancia.text = "Distância: "..distancia
	end
	
	local function verificarMetro()
	verificador = distancia/verifica
	if (verificador == 1) then 
	verifica = verifica + 10
	metro = true
	return true
	end 
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
	
------- Background end ---------------------
	
------- Sprite bolaheroi pulando --------------------
		local astronauta = {
		   width = 80,
		   height = 70,
		   numFrames = 38
		}
		local sheet_heroi = graphics.newImageSheet( "images/astronauta.png", astronauta )
		
		-- tabela de sequencia dos frames
		local sequencia_heroi = {
			-- sequencia dos frames
			{
				name = "laranjaEsq_parado",
				frames = {1},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "laranjaEsq_andando",
				frames = {2,3,2,3},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "laranjaEsq_atirando",
				frames = {4,5,2,3},
				time = 700,
				loopCount = 1,
				loopDirection = "forward"
			},
			{
				name = "laranjaDir_parado",
				frames = {6},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "laranjaDir_andando",
				frames = {7,8},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "laranjaDir_atirando",
				frames = {9,10,7,8},
				time = 700,
				loopCount = 1,
				loopDirection = "forward"
			},
			{
				name = "verdeEsq_parado",
				frames = {11},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "verdeEsq_andando",
				frames = {12,13},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "verdeEsq_atirando",
				frames = {14,15,12,13},
				time = 700,
				loopCount = 1,
				loopDirection = "forward"
			},
			{
				name = "verdeDir_parado",
				frames = {16},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "verdeDir_andando",
				frames = {17,18},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},
			{
				name = "verdeDir_atirando",
				frames = {19,20,17,18},
				time = 700,
				loopCount = 1,
				loopDirection = "forward"
			},	
			
		}

		
		local heroi = display.newSprite( sheet_heroi, sequencia_heroi )
		heroi.x = 160
		heroi.y = 400
		arma.quadrado = 1
		arma.triangulo = 2
		sentido.esquerda = 1
		sentido.direita = 2
		heroi.arma = 1
		heroi.sentido = 2
		
		---physics.addBody(heroi, "kinematic", {bounce = 0})
		heroi:setSequence("verdeDir_andando")
		heroi:play()
		heroi.collision = onCollision
		heroi:addEventListener("collision", heroi)
------- Sprite bolaheroi pulando fim--------------------		
		function HeroiAtirar (event) --- função que chama os sprites na hora certa
			local spriteAtual = event.target
			if (heroi.arma == 1 and heroi.sentido == 1) then
				if (event.phase == "ended") then 
				spriteAtual:setSequence("verdeEsq_andando")
				spriteAtual:play()
				end
			elseif (heroi.arma == 1 and heroi.sentido == 2) then
				if (event.phase == "ended") then 
				spriteAtual:setSequence("verdeDir_andando")
				spriteAtual:play()
				end
			elseif (heroi.arma == 2 and heroi.sentido == 1) then
				if (event.phase == "ended") then 
				spriteAtual:setSequence("laranjaEsq_andando")
				spriteAtual:play()
				end		
			elseif (heroi.arma == 2 and heroi.sentido == 2) then

				if (event.phase == "ended") then 
				spriteAtual:setSequence("laranjaDir_andando")
				spriteAtual:play()
				end	
			end
		end
		
		function heroi:tap(event) --- função para trocar a arma do astronauta
		if (event.numTaps == 1) then	
			if (heroi.arma == 1 and heroi.sentido == 2) then
			heroi.arma = 2
			heroi:setSequence("laranjaDir_andando")
			heroi:play()
			print( "Arma vermelha" )
			return true;
			
			elseif (heroi.arma == 1 and heroi.sentido == 1) then
			heroi.arma = 2
			heroi:setSequence("laranjaEsq_andando")
			heroi:play()
			print( "Arma vermelha" )
			return true;
			
			elseif (heroi.arma == 2 and heroi.sentido == 2) then
			heroi.arma = 1
			heroi:setSequence("verdeDir_andando")
			heroi:play()
			print( "Arma vermelha" )
			return true;
			
			elseif (heroi.arma == 2  and heroi.sentido == 1) then
			heroi.arma = 1
			heroi:setSequence("verdeEsq_andando")
			heroi:play()
			print( "Arma vermelha" )
			return true;
			end
		end
		end

		heroi:addEventListener( "tap" )
		

------- Spawning quadrados ----------------------------

	function onTouch(self, event) ------ função destruir monstro 
		if (heroi.arma == self.id) then
		if (self.id == 1 and self.x == 100) then
		heroi:setSequence("verdeEsq_atirando")
		heroi:play()
		heroi:addEventListener("sprite", HeroiAtirar)
		heroi.sentido = 1
		elseif (self.id == 1 and self.x == 220) then
		heroi:setSequence("verdeDir_atirando")
		heroi:play()
		heroi:addEventListener("sprite", HeroiAtirar)
		heroi.sentido = 2
		elseif (self.id == 2 and self.x == 100) then
		heroi:setSequence("laranjaEsq_atirando")
		heroi:play()
		heroi:addEventListener("sprite", HeroiAtirar)
		heroi.sentido = 1
		elseif (self.id == 2 and self.x == 220) then
		heroi:setSequence("laranjaDir_atirando")
		heroi:play()
		heroi:addEventListener("sprite", HeroiAtirar)
		heroi.sentido = 2
		end
		display.remove(self)
		score=score+10
		updateTexto()
		
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
				
	textScore = display.newText("Score: "..score, 6, 2, "VarelaRound-Regular", 15, left)
    textScore:setTextColor(0,0,255)
	textDistancia = display.newText("Distância: "..distancia.." m", 5, 15, "VarelaRound-Regular", 15)
    textDistancia:setTextColor(0,0,255)
	
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
	
	local spawnQuad = function()

	if (gameIsActive == true) then

	------ Sprite quadradovilao pulando --------------------

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
		
			verificarMetro()

			i = i + 1
			distancia = distancia + 1
			updateTexto()
			if (metro == true) then
			score = score+1
			updateTexto()
			metro = false
			end
		
			
	end

	
			
    end
	
	
    vilaoTimer = timer.performWithDelay( 800, spawnQuad, -1 ) -- this is a time and 1000 is 1 second and 1000 miliseconds.. it will spawn one circle every one second.. you can change this at your own liking..

------- Spawning quadrados fim -------------------------

		


