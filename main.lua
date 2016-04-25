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
	local vilao2 = {}
    local i = 1
    local vilaoTimer, score, distancia, verifica, verificaDistancia, verificaPowerUp, monstrosEliminados, 
	contadorPowerUP, dificuldade, powerUp, contadorEstrela, doisMonstros
	local powerUpAtivado = false
	local metro = false
	local arma = {'quadrado', 'triangulo', 'especial'}
	local sentido = {'esquerda', 'direita'}
	local physics = require("physics")
    physics.setScale( 60 )
    physics.start()
    physics.setGravity( 0, 0.5)
	physics.start()
	score = 0
	distancia = 0
	dificuldade = 800
	verifica = 10
	monstrosEliminados = 0
	doisMonstros = false
	contadorPowerUP = 0
	contadorEstrela = 0
	powerUp = false
	
	local function updateTexto()
    textScore.text = "Score: "..score
    textDistancia.text = "Distância: "..distancia.." m"
	end
	
	local function verificarMetro()
	verificaDistancia= distancia/verifica
	if (verificaDistancia == 1) then 
	verifica = verifica + 10
	metro = true
	return true
	end 
	end	

	local function rubikCube()
	powerUp = true
	end
	
	local somAtirando = audio.loadSound("audio/atirando.wav")
	local somAtirandoPowerUp = audio.loadSound("audio/atirandoPowerUp.wav")
	local coletandoPowerUp = audio.loadSound("audio/coletarPowerUp.wav")
	local somTrocandoArma = audio.loadSound("audio/trocarArma.wav")
	local coletandoEstrela = audio.loadSound("audio/coletarEstrela.wav")
	
------- Background beginning --------------------

    --Hide status bar from the beginning
    display.setStatusBar( display.HiddenStatusBar )
     
    -- Set Variables
    _W = display.contentWidth; -- Get the width of the screen
    _H = display.contentHeight; -- Get the height of the screen
    scrollSpeed = 0.7; -- Set Scroll Speed of background
     
    -- Add First Background
    local bg1 = display.newImageRect("images/moonground.png", 320, 480)
    bg1:setReferencePoint(display.CenterLeftReferencePoint)
    bg1.x = 0; bg1.y = _H/2;
     
    -- Add Second Background
    local bg2 = display.newImageRect("images/moonground.png", 320, 480)
    bg2:setReferencePoint(display.CenterLeftReferencePoint)
    bg2.x = 0; bg2.y = bg1.y+480;
     
    -- Add Third Background
    local bg3 = display.newImageRect("images/moonground.png", 320, 480)
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
		local rubik = {
			width = 30,
			height = 30,
			numFrames = 11
		}
		local sheet_rubik = graphics.newImageSheet ("images/rubikscube.png", rubik)
		
		local animacao_rubik = {
		{
			name = "rubik_girando",
			start = 1,
			count = 11,
			time = 800,
			loopCount = 0,
			loopDirection = "bounce"
			}
		}
		
		local estrela = {
			width = 16,
			height = 15,
			numFrames = 4
		}
		local sheet_estrela = graphics.newImageSheet ("images/star.png", estrela)
		
		local animacao_estrela = {
		{
			name = "estrela_brilhando",
			start = 1,
			count = 4,
			time = 800,
			loopCount = 0,
			loopDirection = "bounce"
			}
		}
		
