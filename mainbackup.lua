
	local i = 1
	local score = 0
	local vilaoTimer
	local vilao = {}
	local vilao2 = {}
	local heroi
	local displayInfo
	local tumuloSprite
	local explosaoSprite
	local iconeRubik
	local iconeCube
	local iconeTriangle
	local grupoMonstros1
	local grupoMonstros2
	local grupoItens
	local textDistancia
	local textIniciar
	local textScore
	local displayGameOver
	local gameOverItens
	local gameOverMonstros
	local gameOverTotal
	local distancia = 0
	local distanciaAux = 10
	local metro = false
	local paused = false
	local powerUp = false
	local gameIsActive = true
	local carregarImagens = {}
	local verificaDistancia
	local contagemRegressiva = 5
	local monstrosEliminados = 0
	local contadorPowerUP = 0
	local dificuldade = 800
	local ativarTempoPowerUp
	local contadorEstrela = 0
	local doisMonstros = false
	local jogoAcabou = false
	local powerUpAtivado = false
	local arma = {'quadrado', 'triangulo', 'especial'}
	local sentido = {'esquerda', 'direita'}

	local somAtirando = audio.loadSound("audio/atirando.wav")
	local somAtirandoPowerUp = audio.loadSound("audio/sfx_wpn_cannon1.wav")
	local coletandoPowerUp = audio.loadSound("audio/sfx_sounds_powerup9.wav")
	local carregandoDisplay = audio.loadSound("audio/sfx_sound_poweron.wav")
	local fechandoDisplay = audio.loadSound("audio/sfx_sound_shutdown1.wav")
	local somTrocandoArma = audio.loadSound("audio/sfx_sounds_button14.wav")
	local coletandoEstrela = audio.loadSound("audio/estrela.wav")
	local bgMusic = audio.loadStream("audio/Out of placemidi MSX.wav")
	local GameOverMusic = audio.loadStream("audio/menu.wav")
	local somMorrendo = audio.loadSound("audio/sfx_exp_cluster3.wav.wav")
	local somAcabandoPowerUp = audio.loadSound("audio/sfx_sound_shutdown2.wav")
	
	
	
	local function updateTexto()
		textScore.text = score
		textDistancia.text = distancia
	end
	
	local function distanciaAuxrMetro()
	verificaDistancia= distancia/distanciaAux
	if (verificaDistancia == 1) then 
	distanciaAux = distanciaAux + 10
	metro = true
	return true
	end 
	end	

	local function rubikCube()
		if (powerUpAtivado == false and powerUp == false ) then
			powerUp = true
		end
	end
	
	
