display.setStatusBar( display.HiddenStatusBar )

----------------------------------------------------------------------------
-- Configuração de transição para menu
----------------------------------------------------------------------------
local configTransicaoMenu = {
	effect = "fade", time = 1600
}
----------------------------------------------------------------------------

local composer = require ("composer")
composer.gotoScene("menu", configTransicaoMenu)

local composer = require("composer")
local scene = composer.newScene()



