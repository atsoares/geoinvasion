--------------------------------------------------------------------------------
-- Inicializar composer
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------------------------------------------
------- Declaração de variaveis ------------------------------------------------
--------------------------------------------------------------------------------
	local i = 1
	local ativandoCriarMonstros
	local vilao = {}
	local vilao2 = {}
	local heroi
	local estrelaCoin
	local rubikPowerUP
	local displayInfo
	local explosaoSprite
	local iconeRubik
	local iconeCube
	local iconeTriangle
	local grupoMonstros1
	local grupoMonstros2
	local grupoItens
	local grupoRubik
	local textDistancia
	local textIniciar
	local textScore
	local ativandoItensColetaveis
	local probabilidadeItensColetaveis
	local displayAtivo = false
	local metro = false
	local paused = false
	local powerUp = false
	local gameIsActive = true
	local verificaDistancia
	local contagemRegressiva = 5
	local contadorPowerUP = 0
	local dificuldade = 800
	local ativarTempoPowerUp
	local doisMonstros = false
	local jogoAcabou = false
	local powerUpAtivado = false
	local trocarArma = {}
	local carregarImagens = {}
	local carregarDisplay = {}
	local ativarDisplay = {}
	local alterarDisplay = {}
	local pararDisplay = {}
	local ativarBg = {}
	local desativarBg = {}
	local updateTexto = {}
	local distanciaAuxrMetro = {}
	local ativarRubikCube = {}
	local efeitoExplosao = {}
	local criarHeroi = {}
	local desativarPowerUp = {}
	local ativarPowerUp = {}
	local ItemExtraCaindo = {}
	local coletarItem = {}
	local criarItensColetaveis = {}
	local criarRubik = {}
	local HeroiMorrendo = {}
	local HeroiAtirar = {}
	local doisMonstrosDesativar = {}
	local criarMonstros = {}
	local destruirMonstros = {}
	local monstroAndandoGameOver = {}
	local chamarGameOver = {}
	local scrollSpeed = 0.7; 
	local _W = display.contentWidth;
	local _H = display.contentHeight;
	local arma = {'quadrado', 'triangulo', 'especial'}
	local sentido = {'esquerda', 'direita'}
	arma.quadrado = 1
	arma.triangulo = 2
	arma.especial = 3
	sentido.esquerda = 1
	sentido.direita = 2
	
	local somAtirando = audio.loadSound("audio/atirando.wav")
	local somAtirandoPowerUp = audio.loadSound("audio/sfx_wpn_cannon1.wav")
	local coletandoPowerUp = audio.loadSound("audio/sfx_sounds_powerup9.wav")
	local carregandoDisplay = audio.loadSound("audio/sfx_sound_poweron.wav")
	local fechandoDisplay = audio.loadSound("audio/sfx_sound_shutdown1.wav")
	local somTrocandoArma = audio.loadSound("audio/sfx_sounds_button14.wav")
	local coletandoEstrela = audio.loadSound("audio/estrela.wav")
	local somMorrendo = audio.loadSound("audio/sfx_exp_cluster3.wav")
	local somAcabandoPowerUp = audio.loadSound("audio/sfx_sound_shutdown2.wav")
	
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
------- Declaração de todos os sprites
------- Ex: Astronauta, Monstros, Cubo Magico, Icones do display, Itens
--------------------------------------------------------------------------------

	local sequencia_heroi = {
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
	
	local astronauta = {
	   width = 80,
	   height = 70,
	   numFrames = 58,
	   sheetContentWidth = 5440,
	   sheetContentHeight = 70  
	}
	
	local iconeDisplay = {
		width = 30,
		height = 30,
		numFrames = 3,
	   sheetContentWidth = 90,
	   sheetContentHeight = 30  
	}
	
	local rubik = {
		width = 30,
		height = 30,
		numFrames = 11,
	   sheetContentWidth = 330,
	   sheetContentHeight = 30  
	}
	
	local quadradoVilao = {
	   width = 38,
	   height = 58,
	   numFrames = 16,
	   sheetContentWidth = 608,
	   sheetContentHeight = 58 
	}
	local trianguloVilao = {
	   width = 38,
	   height = 65,
	   numFrames = 16,
	   sheetContentWidth = 608,
	   sheetContentHeight = 65 
	}
	
	local explosao = {
	   width = 80,
	   height = 70,
	   numFrames = 5,
	   sheetContentWidth = 400,
	   sheetContentHeight = 70 
	}
	
	local estrela = {
		width = 16,
		height = 15,
		numFrames = 4,
		sheetContentWidth = 80,
	   sheetContentHeight = 15 
	}
	
	local sheet_heroi = graphics.newImageSheet( "images/Astronauta.png", astronauta )
	local sheet_estrela = graphics.newImageSheet ("images/star.png", estrela)
	local sheet_explosao = graphics.newImageSheet ("images/explosao.png", explosao)
	local sheet_rubik = graphics.newImageSheet ("images/rubikscube.png", rubik)
	local sheet_cubo = graphics.newImageSheet ("images/CubePower.png", iconeDisplay)
	local sheet_triangulo = graphics.newImageSheet ("images/TrianguloMagico.png", iconeDisplay)
	local sheet_quad = graphics.newImageSheet("images/cubemonstergreen.png", quadradoVilao)
	local sheet_quad2 = graphics.newImageSheet( "images/cube_monster_red.png", quadradoVilao)
	local sheet_quad3 = graphics.newImageSheet( "images/cube_monster_blue.png", quadradoVilao)
	local sheet_tri = graphics.newImageSheet( "images/triagle_cube_monster_green.png", trianguloVilao)
	local sheet_tri2 = graphics.newImageSheet( "images/triagle_cube_monster_red.png", trianguloVilao)
	local sheet_tri3 = graphics.newImageSheet( "images/triagle_cube_monster_blue.png", trianguloVilao)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImagens()
  
 
  local bgMusic = audio.loadStream("audio/Out of placemidi MSX.wav")
  audio.play(bgMusic, {loops = -1, channel = 1, fadein = 2000})
  audio.setVolume( 0.50 , { channel=1 })
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("gameOver")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
	criarHeroi()
	criarGrupos()
	ativarBg()
	carregarDisplay()
	IniciarJogo()
	ativarDisplay()
	heroi:addEventListener("tap", trocarArma)

    -- Chama quando a cena está na tela
    -- Inserir código para fazer que a cena venha "viva"
    -- Ex: start times, begin animation, play audio, etc
  end
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Scene:hide
--------------------------------------------------------------------------------
function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na tela
    -- Inserir código para "pausar" a cena
    -- Ex: stop timers, stop animation, stop audio, etc
  elseif (phase == "did") then
    --Runtime.removeEventListener("enterFrame", criarOrbita)
    -- Chama imediatamente quando a cena está fora da tela
  end
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Scene:destroy
--------------------------------------------------------------------------------
function scene:destroy(event)
  local sceneGroup = self.view

	audio.stop(1)
  --composer.removeScene( "jogo" )
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função para carregar as imagens: background
--------------------------------------------------------------------------------
	function carregarImagens()
		background1 = display.newImageRect("images/rua.png", 320, 480)
		background1:setReferencePoint(display.CenterLeftReferencePoint)
		background1.x = 0; background1.y = _H/2;
		scene.view:insert(background1)	
		
		background2 = display.newImageRect("images/rua.png", 320, 480)
		background2:setReferencePoint(display.CenterLeftReferencePoint)
		background2.x = 0; background2.y = background1.y+480;
		scene.view:insert(background2)
		
		background3 = display.newImageRect("images/rua.png", 320, 480)
		background3:setReferencePoint(display.CenterLeftReferencePoint)
		background3.x = 0; background3.y = background2.y+480;
		scene.view:insert(background3)
	end
--------------------------------------------------------------------------------	


--------------------------------------------------------------------------------
-- Função para carregar as imagens: background e display com pontuação
--------------------------------------------------------------------------------
	function carregarDisplay()
		displayInfo = display.newImageRect("images/DisplayInfo.png", 320, 80)
		displayInfo.x = display.contentCenterX
		displayInfo.y = -60
		displayInfo:toFront()
		scene.view:insert(displayInfo)
		
		local textoDistancia = 
			{
				text = distancia,     
				x = display.contentWidth*0.50,
				y = -60,
				width = 128,   
				font = "Retro Computer_DEMO.ttf",   
				fontSize = 15,
				align = "right"
			}
		local textoPontos = 
			{
				text = score, 
				x = display.contentWidth*0.21,
				y = -60,
				width = 128,
				font = "Retro Computer_DEMO.ttf",   
				fontSize = 15,
				align = "left"
			}
		textDistancia = display.newText(textoDistancia)
		textScore = display.newText(textoPontos)
		textDistancia:setTextColor(0,0,0)
		textScore:setTextColor(0,0,0)
		textDistancia.alpha = 0
		textScore.alpha = 0
		scene.view:insert(textDistancia)
		scene.view:insert(textScore)
		
		iconeCube = display.newSprite (sheet_cubo, animacao_iconeDisplay)
		iconeCube.x = display.contentCenterX + 0.5
		iconeCube.y = -60
		iconeCube.alpha = 0
		scene.view:insert(iconeCube)
		
		iconeTriangle = display.newSprite (sheet_triangulo, animacao_iconeDisplay)
		iconeTriangle.x = display.contentCenterX + 0.5
		iconeTriangle.y = 37
		iconeTriangle.alpha = 0
		scene.view:insert(iconeTriangle)
		
		iconeRubik = display.newSprite( sheet_rubik, animacao_rubik )
		iconeRubik.x = display.contentCenterX + 0.5
		iconeRubik.y = 37
		iconeRubik.alpha = 0
		scene.view:insert(iconeRubik)
end
--------------------------------------------------------------------------------


	function displayAtivado()
		displayAtivo = true
	end


--------------------------------------------------------------------------------
-- Função para ativar display com pontuação
--------------------------------------------------------------------------------
	function ativarDisplay()
		if (displayInfo ~= nil) then
			transition.to(displayInfo, {time = 800, y =  display.contentCenterY - 200} )
			audio.play(carregandoDisplay)
		end	
		if (textDistancia ~= nil and textScore ~= nil) then
			transition.to(textDistancia, {time = 900, alpha = 1, y = 19} )
			transition.to(textScore, {time = 900, alpha = 1, y = 19} )
		end	
		if (iconeCube ~= nil and iconeTriangle ~= nil and iconeRubik ~= nil) then	
			iconeCube:setSequence("iconeDisplay_girando")
			iconeCube:play()
			iconeTriangle:setSequence("iconeDisplay_girando")
			iconeTriangle:play()
			iconeRubik:setSequence("rubik_girando")
			iconeRubik:play()
			transition.to(iconeCube, {time = 800, alpha = 1, y = 37, onComplete = displayAtivado} )
		end	
	end
--------------------------------------------------------------------------------
	
--------------------------------------------------------------------------------
-- Função para alterar display de acordo com a arma que está sendo utilizada
--------------------------------------------------------------------------------	
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
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função que desativa display
--------------------------------------------------------------------------------	
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
--------------------------------------------------------------------------------	
	
--------------------------------------------------------------------------------
-- Função para criar os grupos 
--------------------------------------------------------------------------------	
	function criarGrupos()
		grupoMonstros1 = display.newGroup()
		grupoMonstros2 = display.newGroup()
		grupoItens = display.newGroup()
		grupoRubik = display.newGroup()
		scene.view:insert(grupoMonstros1)
		scene.view:insert(grupoMonstros2)
		scene.view:insert(grupoItens)
		scene.view:insert(grupoRubik)
		
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para mover background
--------------------------------------------------------------------------------	
	local function scrollBackground(event)
     
		background1.y = background1.y + scrollSpeed
		background2.y = background2.y + scrollSpeed
		background3.y = background3.y + scrollSpeed
     
		if (background1.y + background1.contentWidth) > 1040 then
			background1:translate( 0, -960 )
		end
		if (background2.y + background2.contentWidth) > 1040 then
			background2:translate( 0, -960 )
		end
		if (background3.y + background3.contentWidth) > 1040 then
			background3:translate( 0, -960 )
		end
    end
--------------------------------------------------------------------------------	
	
--------------------------------------------------------------------------------
-- Função para ativar o movimento do background
--------------------------------------------------------------------------------			
	function ativarBg()
		Runtime:addEventListener( "enterFrame", scrollBackground )
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para desativar o movimento do background
--------------------------------------------------------------------------------		
	function desativarBg()
		Runtime:removeEventListener("enterFrame", scrollBackground)
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para atualizar texto no display 
--------------------------------------------------------------------------------
	function updateTexto()
		textScore.text = score
		textDistancia.text = distancia
	end
--------------------------------------------------------------------------------
	
--------------------------------------------------------------------------------
-- Função que adiciona pontos por distancia
--------------------------------------------------------------------------------	
	function distanciaAuxrMetro()
	verificaDistancia= distancia/distanciaAux
		if (verificaDistancia == 1) then 
			distanciaAux = distanciaAux + 10
			metro = true
			return true
		end 
	end	
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para ativar a criação do Drop do monstro: cubo mágico
--------------------------------------------------------------------------------
	function ativarRubikCube()
		if (powerUpAtivado == false and powerUp == false ) then
			powerUp = true
		end
	end
--------------------------------------------------------------------------------	
	
--------------------------------------------------------------------------------
-- Função para criar efeito de explosão
--------------------------------------------------------------------------------	
	function efeitoExplosao()
		explosaoSprite = display.newSprite( sheet_explosao, explosaoAnimacao )
		explosaoSprite.x = 160
		explosaoSprite.y = 436
		explosaoSprite:setSequence("explodindo")
		explosaoSprite:play()
		scene.view:insert(explosaoSprite)	
		transition.to(explosaoSprite, {time = 1200, alpha = 0} )
	end	
--------------------------------------------------------------------------------		
	
--------------------------------------------------------------------------------
-- Função para criar o heroi Astronauta
--------------------------------------------------------------------------------	
	function criarHeroi()
		heroi = display.newSprite( sheet_heroi, sequencia_heroi )
		heroi.x = 160
		heroi.y = 436
		heroi.arma = 1
		heroi.sentido = 2
		heroi.tap = trocarArma
		heroi.powerUpAtivado = false
		heroi:setSequence("verdeDir_andando")
		heroi:play()
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para  trocar a arma do astronauta
--------------------------------------------------------------------------------			
	function trocarArma(event) 
		if (event.numTaps == 1 and heroi.arma ~= 3 and displayAtivo == true) then
			audio.play(somTrocandoArma)		
			if (heroi.arma == 1 and heroi.sentido == 2) then
				heroi:setSequence("trocandoParaArmaLaranja_dir")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.arma = 2
				alterarDisplay()
				return true;	
			elseif (heroi.arma == 1 and heroi.sentido == 1) then
				heroi:setSequence("trocandoParaArmaLaranja_esq")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.arma = 2
				alterarDisplay()
				return true;
			elseif (heroi.arma == 2 and heroi.sentido == 2) then
				heroi:setSequence("trocandoParaArmaVerde_dir")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.arma = 1
				alterarDisplay()
				return true;
			elseif (heroi.arma == 2  and heroi.sentido == 1) then
				heroi:setSequence("trocandoParaArmaVerde_esq")
				heroi:play()
				heroi:addEventListener("sprite", HeroiAtirar)
				heroi.arma = 1
				alterarDisplay()
				return true;
			end
		end
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para desativar PowerUp do heroi
--------------------------------------------------------------------------------	
	 function desativarPowerUp(event)
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
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para ativar modo Especial ao clicar no cubo magico
--------------------------------------------------------------------------------		
	function ativarPowerUp(self, event) 
		if (gameIsActive == true and heroi.powerUpAtivado == false) then
			local probabilidadeDificuldade = math.random(2) == 1 and 25 or 50
			audio.play(coletandoPowerUp)
			timer.performWithDelay(1, function() self:removeSelf() end )
			heroi.powerUpAtivado = true
			ativarTempoPowerUp = timer.performWithDelay(5000, desativarPowerUp)
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
				dificuldade = dificuldade + probabilidadeDificuldade
				score=score+100
				updateTexto()
				self = nil
			end
		return true
		end
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para mover itens extras
-- Ex: Cubo Magico e itens coletaveis
--------------------------------------------------------------------------------			
	local function ItemExtraCaindo(self,event)
		if (self.y ~= nil) then
			if (gameIsActive == true) then
				self.y = self.y + 3
				if (self.y > 481) then
					self.alpha = 0
					self:removeSelf()
					self = nil
					Runtime:removeEventListener("enterFrame", self)
				end
			end		
		end		
	end
--------------------------------------------------------------------------------	

--------------------------------------------------------------------------------
-- Função para coletar itens
--------------------------------------------------------------------------------		
	function coletarItem (self, event) 
		if (gameIsActive == true) then
			audio.play(coletandoEstrela)
			if (self.id == 4) then
				score=score+5
				updateTexto()
				contadorItens = contadorItens +1
				display.remove(self)
				self = nil
			end
		end
	end
--------------------------------------------------------------------------------	

--------------------------------------------------------------------------------
-- Função para criar itens
-- Ex: estrela
--------------------------------------------------------------------------------	
	function criarItensColetaveis()	
		estrelaCoin = display.newSprite(sheet_estrela, animacao_estrela)
		estrelaCoin.x = math.random(3) == 1 and 295 or 25 or 160
		estrelaCoin.y = -30
		estrelaCoin.id = 4	
		estrelaCoin:setSequence("estrela_brilhando")
		estrelaCoin:play()
		estrelaCoin.touch = coletarItem
		estrelaCoin.enterFrame = ItemExtraCaindo
		estrelaCoin:addEventListener("touch", estrelaCoin)
		Runtime:addEventListener("enterFrame", estrelaCoin)
		grupoItens:insert(estrelaCoin)
	end
--------------------------------------------------------------------------------
	

--------------------------------------------------------------------------------
-- Função para ativar os Itens coletaveis
--------------------------------------------------------------------------------	
	function ativarItensColetaveis()
		probabilidadeItensColetaveis = math.random(1,15)
		if (distancia > 10) then
			if (probabilidadeItensColetaveis == 2)then
				criarItensColetaveis()
			end
		end
	end
--------------------------------------------------------------------------------
	
--------------------------------------------------------------------------------
-- Função para criar cubo mágico
--------------------------------------------------------------------------------	
	function criarRubik(self)
		if (powerUp == true and heroi.powerUpAtivado == false) then
			    rubikPowerUP = display.newSprite( sheet_rubik, animacao_rubik )
				rubikPowerUP.x = self.x
				rubikPowerUP.y = self.y
				rubikPowerUP.id = 3	
				rubikPowerUP:setSequence("rubik_girando")
				rubikPowerUP:play()
				rubikPowerUP.touch = ativarPowerUp
				rubikPowerUP.enterFrame = ItemExtraCaindo
				rubikPowerUP:addEventListener("touch", rubikPowerUP)
				Runtime:addEventListener("enterFrame", rubikPowerUP)
				rubikPowerUP:toFront()
				grupoRubik:insert(rubikPowerUP)
				powerUp = false
		end
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para criar efeito quando Heroi morrer
--------------------------------------------------------------------------------		
	function HeroiMorrendo()
		transition.to( heroi, {alpha = 0, time=100})
	end
--------------------------------------------------------------------------------	

--------------------------------------------------------------------------------
-- Função para chamar os sprites do heroi no momento certo
--------------------------------------------------------------------------------		
	function HeroiAtirar (event)
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
--------------------------------------------------------------------------------
	
--------------------------------------------------------------------------------
-- Função para desativar o efeito de vir dois monstros ao mesmo tempo
--------------------------------------------------------------------------------	
	function doisMonstrosDesativar (event)
		doisMonstros = false
		dificuldade = dificuldade + 100
	end	
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para destruir o monstro por Touch
--------------------------------------------------------------------------------	
	function destruirMonstros(self, event) 
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
--------------------------------------------------------------------------------

	
--------------------------------------------------------------------------------
-- Função para mover o monstro e chamar gameOver se atingir heroi
--------------------------------------------------------------------------------	
	function monstroAndandoGameOver(self,event)
		if (self.y ~= nil and gameIsActive == true) then
			self.y = self.y + 2
			if (self.y == heroi.y) then
				gameIsActive = false
				jogoAcabou = true
				chamarGameOver() 
			end
		return gameIsActive
		end	
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para criar monstros
--------------------------------------------------------------------------------
	local criarMonstros = function()
		
			local prob = contadorPowerUP + 30
			local prob2 = (contadorPowerUP+10) * (contadorPowerUP+1)
			
			local combinacao = math.random(1,36)
			local probabilidadePowerUp = math.random(prob)
			local contadorDoisMonstros = 0
			local tempoDoisMonstros = (contadorDoisMonstros*1000) + 1500
			
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
					ativarRubikCube()
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
				contadorDoisMonstros = contadorDoisMonstros + 1
				
				timer.performWithDelay(tempoDoisMonstros, doisMonstrosDesativar)
				
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
					ativarRubikCube()
				end
				
				vilao[i].x = Fall
				vilao[i].y = -30   	   	
				vilao[i].value = i 	
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
			i = i + 1
			--distancia = distancia + 1
			updateTexto()
			if (metro == true) then
				score = score+1
				updateTexto()
				metro = false
			end
end
--------------------------------------------------------------------------------
	
--------------------------------------------------------------------------------
-- Função para iniciar o jogo
--------------------------------------------------------------------------------
	function IniciarJogo()
		ativandoItensColetaveis = timer.performWithDelay( 1000, ativarItensColetaveis, 1 )
		ativandoCriarMonstros = timer.performWithDelay( dificuldade,function () criarMonstros(); IniciarJogo() end, 1 ) 
	end
 --------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para criar os efeitos antes chamar tela de  gameOver
-------------------------------------------------------------------------------- 
	function chamarGameOver() 
		
		efeitoExplosao()
		system.vibrate()
		HeroiMorrendo()
		pararDisplay()
		desativarBg()
		heroi:removeEventListener( "tap" )
		heroi:removeEventListener("sprite", HeroiAtirar)
		Runtime:removeEventListener("enterFrame", vilao2[i])
		Runtime:removeEventListener("enterFrame", vilao[i])
		-- if (rubikPowerUP ~= nil) then
			-- rubikPowerUP:removeEventListener("touch", rubikPowerUP)
			-- Runtime:removeEventListener("enterFrame", rubikPowerUP)
		-- end
		-- if (estrelaCoin ~= nil) then
			-- estrelaCoin:removeEventListener("touch", estrelaCoin)
			-- Runtime:removeEventListener("enterFrame", estrelaCoin)
		-- end
		if (ativandoCriarMonstros) then
			timer.cancel(ativandoCriarMonstros)
			ativandoCriarMonstros = nil
		end
		if (ativarTempoPowerUp ~= nil) then
			timer.cancel(ativarTempoPowerUp)
			ativarTempoPowerUp = nil
		end
		if (ativandoItensColetaveis ~= nil) then
			timer.cancel(ativandoItensColetaveis)
			ativandoItensColetaveis = nil
		end
		if (grupoMonstros1 ~= nil) then
			grupoMonstros1.alpha = 0
			grupoMonstros1:removeSelf()
		end
		if (grupoMonstros2 ~= nil) then
			grupoMonstros2.alpha = 0
			grupoMonstros2:removeSelf()
		end
		if (grupoItens ~= nil) then
			grupoItens.alpha = 0
			grupoItens:removeSelf()
		end
		if (grupoRubik ~= nil) then
			grupoRubik.alpha = 0
			grupoRubik:removeSelf()
		end

		timer.performWithDelay(1300, gameOver)
		
	end
-------------------------------------------------------------------------------- 
	
--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoGameOver = {
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para início do jogo
--------------------------------------------------------------------------------
function gameOver()
  composer.removeScene("jogo")
  composer.gotoScene("gameOver", configTransicaoGameOver)
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Listener Setup
--------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
--------------------------------------------------------------------------------

return scene




	
------- Spawning quadrados fim -------------------------