------- Background beginning --------------------

	display.setStatusBar( display.HiddenStatusBar )
		 
	_W = display.contentWidth;
	_H = display.contentHeight; 
	scrollSpeed = 0.7; 
		 
	local bg1 = display.newImageRect("images/rua.png", 320, 480)
	bg1:setReferencePoint(display.CenterLeftReferencePoint)
	bg1.x = 0; bg1.y = _H/2;
		 
	local bg2 = display.newImageRect("images/rua.png", 320, 480)
	bg2:setReferencePoint(display.CenterLeftReferencePoint)
	bg2.x = 0; bg2.y = bg1.y+480;
	
	local bg3 = display.newImageRect("images/rua.png", 320, 480)
	bg3:setReferencePoint(display.CenterLeftReferencePoint)
	bg3.x = 0; bg3.y = bg2.y+480;
	
    local function scrollBackground(event)
     
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
	
	
	function ativarBg()
		Runtime:addEventListener( "enterFrame", scrollBackground )
	end
	function desativarBg()
		Runtime:removeEventListener("enterFrame", scrollBackground)
	end
	
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
			frames = {5,4,3,2},
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
			frames = {10,9,8,7},
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
			frames = {15,14,13,12},
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
			frames = {20,19,18,17},
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
			frames = {27,28,29},
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
			frames = {36,37,38},
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
		}
	}
	
	local rubik = {
		width = 30,
		height = 30,
		numFrames = 11
	}
		
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
		
	local iconeDisplay = {
		width = 30,
		height = 30,
		numFrames = 3
	}
		
	local animacao_iconeDisplay = {
	{
		name = "iconeDisplay_girando",
		start = 1,
		count = 3,
		time = 800,
		loopCount = 0,
		loopDirection = "forward"
		}
	}	

	
	local estrela = {
		width = 16,
		height = 15,
		numFrames = 4
	}
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
	local quadradoVilao = {
	   width = 38,
	   height = 58,
	   numFrames = 16
	}
	local trianguloVilao = {
	   width = 38,
	   height = 65,
	   numFrames = 16
	}
	
	local ripAstronauta = {
	   width = 80,
	   height = 70,
	   numFrames = 10
	}
	
	local explosao = {
	   width = 80,
	   height = 70,
	   numFrames = 5
	}
	
	local explosaoAnimacao = {
		{
			name = "explodindo",
			start = 1,
			count = 5,
			time = 1000,
			loopCount = 1,
			loopDirection = "forward"
		}
	}
	
	local tumuloMexendo = {
		{
			name = "morrendo",
			start = 1,
			count = 10,
			time = 1000,
			loopCount = 0,
			loopDirection = "forward"
		}
	}
	local monstro_pulando = {
		{
			name = "andando",
			start = 1,
			count = 16,
			time = 700,
			loopCount = 0,
			loopDirection = "forward"
		}
	}
	
	local sheet_estrela = graphics.newImageSheet ("images/star.png", estrela)
	local sheet_explosao = graphics.newImageSheet ("images/explosao.png", explosao)
	local sheet_rubik = graphics.newImageSheet ("images/rubikscube.png", rubik)
	local sheet_cubo = graphics.newImageSheet ("images/CubePower.png", iconeDisplay)
	local sheet_triangulo = graphics.newImageSheet ("images/TrianguloMagico.png", iconeDisplay)
	local sheet_tumulo = graphics.newImageSheet ("images/tumulo.png", ripAstronauta)
	------- Sprite monstros andando --------------------	
	
	local sheet_quad = graphics.newImageSheet("images/cubemonstergreen.png", quadradoVilao)
	local sheet_quad2 = graphics.newImageSheet( "images/cube_monster_red.png", quadradoVilao)
	local sheet_quad3 = graphics.newImageSheet( "images/cube_monster_blue.png", quadradoVilao)
	local sheet_tri = graphics.newImageSheet( "images/triagle_cube_monster_green.png", trianguloVilao)
	local sheet_tri2 = graphics.newImageSheet( "images/triagle_cube_monster_red.png", trianguloVilao)
	local sheet_tri3 = graphics.newImageSheet( "images/triagle_cube_monster_blue.png", trianguloVilao)
		
	function explodir()
		explosaoSprite = display.newSprite( sheet_explosao, explosaoAnimacao )
		explosaoSprite.x = 160
		explosaoSprite.y = 436
		explosaoSprite:setSequence("explodindo")
		explosaoSprite:play()
		transition.to(explosaoSprite, {time = 1200, alpha = 0} )
	
	end	
	
	function carregarDados()
		
		displayInfo = display.newImageRect("images/DisplayInfo.png", 320, 80)
		displayInfo.x = display.contentCenterX
		displayInfo.y = -60
		transition.to(displayInfo, {time = 800, y =  display.contentCenterY - 200} )
		audio.play(carregandoDisplay)
		displayInfo:toFront()
		
		local textoDistancia = 
			{
			--parent = textGroup,
			text = distancia,     
			x = display.contentWidth*0.50,
			y = -60,
			width = 128,     --required for multi-line and alignment
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 15,
			align = "right"  --new alignment parameter
		}
		local textoPontos = 
			{
			--parent = textGroup,
			text = score,     
			x = display.contentWidth*0.21,
			y = -60,
			width = 128,     --required for multi-line and alignment
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 15,
			
			align = "left"  --new alignment parameter
		}
		textDistancia = display.newText(textoDistancia)
		textScore = display.newText(textoPontos)
		textDistancia:setTextColor(0,0,0)
		textScore:setTextColor(0,0,0)
		textDistancia.alpha = 0
		textScore.alpha = 0
		transition.to(textDistancia, {time = 800, alpha = 1, y = 19} )
		transition.to(textScore, {time = 800, alpha = 1, y = 19} )
		
		iconeCube = display.newSprite (sheet_cubo, animacao_iconeDisplay)
		iconeCube.x = display.contentCenterX + 0.5
		iconeCube.y = -60
		iconeCube:setSequence("iconeDisplay_girando")
		iconeCube:play()
		iconeCube.alpha = 0
		transition.to(iconeCube, {time = 800, alpha = 1, y = 37} )
		
		iconeTriangle = display.newSprite (sheet_triangulo, animacao_iconeDisplay)
		iconeTriangle.x = display.contentCenterX + 0.5
		iconeTriangle.y = 37
		iconeTriangle:setSequence("iconeDisplay_girando")
		iconeTriangle:play()
		iconeTriangle.alpha = 0
		
		iconeRubik = display.newSprite( sheet_rubik, animacao_rubik )
		iconeRubik.x = display.contentCenterX + 0.5
		iconeRubik.y = 37
		iconeRubik:setSequence("rubik_girando")
		iconeRubik:play()
		iconeRubik.alpha = 0
		
	end
	
	function alterarDisplay()
		if (gameIsActive == true) then
			if (heroi.arma == 1) then
				transition.to(iconeTriangle, {time=100, alpha=0})
				transition.to(iconeRubik, {time=100, alpha=0})
				transition.to(iconeCube, {time=100, alpha=1})
			elseif (heroi.arma == 2) then
				transition.to(iconeRubik, {time=100, alpha=0})
				transition.to(iconeCube, {time=100, alpha=0})
				transition.to(iconeTriangle, {time=100, alpha=1})
			elseif (heroi.arma == 3) then
				transition.to(iconeTriangle, {time=100, alpha=0})
				transition.to(iconeRubik, {time=100, alpha=1})
				transition.to(iconeCube, {time=100, alpha=0})
			end
		end
	end
	function pararDisplay()
		iconeTriangle:pause()
		iconeRubik:pause()
		iconeCube:pause()
		iconeTriangle.alpha = 0
		iconeRubik.alpha = 0
		iconeCube.alpha = 0
		textDistancia.alpha = 0
		textScore.alpha = 0
		transition.to(displayInfo, {time = 400, alpha=0, y =-30} )
		audio.play(fechandoDisplay)
	end
	
	function criarGrupos()
		grupoMonstros1 = display.newGroup()
		grupoMonstros2 = display.newGroup()
		grupoItens = display.newGroup()
	end
	
	function carregarImagens()
		ativarBg()
	end
	
	function criarHeroi()
		heroi = display.newSprite( sheet_heroi, sequencia_heroi )
		tumuloSprite = display.newSprite( sheet_tumulo, tumuloMexendo )
		heroi.x = 160
		heroi.y = 436
		tumuloSprite.x = heroi.x
		tumuloSprite.y = heroi.y
		tumuloSprite.alpha = 0
		heroi.alpha = 1
		arma.quadrado = 1
		arma.triangulo = 2
		arma.especial = 3
		sentido.esquerda = 1
		sentido.direita = 2
		heroi.arma = 1
		heroi.sentido = 2
		heroi.powerUpAtivado = false
		heroi:setSequence("verdeDir_andando")
		heroi:play()
		
		function heroi:tap(event) --- função para trocar a arma do astronauta
		if (event.numTaps == 1 and heroi.arma ~= 3) then
			audio.play(somTrocandoArma)		
			if (heroi.arma == 1 and heroi.sentido == 2) then
			heroi:setSequence("trocandoParaArmaLaranja_dir")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 2
			alterarDisplay()
			print( "Arma vermelha" )
			return true;
			
			elseif (heroi.arma == 1 and heroi.sentido == 1) then
			heroi:setSequence("trocandoParaArmaLaranja_esq")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 2
			alterarDisplay()
			print( "Arma vermelha" )
			return true;
			
			elseif (heroi.arma == 2 and heroi.sentido == 2) then
			heroi:setSequence("trocandoParaArmaVerde_dir")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 1
			alterarDisplay()
			print( "Arma verde" )
			return true;
			
			elseif (heroi.arma == 2  and heroi.sentido == 1) then
			heroi:setSequence("trocandoParaArmaVerde_esq")
			heroi:play()
			heroi:addEventListener("sprite", HeroiAtirar)
			heroi.arma = 1
			alterarDisplay()
			print( "Arma verde" )
			return true;
			end
		end
		end

		heroi:addEventListener( "tap" )
	end
	
	carregarImagens()
	criarGrupos()
	criarHeroi()
	

