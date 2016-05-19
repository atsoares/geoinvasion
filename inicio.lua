--------------------------------------------------------------------------------
-- Inicializar composer
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local botaoJogar
local botaoCredito
local botaoVoltarMenu
local carregandoEstrelas1
local carregandoEstrelas2
local comoJogar
local creditos = {}
local criarGrupos = {}
local comecarJogo = {}
local carregarSubMenu = {}
local carregarImgsMenu = {}
local carregarEstrelas = {}
local carregarEstrelas2 = {}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImgsMenu()
  

  local somInicio = audio.loadStream( "audio/8bit.mp3" )
  audio.play(somInicio, {loops = -1, channel = 1, fadein=1000})
  audio.setVolume( 0.50 , { channel=1 })
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("menu")
  composer.removeScene("jogo")
  composer.removeScene("creditos")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    botaoJogar:addEventListener("touch", comecarJogo)
    botaoCredito:addEventListener("touch", creditos)
    botaoVoltarMenu:addEventListener("touch", menu)
	carregandoEstrelas1 = timer.performWithDelay(1000, carregarEstrelas, 0)
    carregandoEstrelas2 = timer.performWithDelay(1500, carregarEstrelas2, 0)
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
	
  audio.stop(1)
  display.remove(background)
  if (carregandoEstrelas1) then
    timer.cancel(carregandoEstrelas1)
    carregandoEstrelas1 = nil
  end
  if (carregandoEstrelas2) then
    timer.cancel(carregandoEstrelas2)
    carregandoEstrelas2 = nil
  end
  if (carregandoToqueAqui) then
    timer.cancel(carregandoToqueAqui)
    carregandoToqueAqui = nil
  end
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  grupoMenu = display.newGroup( )
  scene.view:insert(grupoMenu)
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarImgsMenu( )
  background = display.newImageRect("images/SkyFullOfStars0.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)

  ceuEstrelado = display.newImageRect("images/SkyFullOfStars1.png", display.contentWidth, display.contentHeight)
  ceuEstrelado.x = display.contentCenterX
  ceuEstrelado.y = display.contentCenterY
  ceuEstrelado.alpha = 1
  scene.view:insert(ceuEstrelado)

  ceuEstrelado2 = display.newImageRect("images/SkyFullOfStars2.png", display.contentWidth, display.contentHeight)
  ceuEstrelado2.x = display.contentCenterX
  ceuEstrelado2.y = display.contentCenterY
  ceuEstrelado2.alpha = 0
  scene.view:insert(ceuEstrelado2)

  comoJogar = display.newImage("images/comoJogar.png", display.contentWidth, display.contentHeight)
  comoJogar.x = display.contentCenterX
  comoJogar.y = display.contentCenterY
  comoJogar.alpha = 1
  scene.view:insert(comoJogar)
  
  botaoVoltarMenu = display.newImage("images/botaoVoltar.png", display.contentWidth, display.contentHeight)
  botaoVoltarMenu.x = display.contentCenterX - 120
  botaoVoltarMenu.y = display.contentCenterY - 225
  botaoVoltarMenu.alpha = 1
  scene.view:insert(botaoVoltarMenu)
  
  botaoCredito = display.newImage("images/botaoCredito.png", display.contentWidth, display.contentHeight)
  botaoCredito.x = display.contentCenterX - 100
  botaoCredito.y = display.contentCenterY + 225
  botaoCredito.alpha = 1
  scene.view:insert(botaoCredito)
  
  botaoJogar = display.newImage("images/botaoJogar.png", display.contentWidth, display.contentHeight)
  botaoJogar.x = display.contentCenterX + 110
  botaoJogar.y = display.contentCenterY + 225
  botaoJogar.alpha = 1
  scene.view:insert(botaoJogar)
  
  
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Carregar background com estrelas brilhando
--------------------------------------------------------------------------------
function carregarEstrelas()
  if (ceuEstrelado ~= nil) then
    if (ceuEstrelado.alpha > 0) then
        transition.to(ceuEstrelado, {time=1200, alpha=0})
    else
        transition.to(ceuEstrelado, {time=1200, alpha=1})
    end
  end
end

function carregarEstrelas2()
  if (ceuEstrelado2 ~= nil) then
    if (ceuEstrelado2.alpha > 0) then
        transition.to(ceuEstrelado2, {time=1500, alpha=0})
    else
        transition.to(ceuEstrelado2, {time=1500, alpha=1})
    end
  end
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicao = {
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função que chama cena para início do jogo
--------------------------------------------------------------------------------
function comecarJogo( )
	composer.removeScene("inicio")
	composer.gotoScene("jogo", configTransicao)
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função que chama cena de créditos do jogo
--------------------------------------------------------------------------------
function creditos( )
	composer.removeScene("inicio")
	composer.gotoScene("creditos", configTransicao)
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Função que chama cena de inicio do jogo
--------------------------------------------------------------------------------
function menu( )
	composer.removeScene("inicio")
	composer.gotoScene("menu", configTransicao)
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