------- Sprite bolaheroi pulando --------------------
		local astronauta = {
		   width = 80,
		   height = 70,
		   numFrames = 58
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
				frames = {7,8,7,8},
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
				frames = {12,13,12,13},
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
				frames = {17,18,17,18},
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
			{
				name = "rubikEsq_parado",
				frames = {21},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},	
			{
				name = "rubikEsq_andando",
				frames = {22,23,24,25},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},	
			{
				name = "rubikEsq_atirando",
				frames = {26,27,28,29},
				time = 700,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "rubikDir_parado",
				frames = {30},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},	
			{
				name = "rubikDir_andando",
				frames = {31,32,33,34},
				time = 700,
				loopCount = 0,
				loopDirection = "forward"
			},	
			{
				name = "rubikDir_atirando",
				frames = {35,36,37,38},
				time = 700,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "trocandoParaArmaLaranja_esq",
				frames = {46,47,48,49,50,51,52},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "trocandoParaArmaLaranja_dir",
				frames = {39,40,41,42,43,44,45},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "trocandoParaArmaVerde_esq",
				frames = {52,51,50,49,48,47,46},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "trocandoParaArmaVerde_dir",
				frames = {45,44,43,42,41,40,39},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},
			{
				name = "verde_trocandoParaArmaEspecial_esq",
				frames = {46,47,48,49,53,54,55},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "verde_trocandoParaArmaEspecial_dir",
				frames = {39,40,41,42,56,57,58},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "laranja_trocandoParaArmaEspecial_esq",
				frames = {52,51,50,49,53,54,55},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "laranja_trocandoParaArmaEspecial_dir",
				frames = {45,44,43,42,56,57,58},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "ArmaEspecial_esq_acabou",
				frames = {55,54,53,49,48,47,46},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},	
			{
				name = "ArmaEspecial_dir_acabou",
				frames = {58,57,56,42,41,40,39},
				time = 400,
				loopCount = 1,
				loopDirection = "forward"
			},
			
			
		}
			
	
		
		
		
		local heroi = display.newSprite( sheet_heroi, sequencia_heroi )
		heroi.x = 160
		heroi.y = 400
		arma.quadrado = 1
		arma.triangulo = 2
		arma.especial = 3
		sentido.esquerda = 1
		sentido.direita = 2
		heroi.arma = 1
		heroi.sentido = 2
		heroi.powerUpAtivado = false
		
		---physics.addBody(heroi, "kinematic", {bounce = 0})
		heroi:setSequence("verdeDir_andando")
		heroi:play()
		heroi.collision = onCollision
		heroi:addEventListener("collision", heroi)
		
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
			elseif (heroi.arma == 3 and heroi.sentido == 1) then
				if (event.phase == "ended") then 
				spriteAtual:setSequence("rubikEsq_andando")
				spriteAtual:play()
				end
			elseif (heroi.arma == 3 and heroi.sentido == 2) then
				if (event.phase == "ended") then 
				spriteAtual:setSequence("rubikDir_andando")
				spriteAtual:play()
				end
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
	
	
	local function doisMonstrosAtivar (event)
	doisMonstros = false
	dificuldade = dificuldade + 100
	end
		
	local function powerUpAtivo(event)
		if (heroi.sentido == 1) then
		heroi:setSequence("ArmaEspecial_esq_acabou")
		heroi:play()
		heroi.arma = 1
		
		
		elseif (heroi.sentido == 2) then
		heroi:setSequence("ArmaEspecial_dir_acabou")
		heroi:play()
		heroi.arma = 1
		end
		
		powerUp = false
		heroi:addEventListener("sprite", HeroiAtirar)
		heroi.powerUpAtivado = false
	end	
		
	function OnTouch2(self, event)
		
			audio.play(coletandoPowerUp)
		if (self.x == 100 and heroi.arma == 1) then 
			heroi:setSequence("verde_trocandoParaArmaEspecial_esq")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.sentido = 1
			heroi.arma = 3
			elseif (self.x == 220 and heroi.arma == 1) then
			heroi:setSequence("verde_trocandoParaArmaEspecial_dir")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.sentido = 2
			heroi.arma = 3 
			elseif (self.x == 100 and heroi.arma == 2) then
			heroi:setSequence("laranja_trocandoParaArmaEspecial_esq")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.sentido = 1
			heroi.arma = 3 
			elseif (self.x == 220 and heroi.arma == 2) then
			heroi:setSequence("laranja_trocandoParaArmaEspecial_dir")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.sentido = 2
			heroi.arma = 3 
			
		end
		heroi.powerUpAtivado = true
		timer.performWithDelay(5000, powerUpAtivo)
		if(event.phase == "ended") then
		timer.performWithDelay(1, function() self:removeSelf() end )
		audio.play(coletandoPowerUp)
		contadorPowerUP = contadorPowerUP +1
		dificuldade = dificuldade + 50
		score=score+100
		updateTexto()
		end

		return true
	end
	
	
	function OnTouch3 (self, event)
	audio.play(coletandoEstrela)
	if (self.id == 4) then
	score=score+5
	updateTexto()
	contadorEstrela = contadorEstrela +1
	display.remove(self)
	end
	end
	
			
	function criarRubik(self)	
		
		local rubikPowerUP = display.newSprite( sheet_rubik, animacao_rubik )
			rubikPowerUP.x = self.x
			rubikPowerUP.y = self.y
			rubikPowerUP.id = 3	
			rubikPowerUP:setSequence("rubik_girando")
			rubikPowerUP:play()
			rubikPowerUP.touch = OnTouch2
			physics.addBody(rubikPowerUP, "dynamic", {bounce = 0}) 
		
		rubikPowerUP:addEventListener("touch", rubikPowerUP)
			rubikPowerUP:toFront()
			
	end
	
	

