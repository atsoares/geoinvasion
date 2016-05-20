--------------------------------------------------------------------------------
-- Inicializar composer
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local carregandologo
local carregandoTerra
local carregandoIniciar
local carregandoEstrelas1
local carregandoEstrelas2
local iniciar
local apertou = false
local LogoAtiva = false
local geoInvasionLogo
local criarGrupos = {}
local carregarImgsInicio = {}
local carregarMenu = {}
local carregarTextoIniciar = {}
local carregarEfeitoIniciar = {}
local carregarEstrelas = {}
local carregarEstrelas2 = {}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImgsInicio()
  criarGrupos()
  carregarTextoIniciar()
 

  local somInicio = audio.loadStream( "audio/menu.mp3" )
  audio.play(somInicio, {loops = -1, channel = 1, fadein=1000})
  audio.setVolume( 0.85 , { channel=1 })
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
    logomarca:addEventListener("touch", carregarMenu)
    carregandoIniciar = timer.performWithDelay(1000, carregarEfeitoIniciar, 0)
    carregandoEstrelas1 = timer.performWithDelay(1000, carregarEstrelas, 0)
    carregandoEstrelas2 = timer.performWithDelay(1500, carregarEstrelas2, 0)
	carregandoLogo = timer.performWithDelay(4000, carregarLogo, 0)
	carregandoTerra = timer.performWithDelay(100, carregarTerra, 0)
	
    -- Chama quando a cena está na tela
    -- Inserir código para fazer que a cena venha "viva"
    -- Ex: start times, begin animation, play audio, etc
  end
end
--------------------------------------------------------------------------------


function apertarBotao()
	apertou = true
	
end



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
  if (carregandoIniciar) then
    timer.cancel(carregandoIniciar)
    carregandoIniciar = nil
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
function carregarImgsInicio( )
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

  logomarca = display.newImage("images/logo.png", display.contentWidth, display.contentHeight)
  logomarca.x = display.contentCenterX
  logomarca.y = display.contentCenterY - 100
  logomarca.alpha = 0
  scene.view:insert(logomarca)
  
  terra = display.newImage("images/terra2.png")
  terra.x = display.contentCenterX
  terra.y = display.contentCenterY + 480
  terra.alpha = 0.1
  scene.view:insert(terra)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar texto de "Iniciar"
--------------------------------------------------------------------------------
function carregarTextoIniciar()
 iniciar = display.newImage("images/textoIniciar.png")
 iniciar.x = display.contentCenterX
 iniciar.y = display.contentCenterY 
 iniciar.alpha = 0
 scene.view:insert(iniciar)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar efeito de texto de "Iniciar" 
--------------------------------------------------------------------------------
function carregarEfeitoIniciar()
  if (iniciar ~= nil and logomarca.LogoAtiva == true) then
    if (iniciar.alpha > 0) then
        transition.to(iniciar, {time=100, alpha=0})
    else
        transition.to(iniciar, {time=100, alpha=1})
    end
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar Terra no background
--------------------------------------------------------------------------------
function carregarTerra()
  if (terra ~= nil) then
        transition.to(terra, {time=2000, alpha=1,y=(display.contentCenterY + 162)})
  end
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Carregar Logo
--------------------------------------------------------------------------------
function carregarLogo()
  if (logomarca ~= nil) then
        transition.to(logomarca, {time=3000, alpha=1, onComplete = LogoApareceu})
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar LogoApareceu
--------------------------------------------------------------------------------
function LogoApareceu()
  if (logomarca ~= nil) then
        logomarca.LogoAtiva = true
  end
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
