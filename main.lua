display.setStatusBar( display.HiddenStatusBar )

----------------------------------------------------------------------------
-- Configuração de transição para menu
----------------------------------------------------------------------------
local configTransicaoMenu = {
	effect = "fade", time = 1600
}
----------------------------------------------------------------------------

local composer = require ("composer")
composer.gotoScene("inicio", configTransicaoMenu)

local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------------------------------------------
-- Variáveis globais
--------------------------------------------------------------------------------
score = 0
distancia = 0
distanciaAux = 10
monstrosEliminados = 0
contadorItens = 0