-- function rubikPowerUP:touch (event)
	-- if (self.x == 100) then 
			-- heroi:setSequence("rubikEsq_andando")
			-- heroi:play()
			-- powerUpAtivo()
			-- heroi.powerUpAtivado = true 
			-- heroi.sentido = 1
			
			
			-- elseif (self.x == 220) then
			-- heroi:setSequence("rubikDir_andando")
			-- powerUpAtivo()
			-- heroi.powerUpAtivado = true
			-- heroi:play()
			-- heroi.sentido = 2
			
		-- end
		-- if(event.phase == "ended") then
		-- timer.performWithDelay(1, function() self:removeSelf() end )
				-- score=score+100
		-- updateTexto()
		-- end
	
	-- return true
	-- end

	
------- Sprite bolaheroi pulando fim--------------------		

		
		-- function heroiTrocarArma(event) ---- função que chama sprite certo após trocar de arma
		-- local spriteAtual = event.target
			-- if (heroi.arma == 1 and heroi.sentido == 1) then
				-- if (event.phase == "ended") then 
				-- spriteAtual:setSequence("verdeEsq_andando")
				-- spriteAtual:play()
				-- end
			-- elseif (heroi.arma == 1 and heroi.sentido == 2) then
				-- if (event.phase == "ended") then 
				-- spriteAtual:setSequence("verdeDir_andando")
				-- spriteAtual:play()
				-- end
			-- elseif (heroi.arma == 2 and heroi.sentido == 1) then
				-- if (event.phase == "ended") then 
				-- spriteAtual:setSequence("laranjaEsq_andando")
				-- spriteAtual:play()
				-- end		
			-- elseif (heroi.arma == 2 and heroi.sentido == 2) then
				-- if (event.phase == "ended") then 
				-- spriteAtual:setSequence("laranjaDir_andando")
				-- spriteAtual:play()
				-- end
			-- elseif (heroi.arma == 3 and heroi.sentido == 1) then
				-- if (event.phase == "ended") then 
				-- spriteAtual:setSequence("rubikEsq_andando")
				-- spriteAtual:play()
				-- end
			-- elseif (heroi.arma == 2 and heroi.sentido == 2) then
				-- if (event.phase == "ended") then 
				-- spriteAtual:setSequence("rubikDir_andando")
				-- spriteAtual:play()
				-- end
			-- end
		-- end
		
		function heroi:tap(event) --- função para trocar a arma do astronauta
		if (event.numTaps == 1 and heroi.arma ~= 3) then
			audio.play(somTrocandoArma)		
			if (heroi.arma == 1 and heroi.sentido == 2) then
			heroi:setSequence("trocandoParaArmaLaranja_dir")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 2

			print( "Arma vermelha" )
			return true;
			
			elseif (heroi.arma == 1 and heroi.sentido == 1) then
			heroi:setSequence("trocandoParaArmaLaranja_esq")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 2
			
			print( "Arma vermelha" )
			return true;
			
			elseif (heroi.arma == 2 and heroi.sentido == 2) then
			heroi:setSequence("trocandoParaArmaVerde_dir")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 1
			
			print( "Arma verde" )
			return true;
			
			elseif (heroi.arma == 2  and heroi.sentido == 1) then
			heroi:setSequence("trocandoParaArmaVerde_esq")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 1
			print( "Arma verde" )
			return true;
			end
		end
		end

		heroi:addEventListener( "tap" )
		

