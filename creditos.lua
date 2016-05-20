--------------------------------------------------------------------------------
-- Inicializar composer
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene( )
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local botaoVoltarMenu
local creditosTxt
local logomarca
local carregarImgsMenu = {}
local _W = display.contentWidth;
local _H = display.contentHeight;
local scrollSpeed = 2;
local ativarBg = {}
local desativarBg = {}
local carregarImagens = {}
	
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImagens()
  carregarImgsMenu()
  
  audio.play(somMenu, {loops = -1, channel = 1, fadein=1000})
  audio.setVolume( 0.25, { channel=1 })
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("menu")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    botaoVoltarMenu:addEventListener("touch", carregarMenu)
	ativarBg()
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
    -- Chama imediatamente quando a cena está fora da tela
  end
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Scene:destroy
--------------------------------------------------------------------------------
function scene:destroy(event)
  local sceneGroup = self.view
  
  desativarBg()
  display.remove(logomarca)
  display.remove(creditosTxt)
  display.remove(background1)
  display.remove(background2)
  display.remove(background3)
  
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para carregar as imagens: background
--------------------------------------------------------------------------------
	function carregarImagens()
		background1 = display.newImageRect("images/backgroundCredito1.png", 320, 480)
		background1:setReferencePoint(display.CenterLeftReferencePoint)
		background1.x = 0; background1.y = _H/2;
		scene.view:insert(background1)	
		
		background2 = display.newImageRect("images/backgroundCredito1.png", 320, 480)
		background2:setReferencePoint(display.CenterLeftReferencePoint)
		background2.x = 0; background2.y = background1.y+480;
		scene.view:insert(background2)
		
		background3 = display.newImageRect("images/backgroundCredito1.png", 320, 480)
		background3:setReferencePoint(display.CenterLeftReferencePoint)
		background3.x = 0; background3.y = background2.y+480;
		scene.view:insert(background3)
	end
--------------------------------------------------------------------------------	


--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarImgsMenu( )
  
  creditosTxt = display.newImageRect("images/creditosTxt.png", 259, 208)
  creditosTxt.x = display.contentCenterX
  creditosTxt.y = display.contentCenterY + 70
  scene.view:insert(creditosTxt)
  
  botaoVoltarMenu = display.newImage("images/botaoVoltar.png", display.contentWidth, display.contentHeight)
  botaoVoltarMenu.x = display.contentCenterX - 120
  botaoVoltarMenu.y = display.contentCenterY - 225
  botaoVoltarMenu.alpha = 1
  scene.view:insert(botaoVoltarMenu)
  
  logomarca = display.newImage("images/logoComBorda.png", display.contentWidth, display.contentHeight)
  logomarca.x = display.contentCenterX
  logomarca.y = display.contentCenterY - 120
  logomarca.alpha = 1
  scene.view:insert(logomarca)

  
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função para mover background
--------------------------------------------------------------------------------	
	local function scrollBackground(event)
     
		background1.y = background1.y - scrollSpeed
		background2.y = background2.y - scrollSpeed
		background3.y = background3.y - scrollSpeed
     
		if (background1.y + background1.contentWidth) < 0 then
			background1:translate( 0, 480*3 )
		end
		if (background2.y + background2.contentWidth) < 0 then
			background2:translate( 0, 480*3 )
		end
		if (background3.y + background3.contentWidth) < 0 then
			background3:translate( 0, 480*3 )
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
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoMenu = {
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função que chama cena de submenu do jogo
--------------------------------------------------------------------------------
function carregarMenu( )
	local somIniciar = audio.loadSound( "audio/sfx_menu_select4.wav")
	audio.play(somIniciar)
	composer.removeScene("inicio")
	composer.gotoScene("menu", configTransicaoMenu)
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