------- Sprite cubo, estrela, monstros --------------------

	
	
------- FIM sprite cubo, monstros, estrela --------------------
	
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
		heroi.powerUpAtivado = false
		alterarDisplay()
		heroi:addEventListener("sprite", HeroiAtirar)
		audio.play(somAcabandoPowerUp)
		
		print (powerUp)
		print (heroi.powerUpAtivado)
	end
	
	function trocarParaArmaEspecial(self, event) ------------- função para ativar modo Especial ao clicar no cubo magico
		if (gameIsActive == true and heroi.powerUpAtivado == false) then
			audio.play(coletandoPowerUp)
			timer.performWithDelay(1, function() self:removeSelf() end )
			heroi.powerUpAtivado = true
			ativarTempoPowerUp = timer.performWithDelay(5000, powerUpAtivo)
			if (self.x == 100 and heroi.arma == 1) then 
				heroi:setSequence("verde_trocandoParaArmaEspecial_esq")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.sentido = 1
				heroi.arma = 3
				alterarDisplay()
			elseif (self.x == 220 and heroi.arma == 1) then
				heroi:setSequence("verde_trocandoParaArmaEspecial_dir")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.sentido = 2
				heroi.arma = 3 
				alterarDisplay()
			elseif (self.x == 100 and heroi.arma == 2) then
				heroi:setSequence("laranja_trocandoParaArmaEspecial_esq")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.sentido = 1
				heroi.arma = 3 
				alterarDisplay()
			elseif (self.x == 220 and heroi.arma == 2) then
				heroi:setSequence("laranja_trocandoParaArmaEspecial_dir")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.sentido = 2
				heroi.arma = 3 
				alterarDisplay()
			end
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
	end
			
	local function ItemExtraCaindo(self,event) ----- função que move itens extras como Estrela e Cubo Mágico
		if (self.y ~= nil) then
			if (gameIsActive == true) then
				self.y = self.y + 3
				if (self.y >= 481) then
					self.alpha = 0
					self:removeSelf()
				end
			end		
		end		
	end
	
	function coletarEstrelas (self, event) ---------- função para coletar estrelas
		if (gameIsActive == true) then
			audio.play(coletandoEstrela)
			if (self.id == 4) then
				score=score+5
				updateTexto()
				contadorEstrela = contadorEstrela +1
				display.remove(self)
			end
		end
	end
	function criarEstrela()	
		local estrelaCoin = display.newSprite(sheet_estrela, animacao_estrela)
		estrelaCoin.x = math.random(3) == 1 and 295 or 25 or 160
		estrelaCoin.y = -30
		estrelaCoin.id = 4	
		estrelaCoin:setSequence("estrela_brilhando")
		estrelaCoin:play()
		estrelaCoin.touch = coletarEstrelas
		estrelaCoin.enterFrame = ItemExtraCaindo
		Runtime:addEventListener("enterFrame", estrelaCoin)
		estrelaCoin:addEventListener("touch", estrelaCoin)
		grupoItens:insert(estrelaCoin)
	
	end
	
	
	function criarRubik(self)	----- função para criar o cubo magico
		if (powerUp == true and heroi.powerUpAtivado == false) then
			local rubikPowerUP = display.newSprite( sheet_rubik, animacao_rubik )
				rubikPowerUP.x = self.x
				rubikPowerUP.y = self.y
				rubikPowerUP.id = 3	
				rubikPowerUP:setSequence("rubik_girando")
				rubikPowerUP:play()
				rubikPowerUP.touch = trocarParaArmaEspecial
				rubikPowerUP.enterFrame = ItemExtraCaindo
				Runtime:addEventListener("enterFrame", rubikPowerUP)
				rubikPowerUP:addEventListener("touch", rubikPowerUP)
				rubikPowerUP:toFront()
				powerUp = false
				
		end
	end


	
	function HeroiMorrendo()
		transition.to( heroi, {alpha = 0, time=100})
		transition.to( tumuloSprite, {alpha = 1, time=100})
		tumuloSprite:setSequence("morrendo")
		tumuloSprite:play()
	end
	
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
		
	function MonstroMorrendo (event)
		local spriteAtual = event.target
		spriteAtual:setSequence("morrendo")
	end
		
	local function doisMonstrosAtivar (event)
		doisMonstros = false
		dificuldade = dificuldade + 100
	end	
	
	function destruirMonstros(self, event) ------ função destruir monstro 
		if (gameIsActive == true) then
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

				self:setSequence("morrendo")
				self:play()
				if (event.phase == "ended") then 
					audio.play(somAtirandoPowerUp)
					timer.performWithDelay(1, function() self:removeSelf() end )
					Runtime:removeEventListener("enterFrame", self)
					score=score+10
					monstrosEliminados = monstrosEliminados + 1
					updateTexto()
					if (powerUp == true and heroi.powerUpAtivado == false) then
						riarRubik(self)
						powerUp = false
					end
				end
			end
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
				self:setSequence("morrendo")
				self:play()
				if (event.phase == "ended") then 
					audio.play(somAtirando)
					timer.performWithDelay(1, function() self:removeSelf() end )
					self.alpha = 0
					Runtime:removeEventListener("enterFrame", self)
					score=score+10
					monstrosEliminados = monstrosEliminados + 1
					updateTexto()
					if (powerUp == true and heroi.powerUpAtivado == false) then
						criarRubik(self)
						powerUp = false
					end
				end
				
				
			end
		end	
		return true;
	end		

	


	------- Criação dos Monstros ----------------------------
	

	local function monstroAndandoGameOver(self,event)    ------ função para movimentar o monstro e caso atingir o astronauta, dar gameover
		if (self.y ~= nil and gameIsActive == true) then
			self.y = self.y + 2
			if (self.y == heroi.y) then
				gameIsActive = false
				jogoAcabou = true
				print (gameIsActive)
				self:pause()
				GameOver() 
			end
		return gameIsActive
	end	
	end

	local spawnQuad = function()


	------ Sprite quadradovilao pulando --------------------

	------- Sprite quadradovilao pulando fim--------------------
		audio.play(bgMusic, {loops = -1, channel = 1, fadein=1000})
			
			local prob = contadorPowerUP + 10
			local prob2 = (contadorPowerUP+10) * 1
			
			local combinacao = math.random(1,36)
			local probabilidadePowerUp = math.random(prob)
			
			local Fall = math.random(2) == 1 and 220 or 100
			local monstro = math.random(1, 2)
			local monstroCor = math.random(1,3)
			local cair = math.random(3) == 1 and 280 or 50 or 160
	

			
			if (dificuldade >= 550) then
				dificuldade = dificuldade - 5
				if (dificuldade == 600) then
					doisMonstros = true
				end
			end
			
			if (doisMonstros == true) then
				if (combinacao == 1)then
					vilao2[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 2) then
					vilao2[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 3) then
					vilao2[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 4) then
					vilao2[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 5) then
					vilao2[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 6) then
					vilao2[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 7) then
					vilao2[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao[i].id = 1	
				elseif (combinacao == 8) then
					vilao2[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao[i].id = 1
				elseif(combinacao == 9)then
					vilao2[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 10) then
					vilao2[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 11) then
					vilao2[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 12) then
					vilao2[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 13) then
					vilao2[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 14) then
					vilao2[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao[i].id = 2	
				elseif (combinacao == 15) then
					vilao2[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 16) then
					vilao2[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 17) then
					vilao2[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 18) then
					vilao2[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao[i].id = 2	
				elseif(combinacao == 19)then
					vilao2[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 20) then
					vilao2[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 21) then
					vilao2[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 22) then
					vilao2[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 23) then
					vilao2[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 24) then
					vilao2[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao[i].id = 2	
				elseif (combinacao == 25) then
					vilao2[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 26) then
					vilao2[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao[i].id = 2
				elseif (combinacao == 27) then
					vilao2[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao2[i].id = 1
					vilao[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao[i].id = 2	
				elseif(combinacao == 28)then
					vilao2[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 29) then
					vilao2[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 30) then
					vilao2[i] = display.newSprite(sheet_tri, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 31) then
					vilao2[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 32) then
					vilao2[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 33) then
					vilao2[i] = display.newSprite(sheet_tri2, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao[i].id = 1	
				elseif (combinacao == 34) then
					vilao2[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 35) then
					vilao2[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad2, monstro_pulando)
					vilao[i].id = 1
				elseif (combinacao == 36) then
					vilao2[i] = display.newSprite(sheet_tri3, monstro_pulando)
					vilao2[i].id = 2
					vilao[i] = display.newSprite(sheet_quad3, monstro_pulando)
					vilao[i].id = 1		
				end
				
				if (probabilidadePowerUp == prob and monstrosEliminados >= prob2 and heroi.powerUpAtivado == false 
					and powerUp == false) then
					rubikCube()
				end
				vilao2[i].x = 100
				vilao2[i].y = -30
				vilao2[i].value = i
				vilao2[i]:setSequence("andando")
				vilao2[i]:play()	
				vilao2[i].touch = destruirMonstros
				vilao2[i]:addEventListener("touch")
				vilao2[i].enterFrame = monstroAndandoGameOver
				Runtime:addEventListener("enterFrame", vilao2[i])
				grupoMonstros2:insert(vilao2[i])
				if (vilao2[i].y == 433) then
					vilao2[i]:pause()
				end
				
				vilao[i].x = 220
				vilao[i].y = -30   	   	
				vilao[i].value = i 	
				vilao[i]:setSequence("andando")
				vilao[i]:play()	
				vilao[i].touch = destruirMonstros
				vilao[i]:addEventListener("touch")
				vilao[i].enterFrame = monstroAndandoGameOver
				
				Runtime:addEventListener("enterFrame", vilao[i])
				grupoMonstros1:insert(vilao[i])
				
				
				timer.performWithDelay(1500, doisMonstrosAtivar)
				
				
			elseif(doisMonstros == false)then
				if (monstro == 1) then
					if (monstroCor == 1) then
						vilao[i] = display.newSprite(sheet_quad, monstro_pulando )
						elseif (monstroCor == 2) then
						vilao[i] = display.newSprite(sheet_quad2, monstro_pulando )
						elseif (monstroCor == 3) then
						vilao[i] = display.newSprite(sheet_quad3, monstro_pulando )	
					end
					vilao[i].id = 1
				elseif (monstro == 2) then
					if (monstroCor == 1) then					
						vilao[i] = display.newSprite(sheet_tri, monstro_pulando )
						elseif (monstroCor == 2) then
						vilao[i] = display.newSprite(sheet_tri2, monstro_pulando )
						elseif (monstroCor == 3) then
						vilao[i] = display.newSprite(sheet_tri3, monstro_pulando )
					end
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
				vilao[i]:setSequence("andando")
				vilao[i]:play()	
				vilao[i].touch = destruirMonstros
				vilao[i]:addEventListener("touch")
				vilao[i].enterFrame = monstroAndandoGameOver
				
				Runtime:addEventListener("enterFrame", vilao[i])
				if (vilao[i].id == 1) then
					grupoMonstros1:insert(vilao[i])
				elseif (vilao[i].id == 2) then
					grupoMonstros2:insert(vilao[i])
				end
				
			end
			
			distanciaAuxrMetro()
			print (dificuldade)
			i = i + 1
			distancia = distancia + 1
			updateTexto()
			if (metro == true) then

			score = score+1
			updateTexto()
			metro = false
			end

	 		
    end
	
	function IniciarJogo()
		timer.performWithDelay( 1000, ativarEstrela(), 1 )
		vilaoTimer = timer.performWithDelay( dificuldade,function () spawnQuad(); IniciarJogo() end, 1 ) 
		
	end
  
  
	function telaDeGameOver()
	  displayGameOver = display.newImageRect("images/gameOver.png", 300, 316)
	  displayGameOver.x = _W/2
	  displayGameOver.y = _H
	  displayGameOver.alpha = 0.1
	  transition.to( displayGameOver, {alpha = 1, time=400, x=(_W/2), y=(_H/2)} )
	  
		local textoItens = 
			{
			--parent = textGroup,
			text = contadorEstrela.."x5",     
			x = _W/2 + 10,
			y = _H,
			width = 110,     --required for multi-line and alignment
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 20,
			
			align = "right"  --new alignment parameter
		}
		local textoMonstros = 
			{
			--parent = textGroup,
			text = monstrosEliminados.."x10",     
			x = _W/2 + 15,
			y = _H,
			width = 110,     --required for multi-line and alignment
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 20,
			
			align = "right"  --new alignment parameter
		}
		local textoPontos = 
			{
			--parent = textGroup,
			text = score,     
			x = _W/2,
			y = _H,
			width = 110,     --required for multi-line and alignment
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 20,
			
			align = "right"  --new alignment parameter
		}
		gameOverItens = display.newText(textoItens)
		gameOverMonstros = display.newText(textoMonstros)
		gameOverTotal = display.newText(textoPontos)
		gameOverItens:setTextColor(255,255,255)
		gameOverMonstros:setTextColor(255,255,255)
		gameOverTotal:setTextColor(255,255,255)
		gameOverItens.alpha = 0
		gameOverMonstros.alpha = 0
		gameOverTotal.alpha = 0
		transition.to(gameOverItens, {time = 400, alpha = 1, y = (_H/2) - 38} )
		transition.to(gameOverMonstros, {time = 400, alpha = 1, y = (_H/2) + 25 } )
		transition.to(gameOverTotal, {time = 400, alpha = 1,y = (_H/2) + 70} )
	  
	  
	end
	
	function ativarEstrela()
		local probabilidadeEstrela = math.random(1,10)
		if (distancia/distanciaAux == 1) then
			if (probabilidadeEstrela == 2)then
				criarEstrela()
			end
		end
	end
	
		audio.setVolume( 0.50 , { channel=1 })
	
	function GameOver() 
		Runtime:removeEventListener( "enterFrame", move )
		heroi:removeEventListener( "tap" )
		heroi:removeEventListener("sprite", HeroiAtirar)
		Runtime:removeEventListener("enterFrame", vilao2[i])
		Runtime:removeEventListener("enterFrame", vilao[i])
		timer.performWithDelay(1000, timer.pause(vilaoTimer))
		desativarBg()
		explodir()
		pararDisplay()
		HeroiMorrendo()
		audio.setVolume( 0.20, { channel=1 })
		telaDeGameOver()
		grupoMonstros1.alpha = 0
		grupoMonstros1:removeSelf()
		if (grupoMonstros2 ~= nil) then
			grupoMonstros2.alpha = 0
			grupoMonstros2:removeSelf()
		end
		if (grupoItens ~= nil) then
			grupoItens.alpha = 0
			grupoItens:removeSelf()
		end
		if (ativarTempoPowerUp ~= nil) then
			timer.pause(ativarTempoPowerUp)
		end

		
		
		--heroi:setSequence("morrendo")
		--heroi:play()
		
	end
	
	
	
	IniciarJogo()
	carregarDados()
	
	
------- Spawning quadrados fim -------------------------