------- Spawning quadrados ----------------------------
		


	function onTouch(self, event) ------ função destruir monstro 
		
		if (heroi.arma == 3 and heroi.powerUpAtivado == true) then
			if (self.x == 100) then
				heroi:setSequence("rubikEsq_atirando")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.sentido = 1
				elseif (self.x == 220) then
				heroi:setSequence("rubikDir_atirando")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.sentido = 2
			end
			audio.play(somAtirandoPowerUp)
			display.remove(self)
		score=score+10
		monstrosEliminados = monstrosEliminados + 1
		updateTexto()
		
		elseif (heroi.arma == self.id) then
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
				-- elseif (self.id == 3 and self.x == 100) then
				-- heroi:setSequence("rubikEsq_andando")
				-- heroi:play()
				-- heroi.sentido = 1
				-- score=score+90
				-- elseif (self.id == 3 and self.x == 220) then
				-- heroi:setSequence("rubikDir_andando")
				-- heroi:play()
				-- heroi.sentido = 2
				-- score=score+90
			end
		audio.play(somAtirando)
		display.remove(self)
		score=score+10
		monstrosEliminados = monstrosEliminados + 1
		updateTexto()
		if (powerUp == true and heroi.powerUpAtivado == false) then
			powerUp = false
			criarRubik(self)
		end
		
		end
		
		
		return true;
		end	
		
	
	
	textDistancia = display.newText("Distância: "..distancia.." m", display.contentWidth*0.01, 15, "VarelaRound-Regular", 15, left)
    textDistancia:setTextColor(0,0,255)
	textScore = display.newText("Score: "..score, display.contentWidth*0.01, 2, "VarelaRound-Regular", 15, left)
    textScore:setTextColor(0,0,255)
	
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
			if (dificuldade >= 550) then
			dificuldade = dificuldade - 5
			if (dificuldade == 600) then
			doisMonstros = true
			end
			end
			local prob = contadorPowerUP + 10
			local prob2 = (contadorPowerUP+1) * 10
			
			local Fall = math.random(2) == 1 and 220 or 100
			local monstro = math.random(1, 2)
			local cair = math.random(3) == 1 and 280 or 50 or 160
	
	function criarEstrela()	
		
		local estrelaCoin = display.newSprite(sheet_estrela, animacao_estrela)
			estrelaCoin.x = cair
			estrelaCoin.y = -30
 			estrelaCoin.id = 4	
			estrelaCoin:setSequence("estrela_brilhando")
			estrelaCoin:play()
			estrelaCoin.touch = OnTouch3
			physics.addBody(estrelaCoin, "dynamic", {bounce = 0}) 
			estrelaCoin:addEventListener("touch", estrelaCoin)
			estrelaCoin:toFront()
			
	end
			
			
			local combinacao = math.random(1,4)
			local probabilidadeEstrela = math.random(1,3)
			local probabilidadePowerUp = math.random(prob)
			if (doisMonstros == true) then
				if (combinacao == 1)then
				vilao2[i] = display.newSprite(sheet_quad, quad_pulando)
				vilao2[i].id = 1
				vilao[i] = display.newSprite(sheet_quad2, quad_pulando)
				vilao[i].id = 2
				elseif (combinacao == 2) then
				vilao2[i] = display.newSprite(sheet_quad2, quad_pulando)
				vilao2[i].id = 2
				vilao[i] = display.newSprite(sheet_quad, quad_pulando)
				vilao[i].id = 1
				elseif (combinacao == 3) then
				vilao2[i] = display.newSprite(sheet_quad, quad_pulando)
				vilao2[i].id = 1
				vilao[i] = display.newSprite(sheet_quad, quad_pulando)
				vilao[i].id = 1
				elseif (combinacao == 4) then
				vilao2[i] = display.newSprite(sheet_quad2, quad_pulando)
				vilao2[i].id = 2
				vilao[i] = display.newSprite(sheet_quad2, quad_pulando)
				vilao[i].id = 2
				end
				if (probabilidadePowerUp == prob and monstrosEliminados >= prob2 and heroi.powerUpAtivado == false 
				and powerUp == false) then
				rubikCube()
				end
				vilao2[i].x = 100
				vilao2[i].y = -30
				vilao2[i].value = i
				vilao2[i]:setSequence("pulando")
				vilao2[i]:play()	
				vilao2[i].touch = onTouch
				vilao2[i]:addEventListener("touch")
				vilao2[i].enterFrame = andando
				Runtime:addEventListener("enterFrame", vilao2[i])
				
				vilao[i].x = 220
				vilao[i].y = -30   	   	
				vilao[i].value = i 	
				vilao[i]:setSequence("pulando")
				vilao[i]:play()	
				vilao[i].touch = onTouch
				vilao[i]:addEventListener("touch")
				vilao[i].enterFrame = andando
				
				Runtime:addEventListener("enterFrame", vilao[i])
				timer.performWithDelay(1500, doisMonstrosAtivar)
				
			elseif(doisMonstros == false)then
			if (monstro == 1) then
				vilao[i] = display.newSprite(sheet_quad, quad_pulando )
				vilao[i].id = 1
				elseif (monstro == 2) then
				vilao[i] = display.newSprite(sheet_quad2, quad_pulando )
				vilao[i].id = 2
			end
				if (probabilidadePowerUp == prob and monstrosEliminados >= prob2 and heroi.powerUpAtivado == false 
				and powerUp == false) then
				rubikCube()
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
			end
			verificarMetro()
			print (dificuldade)
			i = i + 1
			distancia = distancia + 1
			updateTexto()
			if (metro == true) then
			if (probabilidadeEstrela == 3)then
			criarEstrela()
			end
			score = score+1
			updateTexto()
			metro = false
			end
		
			
	end

	 		
    end
	function vilao2Timer()
	vilaoTimer = timer.performWithDelay( dificuldade,function () spawnQuad(); vilao2Timer() end, 1 ) -- this is a time and 1000 is 1 second and 1000 miliseconds.. it will spawn one circle every one second.. you can change this at your own liking..

	end
    vilao2Timer()
------- Spawning quadrados fim -------------------------

		


