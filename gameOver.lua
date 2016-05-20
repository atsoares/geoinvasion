--------------------------------------------------------------------------------
-- Inicializar composer
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene( )

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local tumuloSprite
local botaoJogarNovamente
local botaoRetornarMenu
local displayGameOver
local gameOverItens
local gameOverMonstros
local gameOverTotal
local _W = display.contentWidth;
local _H = display.contentHeight;
local carregarImagens = {}
local criarTumulo = {}
local recomecarJogo = {}
local retornarMenu = {}
local carregarImgsGameOver = {}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Sprites
--------------------------------------------------------------------------------
local ripAstronauta = {
	width = 130,
	height = 114,
	numFrames = 10
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
local sheet_tumulo = graphics.newImageSheet ("images/tumulo.png", ripAstronauta)
--------------------------------------------------------------------------------
		

--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImagens()
  criarTumulo() 

  local somMenu = audio.loadStream( "audio/Innovating PSG.mp3" )
  audio.play(somMenu, {loops = -1, channel = 1, fadein = 1000})
  audio.setVolume( 0.25 , { channel=1 })
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("jogo")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
	carregarImgsGameOver()
    botaoJogarNovamente:addEventListener("touch", retornarJogo)
    botaoRetornarMenu:addEventListener("touch", retornarMenu)
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
    -- Chama quando a cena está na cena
    -- Inserir código para "pausar" a cena
    -- Ex: stop timers, stop animation, stop audio, etc
  elseif (phase == "did") then
    --gameOver()
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
  display.remove(background)
  display.remove(tumuloSprite)
  display.remove(displayGameOver)
  display.remove(gameOverItens)
  display.remove(gameOverMonstros)
  display.remove(gameOverTotal)
  display.remove(botaoJogarNovamente)
  display.remove(botaoRetornarMenu)
  
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
		background1.x = display.contentCenterX 
		background1.y = display.contentCenterY 
		scene.view:insert(background1)	
	end
--------------------------------------------------------------------------------	

--------------------------------------------------------------------------------
-- Função para criar tumulo
--------------------------------------------------------------------------------
	function criarTumulo() 
		tumuloSprite = display.newSprite( sheet_tumulo, tumuloMexendo )
		tumuloSprite.x = 160
		tumuloSprite.y = 436
		tumuloSprite:setSequence("morrendo")
		tumuloSprite:play()
		scene.view:insert(tumuloSprite)
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para chamar tela de game over
--------------------------------------------------------------------------------
	function carregarImgsGameOver()
		displayGameOver = display.newImageRect("images/gameOver.png", 300, 316)
		displayGameOver.x = _W/2
		displayGameOver.y = _H
		displayGameOver.alpha = 0
		transition.to( displayGameOver, {alpha = 1, time=400, x=(_W/2), y=(_H/2)} )
	  
		local textoItens = 
			{
			text = contadorItens.."x5",     
			x = _W/2 + 10,
			y = _H,
			width = 110,    
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 20,
			align = "right"  --new alignment parameter
		}
		local textoMonstros = 
			{
			text = monstrosEliminados.."x10",     
			x = _W/2 + 15,
			y = _H,
			width = 110,    
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 20,
			align = "right"  
		}
		local textoPontos = 
			{
			text = score,     
			x = _W/2,
			y = _H,
			width = 110,  
			font = "Retro Computer_DEMO.ttf",   
			fontSize = 20,
			align = "right"  --new alignment parameter
		}
		gameOverItens = display.newText(textoItens)
		gameOverItens:setTextColor(255,255,255)
		gameOverItens.alpha = 0
		transition.to(gameOverItens, {time = 400, alpha = 1, y = (_H/2) - 38} )
		
		gameOverMonstros = display.newText(textoMonstros)
		gameOverMonstros:setTextColor(255,255,255)
		gameOverMonstros.alpha = 0
		transition.to(gameOverMonstros, {time = 400, alpha = 1, y = (_H/2) + 25 } )
		
		gameOverTotal = display.newText(textoPontos)
		gameOverTotal:setTextColor(255,255,255)
		gameOverTotal.alpha = 0
		transition.to(gameOverTotal, {time = 400, alpha = 1,y = (_H/2) + 70} )  
		
		botaoJogarNovamente = display.newImage("images/botaoJogarNovamente.png",display.contentWidth, display.contentHeight)
		botaoJogarNovamente.x = _W/2
		botaoJogarNovamente.y = _H
		botaoJogarNovamente.alpha = 0
		transition.to( botaoJogarNovamente, {alpha = 1, time=400, x=(_W/2) - 55 , y=(_H/2) + 115} )
		
		botaoRetornarMenu = display.newImage("images/botaoMenu.png",display.contentWidth, display.contentHeight)
		botaoRetornarMenu.x = _W/2
		botaoRetornarMenu.y = _H
		botaoRetornarMenu.alpha = 0
		transition.to( botaoRetornarMenu, {alpha = 1, time=400, x=(_W/2) + 95, y=(_H/2)  + 115} )
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para sair do jogo
--------------------------------------------------------------------------------
	function fecharJogo()
	  if (system.getInfo("platformName") == "Android") then
		native.requestExit()
	  else
		os.exit()
	  end
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
	local configTransicaoJogoSubMenu = {
		effect = "fade", time = 400
	}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
	function retornarJogo( )
		composer.removeScene("gameOver")
		composer.gotoScene("jogo", configTransicaoJogoSubMenu)
		score = 0
		distancia = 0
		distanciaAux = 10
		monstrosEliminados = 0
		contadorItens = 0
	end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
	function retornarMenu( )
		composer.removeScene("gameOver")
		composer.gotoScene("menu", configTransicaoJogoSubMenu)
		score = 0
		distancia = 0
		distanciaAux = 10
		monstrosEliminados = 0
		contadorItens = 0
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
