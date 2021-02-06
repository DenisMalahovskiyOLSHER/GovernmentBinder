script_version("11.0")
script_author("Denis_Richard")

require "lib.moonloader"
local memory = require 'memory'
local imgui = require 'imgui'
local key = require 'vkeys'
local rkeys = require 'rkeys'
local encoding = require 'encoding'
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
local bNotf, notf = pcall(import, "imgui_notf.lua")
local encoding = require "encoding"
encoding.default = 'CP1251'
u8 = encoding.UTF8

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end

if not doesDirectoryExist('moonloader/config/governmate') then 
    createDirectory('moonloader/config/governmate') 
end
if doesFileExist("moonloader/config/governmate/9g0shNM.png") and doesFileExist("moonloader/config/governmate/LvJoDB8.png") then
    user = imgui.CreateTextureFromFile(getGameDirectory().. "/moonloader/config/governmate/LvJoDB8.png")
    logo = imgui.CreateTextureFromFile(getGameDirectory().. "/moonloader/config/governmate/9g0shNM.png")
else
    downloadUrlToFile("https://i.imgur.com/9g0shNM.png", "moonloader/config/governmate/9g0shNM.png", function(id, status, p1, p2) 
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            logo = imgui.CreateTextureFromFile(getGameDirectory().. "/moonloader/config/governmate/9g0shNM.png")
        end 
    end)
    downloadUrlToFile("https://i.imgur.com/LvJoDB8.png", "moonloader/config/governmate/LvJoDB8.png", function(id, status, p1, p2) 
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            logo = imgui.CreateTextureFromFile(getGameDirectory().. "/moonloader/config/governmate/LvJoDB8.png")
        end 
    end)
end

local mainini = inicfg.load({
    config =
    {
        NickNameText = u8"",
        Rang = u8"",
        GOV1 = u8"",
        GOV2 = u8"",
        GOV3 = u8"",
        Post = u8"",
        TimeGovka = "",
        Teg = "",
        Number = "",
        Nameorg = "",
    }
}, "governmate/governmate")

local status = inicfg.load(mainini, 'governmate/governmate.ini')
if not doesFileExist('moonloader/config/governmate/governmate.ini') then inicfg.save(mainini, 'governmate/governmate.ini') end

local NickNameText = imgui.ImBuffer(tostring(mainini.config.NickNameText), 256)
local Rang = imgui.ImBuffer(tostring(mainini.config.Rang), 256)
local GOV1 = imgui.ImBuffer(tostring(mainini.config.GOV1), 256)
local GOV2 = imgui.ImBuffer(tostring(mainini.config.GOV2), 256)
local GOV3 = imgui.ImBuffer(tostring(mainini.config.GOV3), 256)
local Post = imgui.ImBuffer(tostring(mainini.config.Post), 256)
local TimeGovka = imgui.ImBuffer(tostring(mainini.config.TimeGovka), 256)
local Teg = imgui.ImBuffer(tostring(mainini.config.Teg), 256)
local Number = imgui.ImBuffer(tostring(mainini.config.Number), 256)
local Nameorg = imgui.ImBuffer(tostring(mainini.config.Nameorg), 256)

local xw, yw = getScreenResolution()
local font = renderCreateFont('Arial', 8, 4 + 8)
local menuPos = imgui.ImVec2(xw / 2, yw / 2)
local menuActive = imgui.ImBool(false)
local menuHideCursor = imgui.ImBool(false)
local activeTab = 0
local active_menu = imgui.ImBool(false)
local active_menu_list = imgui.ImBool(false)
local needsInit = 0

local savee = "governmate/governmate.ini"

local combokeys = {
    {VK_NUMPAD0}, {VK_NUMPAD1}, {VK_NUMPAD2}, {VK_NUMPAD3}, {VK_NUMPAD4}, {VK_NUMPAD5}, {VK_NUMPAD6}, {VK_NUMPAD7}, {VK_NUMPAD8}, {VK_NUMPAD9}, 
    {VK_CONTROL, VK_NUMPAD0}, {VK_CONTROL, VK_NUMPAD1}, {VK_CONTROL, VK_NUMPAD2}, {VK_CONTROL, VK_NUMPAD3}, {VK_CONTROL, VK_NUMPAD4}, {VK_CONTROL, VK_NUMPAD5}, 
    {VK_MENU, VK_NUMPAD0}, {VK_MENU, VK_NUMPAD1}, {VK_MENU, VK_NUMPAD2}, {VK_MENU, VK_NUMPAD3}, {VK_MENU, VK_NUMPAD4},
    {VK_F1}
}
function clearAllHotkeys()
    for i = 1, #combokeys do
        --if isHotKeyDefined(combokeys[i]) then
            rkeys.unRegisterHotKey(combokeys[i])
        --end
    end
    
end

function RegisterHotkeysForBank()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) .."*íà ãðóäè âåñèò áåéäæèê ".. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('×åì ìîãó áûòü ëþáåçåí?')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/do Äóáèíêà íà ïîÿñå.')
            wait(3500)
            sampSendChat('/todo Ïðîøó âàñ âåñòè ñåáÿ àêêóðàòíî èëè ÿ âàñ âûãîíþ èç áàíêà*ñíèìàÿ äóáèíêó')
            wait(3500)
            sampSendChat('/do Äóáèíêà ñíÿòà ñ ïîÿñà.')
            wait(3500)
            sampSendChat('/me áåðåò äóáèíêó â ðóêè')
            wait(3500)
            sampSendChat('/do Äóáèíêà â ðóêàõ.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me íàêèäûâàåòñÿ íà íàðóøèòåëÿ è ïûòàåòñÿ çàëîìàòü åìó ðóêè.')
            wait(3500)
            sampSendChat('/me êðåïêî äåðæà íàðóøèòåëÿ çà ðóêè, âûâîäèò åãî íà óëèöó.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/expel ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âåøàåò äóáèíêó íà ïîÿñ')
            wait(3500)
            sampSendChat('/do Äóáèíêà íà ïîÿñå.')
            end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me çàø¸ë â áàçó äàííûõ Öåíòðàëüíîãî Áàíêà ')
            wait(3500)
            sampSendChat('/me íàø¸ë ïðîôèëü ãðàæäàíèíà è âïèñàë äàííûå ')
            wait(3500)
            sampSendChat('/do Äàííûå âïèñàíû. ')
            wait(3500)
            sampSendChat('/me âçÿë ïå÷àòü "ÖÁ" ')
            wait(3500)
            sampSendChat('/do Ïå÷àòü "ÖÁ" â ðóêàõ. ')
            wait(3500)
            sampSendChat('/me ïîñòàâèë ïå÷àòü "ÖÁ" ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Çäðàâñòâóéòå, ÿ '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'. Âû æåëàåòå âîññòàíîâèòü ïèí-êîä îò êàðòû?')
            wait(3500)
            sampSendChat('Õîðîøî, ïåðåäàéòå ìíå âàø ïàñïîðò.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò ')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ. ')
            wait(3500)
            sampSendChat('Õîðîøî, ñåé÷àñ áóäåì âîññòàíàâëèâàòü. ')
            wait(3500)
            sampSendChat('/me ïðîáèë ïî áàçå äàííûõ êàðòî÷åê öåíòðàëüíîãî áàíêà èìÿ è ôàìèëèþ ãðàæäàíèíà ')
            wait(3500)
            sampSendChat('/do Îáíàðóæèë êàðòî÷êó â áàçå äàííûõ.')
            wait(3500)
            sampSendChat('/me çàíåñ â áàçó äàííûõ íîâûé ïàðîëü ')
            wait(3500)
            sampSendChat('/me âîññòàíîâèë ïèí êîä êàðòî÷êè ãðàæäàíèíà ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('Çäðàâñòâóéòå, ÿ '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'. Âû æåëàåòå îôîðìèòü êðåäèò?')
            wait(3500)
            sampSendChat('Õîðîøî, ïåðåäàéòå ìíå âàø ïàñïîðò.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('Õîðîøî, ñåé÷àñ áóäåì îôîðìëÿòü äîêóìåíòû íà êðåäèò.')
            wait(3500)
            sampSendChat('/me ïðîáèë ïî áàçå äàííûõ öåíòðàëüíîãî áàíêà èìÿ è ôàìèëèþ ãðàæäàíèíà')
            wait(3500)
            sampSendChat('/do Îáíàðóæèë ãðàæäàíèíà â áàçå äàííûõ.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('/r Äîêëàäûâàåò: '.. u8:decode(mainini.config.NickNameText) ..' | Ïîñò: ¹'.. u8:decode(mainini.config.Post) ..' | Ñîñòîÿíèå: ñòàáèëüíîå')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) ..'*íà ãðóäè âåñèò áåéäæèê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Õîðîøî.Äàâàéòå ñâîè äîêóìåíòû. À èìåííî ïàñïîðò,ëèöåíçèè è ìåä.êàðòà.')
            wait(3500)
            sampSendChat('/b Âñ¸ ïî ðï')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîâåðèâ äîêóìåíòû, ïåðåäàë ÷åëîâåêó íàïðîòèâ')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âçÿë ëèöåíçèè â ðóêè ')
            wait(3500)
            sampSendChat('/do Ëèöåíçèè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ ïàêåò ëèöåíçèé, îòäàë âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ìåä.êíèæêó â ðóêè ')
            wait(3500)
            sampSendChat('/do Ìåä.êíèæêà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ Ìåä.êíèãó, îòäàëà âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Äîêóìåíòû â ïîëíîì ïîðÿäêå ')
            wait(3500)
            sampSendChat('Âû ïðèíÿòû íà ñòàæèðîâêó.')
            wait(3500)
            sampSendChat('/do Ïîä ñòîëîì ëåæèò ïàêåò ñ ôîðìîé è ðàöèåé.')
            wait(3500)
            sampSendChat('/me äîñòàë ïàêåò è ïåðåäàëà ÷åëîâåêó íàïðîòèâ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âñåõ, ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Äðåññ-Êîä".')
            wait(3500)
            sampSendChat('Âî-ïåðâûõ, ôîðìà ñîòðóäíèêà äîëæíà áûòü ïîãëàæåíà è ÷èñòà.')
            wait(3500)
            sampSendChat('Âî-âòîðûõ, Âû íå äîëæíû âûãëÿäåòü êàê íà ìàñêàðàäå.')
            wait(3500)
            sampSendChat('Íèêàêèõ ìàåê, êîðîòêèõ þáîê è ò.ä')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Óâàæàåìûå ñîòðóäíèêè Öåíòðàëüíîãî áàíêà, ïðîøó ìèíóòî÷êó âíèìàíèå!')
            wait(3500)
            sampSendChat('Õî÷ó âàì ñêàçàòü, ÷òî òðàíñïîðò ñ äîëæíîñòè "Îõðàííèê" - Çàïðåùåíî áðàòü!')
            wait(3500)
            sampSendChat('Ñ äîëæíîñòè "Ñò.Îõðàííèê" òîæå çàïðåùåíî, áóäüòå âíèìàòåëüíû.')
            wait(3500)
            sampSendChat('Åñëè óâèäåëè íàðóøèòåëÿ êîòîðûé êàòàåòcÿ íà òðàíñïîðòå, íàðóøàÿ óñòàâ.')
            wait(3500)
            sampSendChat('Ïîäàâàéòå â æàëîáíóþ êíèãó íà ñîòðóäíèêà êîòîðûé íàðóøèë óñòàâ.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âàñ íà ëåêöèè î ñóáîðäèíàöèè.')
            wait(3500)
            sampSendChat('Äëÿ íà÷àëà ðàññêàæó, ÷òî òàêîå ñóáîðäèíàöèÿ.')
            wait(3500)
            sampSendChat('Ñóáîðäèíàöèÿ - ïðàâèëà ïîä÷èíåíèÿ ìëàäøèõ ïî çâàíèþ ê ñòàðøèì ïî çâàíèþ óâàæåíèå, îòíîøåíèå ê íèì.')
            wait(3500)
            sampSendChat('Òî åñòü ìëàäøèå ñîòðóäíèêè äîëæíû âûïîëíÿòü ïðèêàçû íà÷àëüñòâà.')
            wait(3500)
            sampSendChat('Êòî îñëóøàåòñÿ - ñïåðâà ïîëó÷èò óñòíîå ïðåäóïðåæäåíèå, ïîñëåäóþùèé ðàç - âûãîâîð.')
            wait(3500)
            sampSendChat('Âû äîëæíû ñ óâàæåíèåì îòíîñèòñÿ ê íà÷àëüñòâó è ñòàðøèì ïî äîëæíîñòè íà "Âû".')
            wait(3500)
            sampSendChat('Íå íàðóøàéòå ïðàâèëà è íå íàðóøàéòå ñóáîðäèíàöèþ äàáû íå ïîëó÷èòü íàêàçàíèå.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Ïîãîâîðèì òàê æå è î Ýòèêåòå...')
            wait(3500)
            sampSendChat('Ïðè íà÷àëå äèàëîãà âû äîëæíû ïî ïðèâåòñòâîâàòü ñîáåñåäíèêà...')
            wait(3500)
            sampSendChat('...à â êîíöå äèàëîãà ïîïðîùàòüñÿ')
            wait(3500)
            sampSendChat('Ñîáëþäàòü óâàæåíèå ïðè îáùåíèè')
            wait(3500)
            sampSendChat('Çàïðåùåíî, âìåøèâàòüñÿ â ÷óæîé ðàçãîâîð')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ñåé÷àñ ÿ ïðî÷èòàþ ëåêöèþ î âðåäå íàðêîòèêîâ.')
            wait(3500)
            sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
            wait(3500)
            sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
            wait(3500)
            sampSendChat('Çà÷àñòóþ íàðêîçàâèñèìûå ïñèõîëîãè÷åñêè íåñòàáèëüíû.')
            wait(3500)
            sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè âûøå ðèñê çàðàæåíèÿ çàáîëåâàíèÿìè.')
            wait(3500)
            sampSendChat('Íà ñåãîäíÿøíèé äåíü íàèáîëåå ðàñïðîñòðàíåíû ñëåäóþùèå âèäû íàðêîòèêîâ...')
            wait(3500)
            sampSendChat('...ìàðèõóàíà, êîêàèí, àìôåòàìèíû, ýêñòàçè, îïèóì.')
            wait(3500)
            sampSendChat('Êàæäûé ìîæåò è äîëæåí ïðîòèâîñòîÿòü íàðêîìàíèè.')
            wait(3500)
            sampSendChat('Îáðåòèòå óâåðåííîñòü â òîì, ÷òî âàì ëè÷íî íàðêîòèêè íå íóæíû.')
            wait(3500)
            sampSendChat('Ëåêöèÿ çàêîí÷åíà. Ñïàñèáî çà âíèìàíèå.')
        end)
end

function RegisterHotkeysForGovernment()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function ()       
            sampSendChat('Çäðàâñòâóéòå, ÿ '.. u8:decode(mainini.config.Rang) ..' - '.. u8:decode(mainini.config.NickNameText) ..'.')
            wait(3500)
            sampSendChat('/do Íà ãðóäè áåéäæèê: '.. u8:decode(mainini.config.Rang) ..'.')
            wait(3500)
            sampSendChat('×åì ìîãó âàì ïîìî÷ü? ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function ()
            sampSendChat('/do Äóáèíêà âèñèò íà ïîÿñå â ñïåöèàëüíîì êðåïëåíèè.')
            wait(3500)
            sampSendChat('/me ðåçêèì äâèæåíèåì ïðàâîé ðóêè ñíÿë(à) äóáèíêó ñ ïîÿñà')
            wait(3500)
            sampSendChat('/do Äóáèíêà íàõîäèòñÿ â ïðàâîé ðóêå.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function ()
            sampSendChat('/todo Ïðîøó âàñ âåñòè ñåáÿ ñïîêîéíî èëè ÿ âàñ âûâåäó èç çäàíèÿ*ñíèìàÿ äóáèíêó')
            wait(3500)
            sampSendChat('/do Äóáèíêà ñíÿòà ñ ïîÿñà.')
            wait(3500)
            sampSendChat('/me áåðåò äóáèíêó â ïðàâóþ ðóêó')
            wait(3500)
            sampSendChat('/do Äóáèíêà â ïðàâîé ðóêå.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function ()
            sampSendChat('/me íàêèäûâàåòñÿ íà íàðóøèòåëÿ è ïûòàåòñÿ çàëîìàòü åìó ðóêè ')
            wait(3500)
            sampSendChat('/me êðåïêî äåðæà íàðóøèòåëÿ çà ðóêè, âûâîäèò åãî íà óëèöó ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/expel ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function ()
            sampSendChat('/do Äóáèíêà íàõîäèòñÿ â ïðàâîé ðóêå.')
            wait(3500)
            sampSendChat('/me ïëàâíûì äâèæåíèåì ïðàâîé ðóêè ïîâåñèë(à) äóáèíêó íà ïîÿñ â ñïåöèàëüíîå êðåïëåíèå')
            wait(3500)
            sampSendChat('/do Äóáèíêà íàõîäèòñÿ íà ïîÿñå â ñïåöèàëüíîì êðåïëåíèè.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function ()
            sampSendChat('/do Óäîñòîâåðåíèå íàõîäèòñÿ â ïðàâîì âíóòðåííåì êàðìàíå ïèäæàêà.')
            wait(3500)
            sampSendChat('/me ïëàâíûì äâèæåíèåì ëåâîé ðóêîé ïðèîòêðûë ïèäæàê')
            wait(3500)
            sampSendChat('/me äîñòàë ïðàâîé ðóêîé èç âíóòðåííåãî êàðìàíà ïèäæàêà óäîñòîâåðåíèå')
            wait(3500)
            sampSendChat('/do Óäîñòîâåðåíèå â ïðàâîé ðóêå.')
            wait(3500)
            sampSendChat('/me îòêðûë óäîñòîâåðåíèå')
            wait(3500)
            sampSendChat('/do Óäîñòîâåðåíèå â îòêðûòîì âèäå.')
            wait(3500)
            sampSendChat('/do Â óäîñòîâåðåíèè íàïèñàíî: '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/showpass ")
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) ..'*íà ãðóäè âåñèò áåéäæèê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Õîðîøî.Äàâàéòå ñâîè äîêóìåíòû. À èìåííî ïàñïîðò,ëèöåíçèè è ìåä.êàðòà.')
            wait(3500)
            sampSendChat('/b Âñ¸ ïî ðï')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîâåðèâ äîêóìåíòû, ïåðåäàë ÷åëîâåêó íàïðîòèâ')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âçÿë ëèöåíçèè â ðóêè ')
            wait(3500)
            sampSendChat('/do Ëèöåíçèè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ ïàêåò ëèöåíçèé, îòäàë âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ìåä.êíèæêó â ðóêè ')
            wait(3500)
            sampSendChat('/do Ìåä.êíèæêà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ Ìåä.êíèãó, îòäàëà âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Äîêóìåíòû â ïîëíîì ïîðÿäêå ')
            wait(3500)
            sampSendChat('Âû ïðèíÿòû íà ñòàæèðîâêó.')
            wait(3500)
            sampSendChat('/do Ïîä ñòîëîì ëåæèò ïàêåò ñ ôîðìîé è ðàöèåé.')
            wait(3500)
            sampSendChat('/me äîñòàë ïàêåò è ïåðåäàëà ÷åëîâåêó íàïðîòèâ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âñåõ, ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Äðåññ-Êîä".')
            wait(3500)
            sampSendChat('Âî-ïåðâûõ, ôîðìà ñîòðóäíèêà äîëæíà áûòü ïîãëàæåíà è ÷èñòà.')
            wait(3500)
            sampSendChat('Âî-âòîðûõ, Âû íå äîëæíû âûãëÿäåòü êàê íà ìàñêàðàäå.')
            wait(3500)
            sampSendChat('Íèêàêèõ ìàåê, êîðîòêèõ þáîê è ò.ä')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Óâàæàåìûå ñîòðóäíèêè Öåíòðàëüíîãî áàíêà, ïðîøó ìèíóòî÷êó âíèìàíèå!')
            wait(3500)
            sampSendChat('Õî÷ó âàì ñêàçàòü, ÷òî òðàíñïîðò ñ äîëæíîñòè "Îõðàííèê" - Çàïðåùåíî áðàòü!')
            wait(3500)
            sampSendChat('Ñ äîëæíîñòè "Ñò.Îõðàííèê" òîæå çàïðåùåíî, áóäüòå âíèìàòåëüíû.')
            wait(3500)
            sampSendChat('Åñëè óâèäåëè íàðóøèòåëÿ êîòîðûé êàòàåòcÿ íà òðàíñïîðòå, íàðóøàÿ óñòàâ.')
            wait(3500)
            sampSendChat('Ïîäàâàéòå â æàëîáíóþ êíèãó íà ñîòðóäíèêà êîòîðûé íàðóøèë óñòàâ.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âàñ íà ëåêöèè î ñóáîðäèíàöèè.')
            wait(3500)
            sampSendChat('Äëÿ íà÷àëà ðàññêàæó, ÷òî òàêîå ñóáîðäèíàöèÿ.')
            wait(3500)
            sampSendChat('Ñóáîðäèíàöèÿ - ïðàâèëà ïîä÷èíåíèÿ ìëàäøèõ ïî çâàíèþ ê ñòàðøèì ïî çâàíèþ óâàæåíèå, îòíîøåíèå ê íèì.')
            wait(3500)
            sampSendChat('Òî åñòü ìëàäøèå ñîòðóäíèêè äîëæíû âûïîëíÿòü ïðèêàçû íà÷àëüñòâà.')
            wait(3500)
            sampSendChat('Êòî îñëóøàåòñÿ - ñïåðâà ïîëó÷èò óñòíîå ïðåäóïðåæäåíèå, ïîñëåäóþùèé ðàç - âûãîâîð.')
            wait(3500)
            sampSendChat('Âû äîëæíû ñ óâàæåíèåì îòíîñèòñÿ ê íà÷àëüñòâó è ñòàðøèì ïî äîëæíîñòè íà "Âû".')
            wait(3500)
            sampSendChat('Íå íàðóøàéòå ïðàâèëà è íå íàðóøàéòå ñóáîðäèíàöèþ äàáû íå ïîëó÷èòü íàêàçàíèå.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Ïîãîâîðèì òàê æå è î Ýòèêåòå...')
            wait(3500)
            sampSendChat('Ïðè íà÷àëå äèàëîãà âû äîëæíû ïî ïðèâåòñòâîâàòü ñîáåñåäíèêà...')
            wait(3500)
            sampSendChat('...à â êîíöå äèàëîãà ïîïðîùàòüñÿ')
            wait(3500)
            sampSendChat('Ñîáëþäàòü óâàæåíèå ïðè îáùåíèè')
            wait(3500)
            sampSendChat('Çàïðåùåíî, âìåøèâàòüñÿ â ÷óæîé ðàçãîâîð')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ñåé÷àñ ÿ ïðî÷èòàþ ëåêöèþ î âðåäå íàðêîòèêîâ.')
            wait(3500)
            sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
            wait(3500)
            sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
            wait(3500)
            sampSendChat('Çà÷àñòóþ íàðêîçàâèñèìûå ïñèõîëîãè÷åñêè íåñòàáèëüíû.')
            wait(3500)
            sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè âûøå ðèñê çàðàæåíèÿ çàáîëåâàíèÿìè.')
            wait(3500)
            sampSendChat('Íà ñåãîäíÿøíèé äåíü íàèáîëåå ðàñïðîñòðàíåíû ñëåäóþùèå âèäû íàðêîòèêîâ...')
            wait(3500)
            sampSendChat('...ìàðèõóàíà, êîêàèí, àìôåòàìèíû, ýêñòàçè, îïèóì.')
            wait(3500)
            sampSendChat('Êàæäûé ìîæåò è äîëæåí ïðîòèâîñòîÿòü íàðêîìàíèè.')
            wait(3500)
            sampSendChat('Îáðåòèòå óâåðåííîñòü â òîì, ÷òî âàì ëè÷íî íàðêîòèêè íå íóæíû.')
            wait(3500)
            sampSendChat('Ëåêöèÿ çàêîí÷åíà. Ñïàñèáî çà âíèìàíèå.')
        end)
end

function RegisterHotkeysForArmy()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function ()
            sampSendChat('Çäðàâèÿ Æåëàþ. ß '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'.')
            sampSendChat('/do Íà ïëå÷àõ ïîãîíû '.. u8:decode(mainini.config.Rang) ..'.')
            sampSendChat('/do Óäîñòîâåðåíèå â êàðìàíå.')
            sampSendChat('/me âçÿë óäîñòîâåðåíèå ñ êàðìàíà, çàòåì ïîêàçàë ãðàæäàíèíó íàïðîòèâ.')
            sampSendChat('/do Ïîêàçàë óäîñòîâåðåíèå.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/showpass ")
            sampSendChat('Ðàçðåøèòå óçíàòü, ñ êàêîé öåëüþ âû ïðèåõàëè íà îõðîíÿåìóþ òåððèòîðèþ.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function ()
            sampSendChat('/me ïðîòÿíóë ëåâóþ ðóêó è âçÿë äîêóìåíòû')
            sampSendChat('/do Äîêóìåíòû â ëåâîé ðóêå.')
            sampSendChat('/me îòêðûë äîêóìåíòû è íà÷àë èçó÷àòü')
            sampSendChat('/me èçó÷èë äîêóìåíòû, çàòåì çàêðûë åãî')
            sampSendChat('/me ïåðåäàë äîêóìåíòû ãðàæäàíèíó íàïðîòèâ')
            sampSendChat('/do Äîêóìåíòû ïåðåäàíû.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function ()
            sampSendChat('/s Îò ÊÏÏ íà 10 Ìåòðîâ èíà÷å ÿ ñî÷òó ýòî êàê íåïîä÷åíåíèå è ìû îòêðîåì îãîíü.') 
            sampSendChat('/s Ó âàñ 5 Ñåêóíä.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function ()
            sampSendChat('/me äîñòàë îðóæèå èç-çà ñïèíû')
            sampSendChat('/do Îðóæèå â ðóêàõ.')
            sampSendChat('/me ïåðåäåðíóë çàòâîð')
            sampSendChat('/do Îðóæèå â áîåâîé ãîòîâíîñòè.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function ()
            sampSendChat('/me ïîñòàâèë îðóæèå íà ïðåäîõðàíèòåëü')
            sampSendChat('/do Îðóæèå íà ïðåäîõðàíèòåëå.')
            sampSendChat('/me óáðàë îðóæèå çà ñïèíó')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function ()
            sampSendChat('Ðÿäîâîé '.. u8:decode(mainini.config.NickNameText) ..' ê ðàçáîðêå ÀÊ-47 ïðèñòóïèë!')
            sampSendChat('/me Îòäåëèë ìàãàçèí,çàòåì ñíÿë ñ ïðåäîõðàíèòåëÿ è ïåðåçàðÿäèë')
            sampSendChat('/me Ïîñòàâèë àâòîìàò íà ïèñòîëåòíóþ ðóêîÿòêó è íàæàë íà êóðîê')
            sampSendChat('/me Âûòàùèë øîìïîë è âûêðóòèë ïëàìåãàñèòåëü,çàòåì îïóñòèë àâòîìàò')
            sampSendChat('/me Ñíÿë êðûøêó ñòâîëüíîé êîðîáêè è âûòàùèë âîçâðàòíûé ìåõàíèçì')
            sampSendChat('/me Âûòàùèë çàòâîð ñ çàòâîðíîé ðàìîé è îòäåëèë èõ îò äðóã äðóãà')
            sampSendChat('/me Âûòàùèë ãàçîâóþ êàìåðó')
            sampSendChat('Ðÿäîâîé '.. u8:decode(mainini.config.NickNameText) ..' ðàçáîðêó çàêîí÷èë!.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function ()
            sampSendChat('Ðÿäîâîé '.. u8:decode(mainini.config.NickNameText) ..' ñáîðêó ÀÊ-47 ïðèñòóïèë.')
            sampSendChat('/me Ïðèñîåäèíèë çàòâîð ê çàòâîðíîé ðàìå,çàòåì âñòàâèë âñ¸ â àâòîìàò')
            sampSendChat('/me Ïðèñîåäèíèë âîçâðàòíûé ìåõàíèçì')
            sampSendChat('/me Çàêðûë ñòâîëüíóþ êîðîáêó êðûøêîé ñòâîëüíîé êîðîáêè')
            sampSendChat('/me Ïîñòàâèë àâòîìàò íà ïèñòîëåòíóþ ðóêîÿòêó è âñòàâèë øîìïîë')
            sampSendChat('/me Çàêðóòèë ïëàìåãàñèòåëü')
            sampSendChat('/me Íàæàë íà ñïóñêîâîé êðó÷îê')
            sampSendChat('/me Ïîñòàâèë àâòîìàò íà ïðåäîõðàíèòåëü.')
            sampSendChat('Ðÿäîâîé '.. u8:decode(mainini.config.NickNameText) ..' ñáîðêó ÀÊ-47 çàêîí÷èë!.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function ()
            sampSendChat('/me âçÿë â ðóêè êíèãó ñ ïðèñÿãîé.')
            sampSendChat('/me îòêðûë êíèãó.')
            sampSendChat('ß, Ðÿäîâîé '.. u8:decode(mainini.config.NickNameText) ..', òîðæåñòâåííî ïðèñÿãàþ íà âåðíîñòü ñâîåé Ðîäèíå.')
            sampSendChat('Êëÿíóñü ñâÿòî ñîáëþäàòü Êîíñòèòóöèþ Ðîññèéñêîé Ôåäåðàöèè')
            sampSendChat('Êëÿíóñü ñòðîãî âûïîëíÿòü òðåáîâàíèÿ âîèíñêèõ óñòàâîâ.')
            sampSendChat('Êëÿíóñü ñòðîãî âûïîëíÿòü ïðèêàçû êîìàíäèðîâ è íà÷àëüíèêîâ')
            sampSendChat('Êëÿíóñü äîñòîéíî èñïîëíÿòü âîèíñêèé äîëã.')
            sampSendChat('Êëÿíóñü ìóæåñòâåííî çàùèùàòü ñâîáîäó è íåçàâèñèìîñòü.')
            sampSendChat('Ðÿäîâîé '.. u8:decode(mainini.config.NickNameText) ..' ïðèñÿãó îêîí÷èë.')
            sampSendChat('/me çàêðûë êíèãó')
        end)
    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) ..'*íà ãðóäè âåñèò áåéäæèê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Õîðîøî.Äàâàéòå ñâîè äîêóìåíòû. À èìåííî ïàñïîðò,ëèöåíçèè è ìåä.êàðòà.')
            wait(3500)
            sampSendChat('/b Âñ¸ ïî ðï')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîâåðèâ äîêóìåíòû, ïåðåäàë ÷åëîâåêó íàïðîòèâ')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âçÿë ëèöåíçèè â ðóêè ')
            wait(3500)
            sampSendChat('/do Ëèöåíçèè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ ïàêåò ëèöåíçèé, îòäàë âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ìåä.êíèæêó â ðóêè ')
            wait(3500)
            sampSendChat('/do Ìåä.êíèæêà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ Ìåä.êíèãó, îòäàëà âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Äîêóìåíòû â ïîëíîì ïîðÿäêå ')
            wait(3500)
            sampSendChat('Âû ïðèíÿòû íà ñòàæèðîâêó.')
            wait(3500)
            sampSendChat('/do Ïîä ñòîëîì ëåæèò ïàêåò ñ ôîðìîé è ðàöèåé.')
            wait(3500)
            sampSendChat('/me äîñòàë ïàêåò è ïåðåäàëà ÷åëîâåêó íàïðîòèâ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âñåõ, ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Äðåññ-Êîä".')
            wait(3500)
            sampSendChat('Âî-ïåðâûõ, ôîðìà ñîòðóäíèêà äîëæíà áûòü ïîãëàæåíà è ÷èñòà.')
            wait(3500)
            sampSendChat('Âî-âòîðûõ, Âû íå äîëæíû âûãëÿäåòü êàê íà ìàñêàðàäå.')
            wait(3500)
            sampSendChat('Íèêàêèõ ìàåê, êîðîòêèõ þáîê è ò.ä')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Óâàæàåìûå ñîòðóäíèêè Öåíòðàëüíîãî áàíêà, ïðîøó ìèíóòî÷êó âíèìàíèå!')
            wait(3500)
            sampSendChat('Õî÷ó âàì ñêàçàòü, ÷òî òðàíñïîðò ñ äîëæíîñòè "Îõðàííèê" - Çàïðåùåíî áðàòü!')
            wait(3500)
            sampSendChat('Ñ äîëæíîñòè "Ñò.Îõðàííèê" òîæå çàïðåùåíî, áóäüòå âíèìàòåëüíû.')
            wait(3500)
            sampSendChat('Åñëè óâèäåëè íàðóøèòåëÿ êîòîðûé êàòàåòcÿ íà òðàíñïîðòå, íàðóøàÿ óñòàâ.')
            wait(3500)
            sampSendChat('Ïîäàâàéòå â æàëîáíóþ êíèãó íà ñîòðóäíèêà êîòîðûé íàðóøèë óñòàâ.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âàñ íà ëåêöèè î ñóáîðäèíàöèè.')
            wait(3500)
            sampSendChat('Äëÿ íà÷àëà ðàññêàæó, ÷òî òàêîå ñóáîðäèíàöèÿ.')
            wait(3500)
            sampSendChat('Ñóáîðäèíàöèÿ - ïðàâèëà ïîä÷èíåíèÿ ìëàäøèõ ïî çâàíèþ ê ñòàðøèì ïî çâàíèþ óâàæåíèå, îòíîøåíèå ê íèì.')
            wait(3500)
            sampSendChat('Òî åñòü ìëàäøèå ñîòðóäíèêè äîëæíû âûïîëíÿòü ïðèêàçû íà÷àëüñòâà.')
            wait(3500)
            sampSendChat('Êòî îñëóøàåòñÿ - ñïåðâà ïîëó÷èò óñòíîå ïðåäóïðåæäåíèå, ïîñëåäóþùèé ðàç - âûãîâîð.')
            wait(3500)
            sampSendChat('Âû äîëæíû ñ óâàæåíèåì îòíîñèòñÿ ê íà÷àëüñòâó è ñòàðøèì ïî äîëæíîñòè íà "Âû".')
            wait(3500)
            sampSendChat('Íå íàðóøàéòå ïðàâèëà è íå íàðóøàéòå ñóáîðäèíàöèþ äàáû íå ïîëó÷èòü íàêàçàíèå.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Ïîãîâîðèì òàê æå è î Ýòèêåòå...')
            wait(3500)
            sampSendChat('Ïðè íà÷àëå äèàëîãà âû äîëæíû ïî ïðèâåòñòâîâàòü ñîáåñåäíèêà...')
            wait(3500)
            sampSendChat('...à â êîíöå äèàëîãà ïîïðîùàòüñÿ')
            wait(3500)
            sampSendChat('Ñîáëþäàòü óâàæåíèå ïðè îáùåíèè')
            wait(3500)
            sampSendChat('Çàïðåùåíî, âìåøèâàòüñÿ â ÷óæîé ðàçãîâîð')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ñåé÷àñ ÿ ïðî÷èòàþ ëåêöèþ î âðåäå íàðêîòèêîâ.')
            wait(3500)
            sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
            wait(3500)
            sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
            wait(3500)
            sampSendChat('Çà÷àñòóþ íàðêîçàâèñèìûå ïñèõîëîãè÷åñêè íåñòàáèëüíû.')
            wait(3500)
            sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè âûøå ðèñê çàðàæåíèÿ çàáîëåâàíèÿìè.')
            wait(3500)
            sampSendChat('Íà ñåãîäíÿøíèé äåíü íàèáîëåå ðàñïðîñòðàíåíû ñëåäóþùèå âèäû íàðêîòèêîâ...')
            wait(3500)
            sampSendChat('...ìàðèõóàíà, êîêàèí, àìôåòàìèíû, ýêñòàçè, îïèóì.')
            wait(3500)
            sampSendChat('Êàæäûé ìîæåò è äîëæåí ïðîòèâîñòîÿòü íàðêîìàíèè.')
            wait(3500)
            sampSendChat('Îáðåòèòå óâåðåííîñòü â òîì, ÷òî âàì ëè÷íî íàðêîòèêè íå íóæíû.')
            wait(3500)
            sampSendChat('Ëåêöèÿ çàêîí÷åíà. Ñïàñèáî çà âíèìàíèå.')
        end)
end

function RegisterHotkeysForGKB()
    rkeys.registerHotKey({ VK_F1 }, 1, true,
        function()
            sampSendChat('/do Â ïðàâîé ðóêå íàõîäèòñÿ ïàïêà ñ íàäïèñüþ "Êëÿòâà Ãèïïîêðàòà"..')
            wait(3500)
            sampSendChat('/me ïîëîæèâ ïðàâóþ ðóêó íà ñåðäöå, âñòàë íà êîëåíè è ðàñêðûë ïàïêó')
            wait(3500)
            sampSendChat('Êëÿíóñü Àïîëëîíîì âðà÷îì, Àñêëåïèåì, Ãèãèååé è Ïàíàêååé è âñåìè áîãàìè è áîãèíÿìè...')
            wait(3500)
            sampSendChat('áåðÿ èõ â ñâèäåòåëè, èñïîëíÿòü ÷åñòíî, ñîîòâåòñòâåííî ìîèì ñèëàì è ìîåìó ðàçóìåíèþ.')
            wait(3500)
            sampSendChat('ß íàïðàâëþ ðåæèì áîëüíûõ ê èõ âûãîäå ñîîáðàçíî ñ ìîèìè ñèëàìè è ìîèì ðàçóìåíèåì, âîçäåðæèâàÿñü...')
            wait(3500)
            sampSendChat('îò ïðè÷èíåíèÿ âñÿêîãî âðåäà è íåñïðàâåäëèâîñòè.')
            wait(3500)
            sampSendChat('ß íå äàì íèêîìó ïðîñèìîãî ó ìåíÿ ñìåðòåëüíîãî ñðåäñòâà è íå ïîêàæó ïóòè äëÿ ïîäîáíîãî çàìûñëà.')
            wait(3500)
            sampSendChat('ß íè â êîåì ñëó÷àå íå áóäó äåëàòü ñå÷åíèÿ ó ñòðàäàþùèõ êàìåííîé áîëåçíüþ.')
            wait(3500)
            sampSendChat('ïðåäîñòàâèâ ýòî ëþäÿì, çàíèìàþùèìñÿ ýòèì äåëîì. Â êàêîé áû äîì ÿ íè âîøåë, ÿ âîéäó òóäà äëÿ ïîëüçû áîëüíîãî.')
            wait(3500)
            sampSendChat('/me îïóñòèâ ðóêó, âñòàë íà íîãè è çàêðûë ïàïêó')
            wait(3500)
            sampSendChat('/do Ïàïêà ñ íàäïèñüþ "Êëÿòâà Ãèïïîêðàòà" íàõîäèòñÿ â ïðàâîé ðóêå')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Çäðàâñòâóéòå, ÿ '.. u8:decode(mainini.config.Rang) ..' - '.. u8:decode(mainini.config.NickNameText))
            wait(3500)
            sampSendChat('/do Íà ãðóäè âèñèò áýéäæåê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Ìîãó ëè ÿ Âàì ÷åì-òî ïîìî÷ü?')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do Ìåä. ñóìêà íà ïëå÷å.')
            wait(3500)
            sampSendChat('/me ñíÿë ìåä.ñóìêó')
            wait(3500)
            sampSendChat('/me îòêðûë ìåä.ñóìêó')
            wait(3500)
            sampSendChat('/me äîñòàë íóæíûé ïðåïàðàò')
            wait(3500)
            sampSendChat('/do Ïðåïàðàò â ðóêå.')
            wait(3500)
            sampSendChat('/me ïåðåäàë ÷åëîâåêó íàïðîòèâ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/heal ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ìåä. êàðòà îáîéä¸òñÿ Âàì â 2500 ðóáëåé.')
            wait(3500)
            sampSendChat('/b /pay ID 2500')
            wait(3500)
            sampSendChat('Ïîñëå îïëàòû, Âàì áóäåò âûäàíà ìåä. êàðòà.')
            wait(3500)
            sampSendChat('/me äîñòàë ïà÷êó ÷èñòûõ ìåä. êàðò è íà÷àë çàïîëíÿòü íîâóþ ìåä. êàðòó')
            wait(3500)
            sampSendChat('/do Ìåä. êàðòà ãîòîâà. Ñòàòóñ: ïîëíîñòüþ çäîðîâ.')
            wait(3500)
            sampSendChat('/me ïåðåäàë ãîòîâóþ ìåä. êàðòó ÷åëîâåêó')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/medcard ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Ðåöåïò áóäåò ñòîèòü 1500 ðóáëåé.')
            wait(3500)
            sampSendChat('/b /pay ID 1500')
            wait(3500)
            sampSendChat('Ïîñëå îïëàòû, Âàì áóäåò âûäàí ðåöåïò')
            wait(3500)
            sampSendChat('/me äîñòàë ïà÷êó ÷èñòûõ ðåöåïòîâ è ïåðåäàë ÷åëîâåêó')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/recept ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('Çäðàâñòâóéòå, âû ïðèøëè íà ñåàíñ ïî âûâåäåíèþ òàòó?')
            wait(3500)
            sampSendChat('Õîðîøî, ýòî áóäåò ñòîèòü âàì 6000ðóá.')
            wait(3500)
            sampSendChat('Òàê æå ïðîøó âàñ ïåðåäàòü ìíå âàø ïàñïîðò')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/me áåð¸ò ïàñïîðò ó ÷åëîâåêà íàïðîòèâ')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ÷èòàåò äàííûå ñ ïàñïîðòà.')
            wait(3500)
            sampSendChat('/todo Âñå õîðîøî*Ïåðåäàâàÿ åãî îáðàòíî.')
            wait(3500)
            sampSendChat('Òåïåðü ñíèìàéòå ñ ñåáÿ ðóáàøêó, ÷òîá ÿ âûâåë âàøè òàòó.')
            sampSendChat('/n /showtatu')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/do Àïïàðàò äëÿ âûøèâêè òàòó íà ñòîëå.')
            wait(3500)
            sampSendChat('/me âçÿë àïïàðàò äëÿ èçâëå÷åíèÿ òàòó.')
            wait(3500)
            sampSendChat('/do Àïïàðàò â ïðàâîé ðóêå.')
            wait(3500)
            sampSendChat('/me íà÷àë âûâîäèòü òàòó.')
            wait(3500)
            sampSendChat('Âñå, âàø ñåàíñ îêîí÷åí. Âñåãî Âàì äîáðîãî.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/unstuff èä 6000")
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('Ñòîèìîñòü îäíîé àïòå÷êè ñîñòàâëÿåò 650 ðóáëåé.')
            wait(3500)
            sampSendChat('/b Êîìàíäà äëÿ ïîêóïêè:')
            wait(3500)
            sampSendChat('/b /pay Ìîé ID 650.')
            wait(3500)
            sampSendChat('/me îòêðûëà ñóìêó ñ àïòå÷êàìè.')
            wait(3500)
            sampSendChat('/me äîñòàëà è ñóìêè íåîáõîäèìîå êîë-âî àïòå÷åê.')
            wait(3500)
            sampSendChat('/me ïåðåñ÷èòàâ åù¸ ðàç, ïåðåäàëà àïòå÷êè ÷åëîâåêó.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/sellmed ")
        end)
    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) ..'*íà ãðóäè âåñèò áåéäæèê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Õîðîøî.Äàâàéòå ñâîè äîêóìåíòû. À èìåííî ïàñïîðò,ëèöåíçèè è ìåä.êàðòà.')
            wait(3500)
            sampSendChat('/b Âñ¸ ïî ðï')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîâåðèâ äîêóìåíòû, ïåðåäàë ÷åëîâåêó íàïðîòèâ')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âçÿë ëèöåíçèè â ðóêè ')
            wait(3500)
            sampSendChat('/do Ëèöåíçèè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ ïàêåò ëèöåíçèé, îòäàë âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ìåä.êíèæêó â ðóêè ')
            wait(3500)
            sampSendChat('/do Ìåä.êíèæêà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ Ìåä.êíèãó, îòäàëà âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Äîêóìåíòû â ïîëíîì ïîðÿäêå ')
            wait(3500)
            sampSendChat('Âû ïðèíÿòû íà ñòàæèðîâêó.')
            wait(3500)
            sampSendChat('/do Ïîä ñòîëîì ëåæèò ïàêåò ñ ôîðìîé è ðàöèåé.')
            wait(3500)
            sampSendChat('/me äîñòàë ïàêåò è ïåðåäàëà ÷åëîâåêó íàïðîòèâ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âñåõ, ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Äðåññ-Êîä".')
            wait(3500)
            sampSendChat('Âî-ïåðâûõ, ôîðìà ñîòðóäíèêà äîëæíà áûòü ïîãëàæåíà è ÷èñòà.')
            wait(3500)
            sampSendChat('Âî-âòîðûõ, Âû íå äîëæíû âûãëÿäåòü êàê íà ìàñêàðàäå.')
            wait(3500)
            sampSendChat('Íèêàêèõ ìàåê, êîðîòêèõ þáîê è ò.ä')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Óâàæàåìûå ñîòðóäíèêè Öåíòðàëüíîãî áàíêà, ïðîøó ìèíóòî÷êó âíèìàíèå!')
            wait(3500)
            sampSendChat('Õî÷ó âàì ñêàçàòü, ÷òî òðàíñïîðò ñ äîëæíîñòè "Îõðàííèê" - Çàïðåùåíî áðàòü!')
            wait(3500)
            sampSendChat('Ñ äîëæíîñòè "Ñò.Îõðàííèê" òîæå çàïðåùåíî, áóäüòå âíèìàòåëüíû.')
            wait(3500)
            sampSendChat('Åñëè óâèäåëè íàðóøèòåëÿ êîòîðûé êàòàåòcÿ íà òðàíñïîðòå, íàðóøàÿ óñòàâ.')
            wait(3500)
            sampSendChat('Ïîäàâàéòå â æàëîáíóþ êíèãó íà ñîòðóäíèêà êîòîðûé íàðóøèë óñòàâ.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âàñ íà ëåêöèè î ñóáîðäèíàöèè.')
            wait(3500)
            sampSendChat('Äëÿ íà÷àëà ðàññêàæó, ÷òî òàêîå ñóáîðäèíàöèÿ.')
            wait(3500)
            sampSendChat('Ñóáîðäèíàöèÿ - ïðàâèëà ïîä÷èíåíèÿ ìëàäøèõ ïî çâàíèþ ê ñòàðøèì ïî çâàíèþ óâàæåíèå, îòíîøåíèå ê íèì.')
            wait(3500)
            sampSendChat('Òî åñòü ìëàäøèå ñîòðóäíèêè äîëæíû âûïîëíÿòü ïðèêàçû íà÷àëüñòâà.')
            wait(3500)
            sampSendChat('Êòî îñëóøàåòñÿ - ñïåðâà ïîëó÷èò óñòíîå ïðåäóïðåæäåíèå, ïîñëåäóþùèé ðàç - âûãîâîð.')
            wait(3500)
            sampSendChat('Âû äîëæíû ñ óâàæåíèåì îòíîñèòñÿ ê íà÷àëüñòâó è ñòàðøèì ïî äîëæíîñòè íà "Âû".')
            wait(3500)
            sampSendChat('Íå íàðóøàéòå ïðàâèëà è íå íàðóøàéòå ñóáîðäèíàöèþ äàáû íå ïîëó÷èòü íàêàçàíèå.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Ïîãîâîðèì òàê æå è î Ýòèêåòå...')
            wait(3500)
            sampSendChat('Ïðè íà÷àëå äèàëîãà âû äîëæíû ïî ïðèâåòñòâîâàòü ñîáåñåäíèêà...')
            wait(3500)
            sampSendChat('...à â êîíöå äèàëîãà ïîïðîùàòüñÿ')
            wait(3500)
            sampSendChat('Ñîáëþäàòü óâàæåíèå ïðè îáùåíèè')
            wait(3500)
            sampSendChat('Çàïðåùåíî, âìåøèâàòüñÿ â ÷óæîé ðàçãîâîð')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ñåé÷àñ ÿ ïðî÷èòàþ ëåêöèþ î âðåäå íàðêîòèêîâ.')
            wait(3500)
            sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
            wait(3500)
            sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
            wait(3500)
            sampSendChat('Çà÷àñòóþ íàðêîçàâèñèìûå ïñèõîëîãè÷åñêè íåñòàáèëüíû.')
            wait(3500)
            sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè âûøå ðèñê çàðàæåíèÿ çàáîëåâàíèÿìè.')
            wait(3500)
            sampSendChat('Íà ñåãîäíÿøíèé äåíü íàèáîëåå ðàñïðîñòðàíåíû ñëåäóþùèå âèäû íàðêîòèêîâ...')
            wait(3500)
            sampSendChat('...ìàðèõóàíà, êîêàèí, àìôåòàìèíû, ýêñòàçè, îïèóì.')
            wait(3500)
            sampSendChat('Êàæäûé ìîæåò è äîëæåí ïðîòèâîñòîÿòü íàðêîìàíèè.')
            wait(3500)
            sampSendChat('Îáðåòèòå óâåðåííîñòü â òîì, ÷òî âàì ëè÷íî íàðêîòèêè íå íóæíû.')
            wait(3500)
            sampSendChat('Ëåêöèÿ çàêîí÷åíà. Ñïàñèáî çà âíèìàíèå.')
        end)
end

function RegisterHotkeysForFSIN()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/do Äóáèíêà íà ïîÿñå')
            wait(3500)
            sampSendChat('/me ñíÿë äóáèíêó ñ ïîÿñà.')
            wait(3500)
            sampSendChat('/do Äóáèíêà â ðóêàõ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/do Äóáèíêà â ðóêå')
            wait(3500)
            sampSendChat('/me âåøàåò äóáèíêó íà ïîÿñ.')
            wait(3500)
            sampSendChat('/do Äóáèíêà íà ïîÿñå')
        end)


    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ñíÿë àâòîìàò ñ ïëå÷à.')
            wait(3500)
            sampSendChat('/do Àâòîìàò â ðóêå.')
            wait(3500)
            sampSendChat('/me ñíÿë àâòîìàò ñ ïðåäîõðàíèòåëÿ.')
            wait(3500)
            sampSendChat('/me ïåðåäåðíóë çàòâîð.')
            wait(3500)
            sampSendChat('/do Ðóêà íà ñïóñêîâîì êðþ÷êå.')
            wait(3500)
            sampSendChat('/me ãîòîâ ñòðåëÿòü.')
        end)


    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do Àâòîìàò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïîñòàâèë àâòîìàò íà ïðåäîõðàíèòåëü.')
            wait(3500)
            sampSendChat('/me óáðàë àâòîìàò çà ïëå÷î.')
            wait(3500)
            sampSendChat('/do Àâòîìàò íà ïëå÷å.')
        end)


    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me äîñòàåò ïèñòîëåò ìàêàðîâà èç êîáóðû')
            wait(3500)
            sampSendChat('/do Ïèñòîëåò ìàêàðîâà â ðóêå')
            wait(3500)
            sampSendChat('/me ñíÿë ïèñòîëåò ìàêàðîâà ñ ïðåäîõðàíèòåëÿ')
            wait(3500)
            sampSendChat('/me ïåðåäåðíóë çàòâîð')
            wait(3500)
            sampSendChat('/do Ðóêà íà ñïóñêîâîì êðþ÷êå')
            wait(3500)
            sampSendChat('/me ãîòîâ ñòðåëÿòü') 
        end)


    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/do Ïèñòîëåò ìàêàðîâà â ðóêàõ')
            wait(3500)
            sampSendChat('/me ïîñòàâèë ïèñòîëåò ìàêàðîâà íà ïðåäîõðàíèòåëü')
            wait(3500)
            sampSendChat('/me óáðàë ïèñòîëåò â êîáóðó')
            wait(3500)
            sampSendChat('/do Ïèñòîëåò â êîáóðå')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/do Íàðó÷íèêè âèñÿò íà ïîÿñå.')
            wait(3500)
            sampSendChat('/me ðåçêèì äâèæåíèåì ñíÿë íàðó÷íèêè ñ ïîÿñà')
            wait(3500)
            sampSendChat('/do Íàðó÷íèêè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me íàäåâàåò íàðó÷íèêè íà çàäåðæàííîãî')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/cuff ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/do Êëþ÷ îò íàðó÷íèêîâ â ðóêàõ.')
            wait(3500)
            sampSendChat('/me äâèæåíèåì êëþ÷à ñíÿë íàðó÷íèêè')
            wait(3500)
            sampSendChat('/do Íàðó÷íèêè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me âåøàåò íàðó÷íèêè íà ïîÿñ')
            sampSetChatInputText("/uncuff ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me âçÿë çàêëþ÷¸ííîãî ïîä ðóêó è âåä¸ò çà ñîáîé')
            wait(3500)
            sampSendChat('/do Ñîòðóäíèê ÊÑÐ âåä¸ò çàêëþ÷¸ííîãî.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/gotome ")
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) ..'*íà ãðóäè âåñèò áåéäæèê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Õîðîøî.Äàâàéòå ñâîè äîêóìåíòû. À èìåííî ïàñïîðò,ëèöåíçèè è ìåä.êàðòà.')
            wait(3500)
            sampSendChat('/b Âñ¸ ïî ðï')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîâåðèâ äîêóìåíòû, ïåðåäàë ÷åëîâåêó íàïðîòèâ')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âçÿë ëèöåíçèè â ðóêè ')
            wait(3500)
            sampSendChat('/do Ëèöåíçèè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ ïàêåò ëèöåíçèé, îòäàë âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ìåä.êíèæêó â ðóêè ')
            wait(3500)
            sampSendChat('/do Ìåä.êíèæêà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ Ìåä.êíèãó, îòäàëà âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Äîêóìåíòû â ïîëíîì ïîðÿäêå ')
            wait(3500)
            sampSendChat('Âû ïðèíÿòû íà ñòàæèðîâêó.')
            wait(3500)
            sampSendChat('/do Ïîä ñòîëîì ëåæèò ïàêåò ñ ôîðìîé è ðàöèåé.')
            wait(3500)
            sampSendChat('/me äîñòàë ïàêåò è ïåðåäàëà ÷åëîâåêó íàïðîòèâ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âñåõ, ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Äðåññ-Êîä".')
            wait(3500)
            sampSendChat('Âî-ïåðâûõ, ôîðìà ñîòðóäíèêà äîëæíà áûòü ïîãëàæåíà è ÷èñòà.')
            wait(3500)
            sampSendChat('Âî-âòîðûõ, Âû íå äîëæíû âûãëÿäåòü êàê íà ìàñêàðàäå.')
            wait(3500)
            sampSendChat('Íèêàêèõ ìàåê, êîðîòêèõ þáîê è ò.ä')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Óâàæàåìûå ñîòðóäíèêè Öåíòðàëüíîãî áàíêà, ïðîøó ìèíóòî÷êó âíèìàíèå!')
            wait(3500)
            sampSendChat('Õî÷ó âàì ñêàçàòü, ÷òî òðàíñïîðò ñ äîëæíîñòè "Îõðàííèê" - Çàïðåùåíî áðàòü!')
            wait(3500)
            sampSendChat('Ñ äîëæíîñòè "Ñò.Îõðàííèê" òîæå çàïðåùåíî, áóäüòå âíèìàòåëüíû.')
            wait(3500)
            sampSendChat('Åñëè óâèäåëè íàðóøèòåëÿ êîòîðûé êàòàåòcÿ íà òðàíñïîðòå, íàðóøàÿ óñòàâ.')
            wait(3500)
            sampSendChat('Ïîäàâàéòå â æàëîáíóþ êíèãó íà ñîòðóäíèêà êîòîðûé íàðóøèë óñòàâ.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âàñ íà ëåêöèè î ñóáîðäèíàöèè.')
            wait(3500)
            sampSendChat('Äëÿ íà÷àëà ðàññêàæó, ÷òî òàêîå ñóáîðäèíàöèÿ.')
            wait(3500)
            sampSendChat('Ñóáîðäèíàöèÿ - ïðàâèëà ïîä÷èíåíèÿ ìëàäøèõ ïî çâàíèþ ê ñòàðøèì ïî çâàíèþ óâàæåíèå, îòíîøåíèå ê íèì.')
            wait(3500)
            sampSendChat('Òî åñòü ìëàäøèå ñîòðóäíèêè äîëæíû âûïîëíÿòü ïðèêàçû íà÷àëüñòâà.')
            wait(3500)
            sampSendChat('Êòî îñëóøàåòñÿ - ñïåðâà ïîëó÷èò óñòíîå ïðåäóïðåæäåíèå, ïîñëåäóþùèé ðàç - âûãîâîð.')
            wait(3500)
            sampSendChat('Âû äîëæíû ñ óâàæåíèåì îòíîñèòñÿ ê íà÷àëüñòâó è ñòàðøèì ïî äîëæíîñòè íà "Âû".')
            wait(3500)
            sampSendChat('Íå íàðóøàéòå ïðàâèëà è íå íàðóøàéòå ñóáîðäèíàöèþ äàáû íå ïîëó÷èòü íàêàçàíèå.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Ïîãîâîðèì òàê æå è î Ýòèêåòå...')
            wait(3500)
            sampSendChat('Ïðè íà÷àëå äèàëîãà âû äîëæíû ïî ïðèâåòñòâîâàòü ñîáåñåäíèêà...')
            wait(3500)
            sampSendChat('...à â êîíöå äèàëîãà ïîïðîùàòüñÿ')
            wait(3500)
            sampSendChat('Ñîáëþäàòü óâàæåíèå ïðè îáùåíèè')
            wait(3500)
            sampSendChat('Çàïðåùåíî, âìåøèâàòüñÿ â ÷óæîé ðàçãîâîð')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ñåé÷àñ ÿ ïðî÷èòàþ ëåêöèþ î âðåäå íàðêîòèêîâ.')
            wait(3500)
            sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
            wait(3500)
            sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
            wait(3500)
            sampSendChat('Çà÷àñòóþ íàðêîçàâèñèìûå ïñèõîëîãè÷åñêè íåñòàáèëüíû.')
            wait(3500)
            sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè âûøå ðèñê çàðàæåíèÿ çàáîëåâàíèÿìè.')
            wait(3500)
            sampSendChat('Íà ñåãîäíÿøíèé äåíü íàèáîëåå ðàñïðîñòðàíåíû ñëåäóþùèå âèäû íàðêîòèêîâ...')
            wait(3500)
            sampSendChat('...ìàðèõóàíà, êîêàèí, àìôåòàìèíû, ýêñòàçè, îïèóì.')
            wait(3500)
            sampSendChat('Êàæäûé ìîæåò è äîëæåí ïðîòèâîñòîÿòü íàðêîìàíèè.')
            wait(3500)
            sampSendChat('Îáðåòèòå óâåðåííîñòü â òîì, ÷òî âàì ëè÷íî íàðêîòèêè íå íóæíû.')
            wait(3500)
            sampSendChat('Ëåêöèÿ çàêîí÷åíà. Ñïàñèáî çà âíèìàíèå.')
        end)
end

function RegisterHotkeysForSP()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/me âêëþ÷èë ìåãàôîí')
            wait(3500)
            sampSendChat('/m Ãðàæäàíèí, îñòàíîâèòå âàøå òðàíñïîðòíîå ñðåäñòâî è ïðèæìèòåñü ê îáî÷èíå')
            wait(3500)
            sampSendChat('/m Çàãëóøèòå äâèãàòåëü, ðóêè íà ðóëü è áåç ðåçêèõ äâèæåíèé')
            wait(3500)
            sampSendChat('/m Â ñëó÷àå íåïîä÷èíåíèÿ ÿ îòêðîþ îãîíü ïî êîëåñàì...')
            wait(3500)
            sampSendChat('/m è âû áóäåòå çàíåñåíû â ôåäåðàëüíûé ðîçûñê îêðóãà')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Çäðàâñòâóéòå, ÿ '.. u8:decode(mainini.config.Rang) ..' ÌÂÄ - '.. u8:decode(mainini.config.NickNameText))
            wait(3500)
            sampSendChat('/do Óäîñòîâåðåíèå â ëåâîì âåðõíåì êàðìàíå.')
            wait(3500)
            sampSendChat('/me âçÿë óäîñòîâåðåíèå èç ëåâîãî âåðõíåãî êàðìàíà')
            wait(3500)
            sampSendChat('/do Íà óäîñòîâåðåíèè íàïèñàíî "ÌÂÄ ÐÔ"')
            wait(3500)
            sampSendChat('/me îòêðûë óäîñòîâåðåíèå íà ïåðâîé ñòðàíèöå')
            wait(3500)
            sampSendChat('/me ïîêàçûâàåò ÷åëîâåêó íàïðîòèâ â îòêðûòîì âèäå')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/showbadge ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/do Ïðîòîêîë è ðó÷êà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me îòêðûë ïðîòîêîë, ïîñëå íà÷àë çàïîëíÿòü ïðîòîêîë')
            wait(3500)
            sampSendChat('/do Ïðîòîêîë ñîñòàâëåí.')
            wait(3500)
            sampSendChat('/me âûðâàë ëèñòîê èç ïðîòîêîëà')
            wait(3500)
            sampSendChat('/do Íà ëèñòêå óêàçàíî: "Øòðàô"')
            wait(3500)
            sampSendChat('/me âûäàë øòðàô íàðóøèòåëþ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/ticket ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do Êàðìàííûé Ïåðåíîñíîé Êîìïüþòåð íàõîäèòñÿ â ïðàâîì êàðìàíå.')
            wait(3500)
            sampSendChat('/me äîñòàë èç êàðìàíà ÊÏÊ è çàøåë â áàçó äàííûõ ÌÂÄ')
            wait(3500)
            sampSendChat('/me çàí¸ñ ïîäîçðåâàåìîãî â áàçó äàííûõ è óáðàë ÊÏÊ â êàðìàí')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/su ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ïîâàëèë ÷åëîâåêà íà çåìëþ, ïîñëå ÷åãî ïðèæàë åãî ñïèíó êîëåíîì')
            wait(3500)
            sampSendChat('/do Íà ïîÿñå âåñÿò íàðó÷íèêè.')
            wait(3500)
            sampSendChat('/me ðåçêèì äâèæåíèåì ðóêè ñíÿë íàðó÷íèêè ñ ïîÿñà')
            wait(3500)
            sampSendChat('/do Íàðó÷íèêè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me çàëîìàë ðóêè ÷åëîâåêó')
            wait(3500)
            sampSendChat('/me íàäåâàåò íàðó÷íèêè ÷åëîâåêó íàïðîòèâ')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/me ïîäíÿë ÷åëîâåêà ñ çåìëè')
            wait(3500)
            sampSendChat('/me çàëîìàë ðóêó è ïîâ¸ë çàäåðæàííîãî ðÿäîì çà ñîáîé')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/me îòêðûë äâåðü àâòîìîáèëÿ')
            wait(3500)
            sampSendChat('/me ïðèãíóë ãîëîâó çàäåðæèâàåìó è ïîñàäèë â àâòîìîáèëü')
            wait(3500)
            sampSendChat('/do Çàäåðæàííûé â àâòîìîáèëå.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/incar ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/do Êëþ÷è îò êàìåðû çàêëþ÷åíèÿ íàõîäÿòñÿ íà ñïåöèàëüíîì ïîÿñå.')
            wait(3500)
            sampSendChat('/me ñíÿë ñî ñïåöèàëüíîãî ïîÿñà êëþ÷è îò êàìåðû çàêëþ÷åííûõ')
            wait(3500)
            sampSendChat('/me âñòàâèë êëþ÷ îò êàìåðû â çàìî÷íóþ ñêâàæèíó è îòêðûë êëåòêó')
            wait(3500)
            sampSendChat('/me ñõâàòèë çàäåðæàííîãî çà ðóêàâ îäåæäû è çàòîëêàë â êàìåðó')
            wait(3500)
            sampSendChat('/do Ïðîöåññ...')
            wait(3500)
            sampSendChat('/me çàõëîïíóë ðåøåòêó, çàêðûë åå íà çàìîê è âûòàùèë êëþ÷ èç çàìêà')
            wait(3500)
            sampSendChat('/me ïîâåñèë êîìïëåêò êëþ÷åé íà ñïåöèàëüíûé ïîÿñ')
            wait(3500)
            sampSendChat('/do Êëþ÷è îò êàìåðû çàêëþ÷åíèÿ íàõîäÿòñÿ íà ñïåöèàëüíîì ïîÿñå.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/arrest ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me äîñòàë èç êàðìàíà ÊÏÊ')
            wait(3500)
            sampSendChat('/me Çàø¸ë â áàçó äàííûõ ðîçûñêèâàåìûõ')
            wait(3500)
            sampSendChat('/me ñâåðèë âñå ëèöà ïðåñòóïíèêîâ ñ ÷åëîâåêîì ñòîÿùèì íàïðîòèâ')
            wait(3500)
            sampSendChat('/do Â áàçå äàííûõ ðîçûñêèâàåìûõ åñòü ñõîæåå ëèöî')
            wait(3500)
            sampSendChat('/me çàêðûë ÊÏÊ')
            wait(3500)
            sampSendChat('/me ïîëîæèë ÊÏÊ îáðàòíî â êàðìàí')
            wait(3500)
            sampSendChat('Ìû âûíóæäåíû âàñ çàäåðæàòü, äî âûÿñíåíèÿ âñåõ îáñòîÿòåëüñòâ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('Âû àðåñòîâàíû çà íàðóøåíèå çàêîíîâ îáëàñòè')
            wait(3500)
            sampSendChat('Âû èìååòå ïðàâî õðàíèòü ìîë÷àíèå - âñå ÷òî Âû ñêàæèòå - áóäåò èñïîëüçîâàíî ïðîòèâ Âàñ')
            wait(3500)
            sampSendChat('Âû èìååòå ïðàâî íà àäâîêàòà âî âðåìÿ ñóäåáíîãî çàñåäàíèÿ')
            wait(3500)
            sampSendChat('/todo Âàì ÿñíû Âàøè ïðàâà?*Ïðèñòàëüíî ñìîòðÿ íà çàäåðæàííîãî')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_F1 }, 1, true,
        function()
            sampSendChat('/do Äóáèíêà íà ïîÿñå.')
            wait(3500)
            sampSendChat('/me îòöåïèë äóáèíêó ñ ïîÿñà')
            wait(3500)
            sampSendChat('/do Äóáèíêà â ðóêå.')
            wait(3500)
            sampSendChat('/me íàíåñ íåñêîëüêî ïîêàçàòåëüíûõ óäàðîâ')
            wait(3500)
            sampSendChat('/do Óäàðû.')
            wait(3500)
            sampSendChat('/me ïîâåøàë äóáèíêó íà ïîÿñ')
            wait(3500)
            sampSendChat('/do Äóáèíêà íà ïîÿñå.')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) ..'*íà ãðóäè âåñèò áåéäæèê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Õîðîøî.Äàâàéòå ñâîè äîêóìåíòû. À èìåííî ïàñïîðò,ëèöåíçèè è ìåä.êàðòà.')
            wait(3500)
            sampSendChat('/b Âñ¸ ïî ðï')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîâåðèâ äîêóìåíòû, ïåðåäàë ÷åëîâåêó íàïðîòèâ')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âçÿë ëèöåíçèè â ðóêè ')
            wait(3500)
            sampSendChat('/do Ëèöåíçèè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ ïàêåò ëèöåíçèé, îòäàë âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ìåä.êíèæêó â ðóêè ')
            wait(3500)
            sampSendChat('/do Ìåä.êíèæêà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ Ìåä.êíèãó, îòäàëà âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Äîêóìåíòû â ïîëíîì ïîðÿäêå ')
            wait(3500)
            sampSendChat('Âû ïðèíÿòû íà ñòàæèðîâêó.')
            wait(3500)
            sampSendChat('/do Ïîä ñòîëîì ëåæèò ïàêåò ñ ôîðìîé è ðàöèåé.')
            wait(3500)
            sampSendChat('/me äîñòàë ïàêåò è ïåðåäàëà ÷åëîâåêó íàïðîòèâ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âñåõ, ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Äðåññ-Êîä".')
            wait(3500)
            sampSendChat('Âî-ïåðâûõ, ôîðìà ñîòðóäíèêà äîëæíà áûòü ïîãëàæåíà è ÷èñòà.')
            wait(3500)
            sampSendChat('Âî-âòîðûõ, Âû íå äîëæíû âûãëÿäåòü êàê íà ìàñêàðàäå.')
            wait(3500)
            sampSendChat('Íèêàêèõ ìàåê, êîðîòêèõ þáîê è ò.ä')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Óâàæàåìûå ñîòðóäíèêè Öåíòðàëüíîãî áàíêà, ïðîøó ìèíóòî÷êó âíèìàíèå!')
            wait(3500)
            sampSendChat('Õî÷ó âàì ñêàçàòü, ÷òî òðàíñïîðò ñ äîëæíîñòè "Îõðàííèê" - Çàïðåùåíî áðàòü!')
            wait(3500)
            sampSendChat('Ñ äîëæíîñòè "Ñò.Îõðàííèê" òîæå çàïðåùåíî, áóäüòå âíèìàòåëüíû.')
            wait(3500)
            sampSendChat('Åñëè óâèäåëè íàðóøèòåëÿ êîòîðûé êàòàåòcÿ íà òðàíñïîðòå, íàðóøàÿ óñòàâ.')
            wait(3500)
            sampSendChat('Ïîäàâàéòå â æàëîáíóþ êíèãó íà ñîòðóäíèêà êîòîðûé íàðóøèë óñòàâ.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âàñ íà ëåêöèè î ñóáîðäèíàöèè.')
            wait(3500)
            sampSendChat('Äëÿ íà÷àëà ðàññêàæó, ÷òî òàêîå ñóáîðäèíàöèÿ.')
            wait(3500)
            sampSendChat('Ñóáîðäèíàöèÿ - ïðàâèëà ïîä÷èíåíèÿ ìëàäøèõ ïî çâàíèþ ê ñòàðøèì ïî çâàíèþ óâàæåíèå, îòíîøåíèå ê íèì.')
            wait(3500)
            sampSendChat('Òî åñòü ìëàäøèå ñîòðóäíèêè äîëæíû âûïîëíÿòü ïðèêàçû íà÷àëüñòâà.')
            wait(3500)
            sampSendChat('Êòî îñëóøàåòñÿ - ñïåðâà ïîëó÷èò óñòíîå ïðåäóïðåæäåíèå, ïîñëåäóþùèé ðàç - âûãîâîð.')
            wait(3500)
            sampSendChat('Âû äîëæíû ñ óâàæåíèåì îòíîñèòñÿ ê íà÷àëüñòâó è ñòàðøèì ïî äîëæíîñòè íà "Âû".')
            wait(3500)
            sampSendChat('Íå íàðóøàéòå ïðàâèëà è íå íàðóøàéòå ñóáîðäèíàöèþ äàáû íå ïîëó÷èòü íàêàçàíèå.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Ïîãîâîðèì òàê æå è î Ýòèêåòå...')
            wait(3500)
            sampSendChat('Ïðè íà÷àëå äèàëîãà âû äîëæíû ïî ïðèâåòñòâîâàòü ñîáåñåäíèêà...')
            wait(3500)
            sampSendChat('...à â êîíöå äèàëîãà ïîïðîùàòüñÿ')
            wait(3500)
            sampSendChat('Ñîáëþäàòü óâàæåíèå ïðè îáùåíèè')
            wait(3500)
            sampSendChat('Çàïðåùåíî, âìåøèâàòüñÿ â ÷óæîé ðàçãîâîð')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ñåé÷àñ ÿ ïðî÷èòàþ ëåêöèþ î âðåäå íàðêîòèêîâ.')
            wait(3500)
            sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
            wait(3500)
            sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
            wait(3500)
            sampSendChat('Çà÷àñòóþ íàðêîçàâèñèìûå ïñèõîëîãè÷åñêè íåñòàáèëüíû.')
            wait(3500)
            sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè âûøå ðèñê çàðàæåíèÿ çàáîëåâàíèÿìè.')
            wait(3500)
            sampSendChat('Íà ñåãîäíÿøíèé äåíü íàèáîëåå ðàñïðîñòðàíåíû ñëåäóþùèå âèäû íàðêîòèêîâ...')
            wait(3500)
            sampSendChat('...ìàðèõóàíà, êîêàèí, àìôåòàìèíû, ýêñòàçè, îïèóì.')
            wait(3500)
            sampSendChat('Êàæäûé ìîæåò è äîëæåí ïðîòèâîñòîÿòü íàðêîìàíèè.')
            wait(3500)
            sampSendChat('Îáðåòèòå óâåðåííîñòü â òîì, ÷òî âàì ëè÷íî íàðêîòèêè íå íóæíû.')
            wait(3500)
            sampSendChat('Ëåêöèÿ çàêîí÷åíà. Ñïàñèáî çà âíèìàíèå.')
        end)
end

function RegisterHotkeysForRCR()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Çäðàâñòâóéòå, äîðîãèå ðàäèîñëóøàòåëè')
            wait(5000)
            sampSendChat('/news Ñ âàìè ÿ *Äîëæíîñòü* ðàäèîñòàíöèè ã. "Ãîðîä", Èìÿ Ôàìèëèÿ')
            wait(5000)
            sampSendChat('/news È ñåãîäíÿ ó íàñ ýôèð î Ïîãîäå')
            wait(5000)
            sampSendChat('/news Â ãîðîäå Ëûòêàðèíî ñåãîäíÿ Ñîëíå÷íî áåç îñàäêîâ ïëþñ 25')
            wait(5000)
            sampSendChat('/news Ãîâîðÿò ýòî îäíà èç îòëè÷íûé ïîãîä â ýòîì ãîäó')
            wait(5000)
            sampSendChat('/news Â ãîðîäå Àðçàìàñ ñåãîäíÿ ïëþñ 17 è Îáëà÷íî,îæèäàåòñÿ äîæäü âå÷åðîì')
            wait(5000)
            sampSendChat('/news Ñîâåòóåì íå âûõîäèòü èç äîìà â ïîçäíåå âðåìÿ')
            wait(5000)
            sampSendChat('/news Â ïãò.Áàòûðåâî Ñîëíå÷íî ïëþñ 25 äî ñàìîé íî÷è')
            wait(5000)
            sampSendChat('/news À íà ýòîì ïðîãíîç ïîãîäû îêîí÷åí')
            wait(4000)
            sampSendChat('/news Ñïàñèáî, ÷òî áûëè ñ íàìè')
            wait(4000)
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Ïðèâåòñòâóþ, äîðîãèå ðàäèîñëóøàòåëè, â ýôèðå Ðàäèîñòàíöèÿ '.. u8:decode(mainini.config.Nameorg) ..'.')
            wait(5000)
            sampSendChat('/news Ñåãîäíÿ ñ âàìè ÿ - '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news Ñåé÷àñ ÿ ïðîâåäó ýôèð íà òåìó Âàøè ïðèâåòû è ïîçäðàâëåíèÿ.')
            wait(5000)
            sampSendChat('/news Ñåé÷àñ ÿ îáúÿñíþ ïðàâèëà è ìû íà÷íåì.')
            wait(5000)
            sampSendChat('/news Ñóòü òàêîâà, Âû äîëæíû ïðèñûëàòü ñâîè ïðèâåòû è ïîçäðàâëåíèÿ.')
            wait(5000)
            sampSendChat('/news Íà íîìåð: '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news À ÿ èõ áóäó îçâó÷èâàòü â ïðÿìîì ýôèðå.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/news Íà ýòîì ìû çàêàí÷èâàåì íàø ýôèð.')
            wait(5000)
            sampSendChat('/news Ñ âàìè áûë ÿ - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Çäðàâñòâóéòå, äîðîãèå ðàäèîñëóøàòåëè')
            wait(5000)
            sampSendChat('/news Ñ âàìè ÿ - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news È ñåãîäíÿ ó íàñ ýôèð î Ïîãîäå')
            wait(5000)
            sampSendChat('/news Â ãîðîäå Ëûòêàðèíî ñåãîäíÿ Ñîëíå÷íî áåç îñàäêîâ ïëþñ 25')
            wait(5000)
            sampSendChat('/news Ãîâîðÿò ýòî îäíà èç îòëè÷íûé ïîãîä â ýòîì ãîäó')
            wait(5000)
            sampSendChat('/news Â ãîðîäå Àðçàìàñ ñåãîäíÿ ïëþñ 17 è Îáëà÷íî,îæèäàåòñÿ äîæäü âå÷åðîì')
            wait(5000)
            sampSendChat('/news Ñîâåòóåì íå âûõîäèòü èç äîìà â ïîçäíåå âðåìÿ')
            wait(5000)
            sampSendChat('/news Â ïãò.Áàòûðåâî Ñîëíå÷íî ïëþñ 25 äî ñàìîé íî÷è')
            wait(5000)
            sampSendChat('/news À íà ýòîì ïðîãíîç ïîãîäû îêîí÷åí')
            wait(4000)
            sampSendChat('/news Ñïàñèáî, ÷òî áûëè ñ íàìè')
            wait(4000)
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Ïðèâåòñòâóþ, äîðîãèå ðàäèîñëóøàòåëè, â ýôèðå Ðàäèîñòàíöèÿ '.. u8:decode(mainini.config.Nameorg) ..'.')
            wait(5000)
            sampSendChat('/news Ñ âàìè ÿ - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news Ñåé÷àñ ÿ ïðîâåäó ýôèð íà òåìó Âàøè ïðèâåòû è ïîçäðàâëåíèÿ.')
            wait(5000)
            sampSendChat('/news Ñåé÷àñ ÿ îáúÿñíþ ïðàâèëà è ìû íà÷íåì.')
            wait(5000)
            sampSendChat('/news Ñóòü òàêîâà, Âû äîëæíû ïðèñûëàòü ñâîè ïðèâåòû è ïîçäðàâëåíèÿ.')
            wait(5000)
            sampSendChat('/news Íà íîìåð: '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news À ÿ èõ áóäó îçâó÷èâàòü â ïðÿìîì ýôèðå.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('news Íà ýòîì ìû çàêàí÷èâàåì íàø ýôèð.')
            wait(5000)
            sampSendChat('/news Ñ âàìè áûë ÿ - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/news Ñ âàìè áûë ÿ - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news Çäðàâñòâóéòå, äîðîãèå ðàäèîñëóøàòåëè ')
            wait(5000)
            sampSendChat('/news Ñ âàìè ÿ - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news È ñåãîäíÿ ó íàñ âèêòîðèíà Ñòîëèöû ')
            wait(5000)
            sampSendChat('/news ß çàãàäûâàþ ñòîëèöû. Íàïðèìåð:Ïåêèí, à Âû äîëæíû ñêàçàòü êàêîé ñòðàíû ýòà ñòîëèöà...')
            wait(5000)
            sampSendChat('/news Ñòðàíà áóäåò Êèòàé.')
            wait(5000)
            sampSendChat('/news Êàæäàÿ óãàäàííàÿ ñòðàíà - 1 áàëë íà ñ÷åò îòâåòèâøåãî.')
            wait(5000)
            sampSendChat('/news À èãðàåì ìû äî 5-òè áàëëîâ.')
            wait(5000)
            sampSendChat('/news Íî äëÿ íà÷àëà íàì íóæíû ñïîíñîðû.')
            wait(5000)
            sampSendChat('/news Äëÿ òîãî ÷òîáû áûòü ñïîíñîðîì ìîæíî ïåðåâåñòè äåíüãè íà áàíê ñ÷åò èëè ïåðåäàòü â ðóêè.')
            wait(5000)
            sampSendChat('/news Ñâîè îòâåòû îòïðàâëÿåì íà íîìåð '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news Äàþ Âàì 1 ìèíóòó ÷òîáû äîáàâèòü Ìåíÿ â êîíòàêòû')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/news Ïîçäðàâèì åãî.')
            wait(4000)
            sampSendChat('/news ×òîáû çàáðàòü ïðèç - ïîäîéäèòå ê îôèñó Ðàäèîñòàíöèè.')
            wait(4000)
            sampSendChat('/news À íà ýòîì ÿ çàêàí÷èâàþ âèêòîðèíó.')
            wait(4000)
            sampSendChat('/news Ñïàñèáî, ÷òî áûëè ñ íàìè.')
            wait(4000)
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Çäðàâñòâóéòå, äîðîãèå ðàäèîñëóøàòåëè ')
            wait(5000)
            sampSendChat('/news Ñ âàìè ÿ - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news È ñåãîäíÿ ó íàñ âèêòîðèíà Ìàòåìàòèê')
            wait(5000)
            sampSendChat('/news ß çàãàäûâàþ ïðèìåð. Íàïðèìåð:5 + 5, à Âû äîëæíû ñêàçàòü êàêîé îòâåò..')
            wait(5000)
            sampSendChat('/news Îòâåò áóäåò 10.')
            wait(5000)
            sampSendChat('/news Êàæäûé óãàäàííûé ïðèìåð - 1 áàëë íà ñ÷åò îòâåòèâøåãî.')
            wait(5000)
            sampSendChat('/news À èãðàåì ìû äî 5-òè áàëëîâ.')
            wait(5000)
            sampSendChat('/news Íî äëÿ íà÷àëà íàì íóæíû ñïîíñîðû.')
            wait(5000)
            sampSendChat('/news Äëÿ òîãî ÷òîáû áûòü ñïîíñîðîì ìîæíî ïåðåâåñòè äåíüãè íà áàíê ñ÷åò èëè ïåðåäàòü â ðóêè.')
            wait(5000)
            sampSendChat('/news Ñâîè îòâåòû îòïðàâëÿåì íà íîìåð '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news Äàþ Âàì 1 ìèíóòó ÷òîáû äîáàâèòü Ìåíÿ â êîíòàêòû')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/news Ïîçäðàâèì åãî.')
            wait(4000)
            sampSendChat('/news ×òîáû çàáðàòü ïðèç - ïîäîéäèòå ê îôèñó Ðàäèîñòàíöèè.')
            wait(4000)
            sampSendChat('/news À íà ýòîì ÿ çàêàí÷èâàþ âèêòîðèíó.')
            wait(4000)
            sampSendChat('/news Ñïàñèáî, ÷òî áûëè ñ íàìè.')
            wait(4000)
            sampSendChat('/news /news ...::: Ìóçûêàëüíàÿ çàñòàâêà « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)


    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Çäðàâñòâóéòå ìåíÿ çîâóò '.. u8:decode(mainini.config.NickNameText) ..'*íà ãðóäè âåñèò áåéäæèê '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Õîðîøî.Äàâàéòå ñâîè äîêóìåíòû. À èìåííî ïàñïîðò,ëèöåíçèè è ìåä.êàðòà.')
            wait(3500)
            sampSendChat('/b Âñ¸ ïî ðï')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me âçÿë ïàñïîðò')
            wait(3500)
            sampSendChat('/do Ïàñïîðò â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîâåðèâ äîêóìåíòû, ïåðåäàë ÷åëîâåêó íàïðîòèâ')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me âçÿë ëèöåíçèè â ðóêè ')
            wait(3500)
            sampSendChat('/do Ëèöåíçèè â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ ïàêåò ëèöåíçèé, îòäàë âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me âçÿë ìåä.êíèæêó â ðóêè ')
            wait(3500)
            sampSendChat('/do Ìåä.êíèæêà â ðóêàõ.')
            wait(3500)
            sampSendChat('/me ïðîëèñíóâ Ìåä.êíèãó, îòäàëà âëàäåëüöó')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Äîêóìåíòû â ïîëíîì ïîðÿäêå ')
            wait(3500)
            sampSendChat('Âû ïðèíÿòû íà ñòàæèðîâêó.')
            wait(3500)
            sampSendChat('/do Ïîä ñòîëîì ëåæèò ïàêåò ñ ôîðìîé è ðàöèåé.')
            wait(3500)
            sampSendChat('/me äîñòàë ïàêåò è ïåðåäàëà ÷åëîâåêó íàïðîòèâ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âñåõ, ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Äðåññ-Êîä".')
            wait(3500)
            sampSendChat('Âî-ïåðâûõ, ôîðìà ñîòðóäíèêà äîëæíà áûòü ïîãëàæåíà è ÷èñòà.')
            wait(3500)
            sampSendChat('Âî-âòîðûõ, Âû íå äîëæíû âûãëÿäåòü êàê íà ìàñêàðàäå.')
            wait(3500)
            sampSendChat('Íèêàêèõ ìàåê, êîðîòêèõ þáîê è ò.ä')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Óâàæàåìûå ñîòðóäíèêè Öåíòðàëüíîãî áàíêà, ïðîøó ìèíóòî÷êó âíèìàíèå!')
            wait(3500)
            sampSendChat('Õî÷ó âàì ñêàçàòü, ÷òî òðàíñïîðò ñ äîëæíîñòè "Îõðàííèê" - Çàïðåùåíî áðàòü!')
            wait(3500)
            sampSendChat('Ñ äîëæíîñòè "Ñò.Îõðàííèê" òîæå çàïðåùåíî, áóäüòå âíèìàòåëüíû.')
            wait(3500)
            sampSendChat('Åñëè óâèäåëè íàðóøèòåëÿ êîòîðûé êàòàåòcÿ íà òðàíñïîðòå, íàðóøàÿ óñòàâ.')
            wait(3500)
            sampSendChat('Ïîäàâàéòå â æàëîáíóþ êíèãó íà ñîòðóäíèêà êîòîðûé íàðóøèë óñòàâ.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Ïðèâåòñòâóþ âàñ íà ëåêöèè î ñóáîðäèíàöèè.')
            wait(3500)
            sampSendChat('Äëÿ íà÷àëà ðàññêàæó, ÷òî òàêîå ñóáîðäèíàöèÿ.')
            wait(3500)
            sampSendChat('Ñóáîðäèíàöèÿ - ïðàâèëà ïîä÷èíåíèÿ ìëàäøèõ ïî çâàíèþ ê ñòàðøèì ïî çâàíèþ óâàæåíèå, îòíîøåíèå ê íèì.')
            wait(3500)
            sampSendChat('Òî åñòü ìëàäøèå ñîòðóäíèêè äîëæíû âûïîëíÿòü ïðèêàçû íà÷àëüñòâà.')
            wait(3500)
            sampSendChat('Êòî îñëóøàåòñÿ - ñïåðâà ïîëó÷èò óñòíîå ïðåäóïðåæäåíèå, ïîñëåäóþùèé ðàç - âûãîâîð.')
            wait(3500)
            sampSendChat('Âû äîëæíû ñ óâàæåíèåì îòíîñèòñÿ ê íà÷àëüñòâó è ñòàðøèì ïî äîëæíîñòè íà "Âû".')
            wait(3500)
            sampSendChat('Íå íàðóøàéòå ïðàâèëà è íå íàðóøàéòå ñóáîðäèíàöèþ äàáû íå ïîëó÷èòü íàêàçàíèå.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Ïîãîâîðèì òàê æå è î Ýòèêåòå...')
            wait(3500)
            sampSendChat('Ïðè íà÷àëå äèàëîãà âû äîëæíû ïî ïðèâåòñòâîâàòü ñîáåñåäíèêà...')
            wait(3500)
            sampSendChat('...à â êîíöå äèàëîãà ïîïðîùàòüñÿ')
            wait(3500)
            sampSendChat('Ñîáëþäàòü óâàæåíèå ïðè îáùåíèè')
            wait(3500)
            sampSendChat('Çàïðåùåíî, âìåøèâàòüñÿ â ÷óæîé ðàçãîâîð')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Ñåé÷àñ ÿ ïðî÷èòàþ ëåêöèþ î âðåäå íàðêîòèêîâ.')
            wait(3500)
            sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
            wait(3500)
            sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
            wait(3500)
            sampSendChat('Çà÷àñòóþ íàðêîçàâèñèìûå ïñèõîëîãè÷åñêè íåñòàáèëüíû.')
            wait(3500)
            sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè âûøå ðèñê çàðàæåíèÿ çàáîëåâàíèÿìè.')
            wait(3500)
            sampSendChat('Íà ñåãîäíÿøíèé äåíü íàèáîëåå ðàñïðîñòðàíåíû ñëåäóþùèå âèäû íàðêîòèêîâ...')
            wait(3500)
            sampSendChat('...ìàðèõóàíà, êîêàèí, àìôåòàìèíû, ýêñòàçè, îïèóì.')
            wait(3500)
            sampSendChat('Êàæäûé ìîæåò è äîëæåí ïðîòèâîñòîÿòü íàðêîìàíèè.')
            wait(3500)
            sampSendChat('Îáðåòèòå óâåðåííîñòü â òîì, ÷òî âàì ëè÷íî íàðêîòèêè íå íóæíû.')
            wait(3500)
            sampSendChat('Ëåêöèÿ çàêîí÷åíà. Ñïàñèáî çà âíèìàíèå.')
        end)

end

update_state = false

local script_vers = 11
local script_vers_text = "11.0"

local update_url = "https://raw.githubusercontent.com/DenisMalahovskiyOLSHER/GovernmentBinder/main/update.ini" -- òóò òîæå ñâîþ ññûëêó
local update_path = getWorkingDirectory() .. "/update.ini" -- è òóò ñâîþ ññûëêó

local script_url = "https://raw.githubusercontent.com/DenisMalahovskiyOLSHER/GovernmentBinder/main/newahk.lua?raw=true" -- òóò ñâîþ ññûëêó
local script_path = thisScript().path


function main()
    while not isSampAvailable() do wait(100) end
    --if '185.169.134.108' ~= nil and '185.169.134.108' ~= sampGetCurrentServerAddress() then 
    --    sampAddChatMessage('[Government AHK] {d5dedd} Âû çàøëè íå íà îñíîâíîé ñåðâåð. Ñêðèïò çàâåðøèë ðàáîòó', 0xfe4749)
    --    thisScript():unload()
    --else
        sampAddChatMessage("[Government AHK] {d5dedd}Ñêðèïò áûë óñïåøíî çàãðóæåí.", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}Àâòîð: {fe4749}Denis_Richard", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}×òîáû îòêðûòü ìåíþ íàæìèòå: {fe4749}F3.", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}Âåðñèÿ ñêðèïòà: {fe4749}v."..thisScript().version, 0xfe4749)
    --end

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("Åñòü îáíîâëåíèå! Âåðñèÿ: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

    imgui.Process = false
    apply_custom_style()
    while true do wait(0) 
        imgui.Process = active_menu.v or active_menu_list.v
        local unix_time = os.time(os.date('!*t')) 
        local moscow_time = unix_time + 3 * 60 * 60
        if mainini.config.TimeGovka == os.date('%H:%M:%S',moscow_time) then
            time_gov()
        end
        if isKeyJustPressed(VK_F3) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
            active_menu.v = not active_menu.v
        end
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("Ñêðèïò óñïåøíî îáíîâëåí!", -1)
                    thisScript():reload()
                end
            end)
            break
        end
    end 
end

function imgui.OnDrawFrame()
    apply_custom_style()
    if active_menu.v then
        local x, y = getScreenResolution()
        imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(1.00,1.00,1.00,1.00)
        imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(1.00, 0.28, 0.29, 1.00)
        imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.99) 
        imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(1.00, 0.28, 0.29, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(1.00, 0.28, 0.29, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(1.00, 0.28, 0.29, 1.00)
        imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.16, 0.16, 0.16, 0.54)
        imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.16, 0.16, 0.16, 0.54)
        imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.16, 0.16, 0.16, 0.54)
        imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(1200, 600), imgui.Cond.FirstUseEver)
        imgui.Begin('', active_menu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBringToFrontOnFocus)
        imgui.Image(logo, imgui.ImVec2(251, 40))
        imgui.SameLine()
        if imgui.Button(u8"Ãëàâíàÿ", imgui.ImVec2(135, 35)) then
            menu = 1
        end
        imgui.SameLine()
        if imgui.Button(u8"Âûáîð îðãàíèçàöèè", imgui.ImVec2(135, 35)) then
            menu = 2
        end
        --imgui.SameLine()
        --if imgui.Button(u8"Íàñòðîéêè", imgui.ImVec2(135, 35)) then
        --    menu = 3
        --end
        imgui.SameLine()
        if imgui.Button(u8"Èíôîðìàöèÿ", imgui.ImVec2(135, 35)) then
            menu = 3
        end
        imgui.Separator()
        imgui.Columns(2,"", true)
        imgui.SetColumnWidth(-1, 250)
        imgui.BeginChild("##leftmain", imgui.ImVec2(230, 520), false)
            imgui.NewLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 224) / 2)
            imgui.Image(user, imgui.ImVec2(224, 176))
            imgui.NewLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 230) / 2)
            imgui.BeginChild("##leftmain", imgui.ImVec2(230, 145), true)
                _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                imgui.Text(fa.ICON_USER_CIRCLE ..u8"    Íèêíåéì: ".. sampGetPlayerNickname(id))
                imgui.Text(fa.ICON_ADDRESS_BOOK ..u8"    ID: ".. id)
                imgui.Text(fa.ICON_WIFI ..u8"   Ïèíã: ".. sampGetPlayerPing(id))
                imgui.Text(fa.ICON_HEARTBEAT ..u8"    Çäîðîâüå: ".. sampGetPlayerHealth(id))
                imgui.Text(fa.ICON_SHIELD ..u8"     Áðîíÿ: ".. sampGetPlayerArmor(id))
                imgui.Text(fa.ICON_SERVER ..u8"     Ñåðâåð: Rodina RP 04")
            imgui.EndChild()
            imgui.NewLine()
            imgui.NewLine()
            imgui.NewLine()
            imgui.NewLine()
            imgui.Button(u8"        Âåðñèÿ: 4.0 \nÀâòîð: Denis_Richard", imgui.ImVec2(230, 45))
        imgui.EndChild()
        imgui.NextColumn()
        imgui.SetColumnWidth(-1, 930)
        imgui.BeginChild("##zagolovok", imgui.ImVec2(930, 525), false, imgui.WindowFlags.NoScrollbar)
            if not menu then 
                menu = 1 
            end
            if menu == 1 then
                imgui.CenterText(u8"Ãëàâíàÿ")
                imgui.NewLine()
                if imgui.InputText(u8'NickName íà ðóññêîì', NickNameText) then
                    mainini.config.NickNameText = NickNameText.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Íàçâàíèå îðãàíèçàöèè', Nameorg) then
                    mainini.config.Nameorg = Nameorg.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Òåã îðãàíèçàöèè', Teg) then
                    mainini.config.Teg = Teg.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Íàçâàíèå ðàíãà', Rang) then
                    mainini.config.Rang = Rang.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Ñòðîêà /gov ¹1 áåç òåãà', GOV1) then
                    mainini.config.GOV1 = GOV1.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Ñòðîêà /gov ¹2 áåç òåãà', GOV2) then
                    mainini.config.GOV2 = GOV2.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Ñòðîêà /gov ¹3 áåç òåãà', GOV3) then
                    mainini.config.GOV3 = GOV3.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Íîìåð òåëåôîíà', Number) then
                    mainini.config.Number = Number.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Íîìåð ïîñòà', Post) then
                    mainini.config.Post = Post.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Âðåìÿ îòïðàâêè /gov (H:M:S)', TimeGovka) then
                    mainini.config.TimeGovka = TimeGovka.v
                    inicfg.save(mainini, savee)
                end
            elseif menu == 2 then
                imgui.CenterText(u8"Âûáîð îðãàíèçàöèè")
                imgui.NewLine()
                if imgui.Button(u8'Ïðà-âî', imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForGovernment()
                    sampAddChatMessage("[Government Binder] {d5dedd}Âûáðàíà îðãàíèçàöèÿ - {fe4749}Ïðàâèòåëüñòâî.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"Áàíê", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForBank()
                    sampAddChatMessage("[Government Binder] {d5dedd}Âûáðàíà îðãàíèçàöèÿ - {fe4749}Áàíê.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"ÌÂÄ", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForSP()
                    sampAddChatMessage("[Government Binder] {d5dedd}Âûáðàíà îðãàíèçàöèÿ - {fe4749}ÌÂÄ.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"ÐÖ", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForRCR()
                    sampAddChatMessage("[Government Binder] {d5dedd}Âûáðàíà îðãàíèçàöèÿ - {fe4749}Ðàäèîñòàíöèÿ.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"ÃÊÁ", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForGKB()
                    sampAddChatMessage("[Government Binder] {d5dedd}Âûáðàíà îðãàíèçàöèÿ - {fe4749}ÃÊÁ.", 0xfe4749)
                end
                if imgui.Button(u8"Àðìèÿ", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForArmy()
                    sampAddChatMessage("[Government Binder] {d5dedd}Âûáðàíà îðãàíèçàöèÿ - {fe4749}Àðìèÿ.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"ÔÑÈÍ", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForFSIN()
                    sampAddChatMessage("[Government Binder] {d5dedd}Âûáðàíà îðãàíèçàöèÿ - {fe4749}ÔÑÈÍ.", 0xfe4749)
                end
            elseif menu == 3 then
                imgui.CenterText(u8"Èíôîðìàöèÿ")
            end
        imgui.EndChild()
    end
    imgui.End()
end

function rkeys.onHotKey(id, data)
   if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
      return false
   end
end

function onWindowMessage(msg, wparam, lparam)
    if msg == 0x100 or msg == 0x101 then
        if p == 0x1B and active_menu.v then
            consumeWindowMessage()
            active_menu.v = false
        end
    end  
end
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
function time_gov()
    sampSendChat("/d [".. u8:decode(mainini.config.Teg) .."] - [Âñåì] Çàíèìàþ ãîñóäàðñòâåííóþ Âîëíó íîâîñòåé.")
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV1))
    wait(3500)
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV2))
    wait(3500)
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV3))
    sampSendChat("/d [".. u8:decode(mainini.config.Teg) .."] - [".. u8:decode(mainini.config.Teg) .."] Îcâîáîæäàþ ãîñóäàðñòâåííóþ Âîëíó íîâîñòåé.")
    wait(3500)
    sampSendChat("/rb [Government Binder] Ãîñóäàðñòâåííàÿ âîëíà íîâîñòåé áûëà îòïðàâëåíà: ".. u8:decode(mainini.config.NickNameText))
end
function onScriptTerminate(script, quitGame)
    if script == thisScript() then
        inicfg.save(mainini, savee)
        sampAddChatMessage('[Government Binder]{d5dedd} Ñêðèïò àâàðèéíî çàâåðøèë ðàáîòó è ñîõðàíèë íàñòðîéêè', 0xfe4749)
    end
end

function imgui.TextColoredRGB(text, render_text)
    local max_float = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end

            local length = imgui.CalcTextSize(w)
            if render_text == 2 then
                imgui.NewLine()
                imgui.SameLine(max_float / 2 - ( length.x / 2 ))
            elseif render_text == 3 then
                imgui.NewLine()
                imgui.SameLine(max_float - length.x - 5 )
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], text[i])
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(w) end


        end
    end

    render_text(text)
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
    style.FramePadding = ImVec2(10, 4)
    style.FrameRounding = 6
    style.ItemSpacing = ImVec2(10, 7)
    style.ItemInnerSpacing = ImVec2(17, 9)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 10.0
    style.WindowRounding = 10
    style.ScrollbarRounding = 15.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 16.0
    style.WindowTitleAlign = ImVec2(0.50, 0.50)
    style.ButtonTextAlign = ImVec2(0.50, 0.50)

    colors[clr.Text]                 = ImVec4(0.75, 0.75, 0.75, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.35, 0.35, 0.35, 1.00)
    colors[clr.WindowBg]             = ImVec4(0.00, 0.00, 0.00, 0.94)
    colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 1.00)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.09, 0.09, 0.09, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(0.09, 0.09, 0.09, 0.54)
    colors[clr.FrameBgActive]        = ImVec4(0.09, 0.09, 0.09, 0.54)
    colors[clr.TitleBg]              = ImVec4(0.00, 0.00, 0.00, 0.99)
    colors[clr.TitleBgActive]        = ImVec4(0.00, 0.00, 0.00, 0.99)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.99)
    colors[clr.MenuBarBg]            = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.Button]               = ImVec4(0.47, 0.22, 0.22, 0.65)
    colors[clr.ButtonHovered]        = ImVec4(0.71, 0.39, 0.39, 0.65)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CheckMark]            = ImVec4(0.56, 0.10, 0.10, 1.00)
    colors[clr.CloseButton]          = ImVec4(1.00, 0.28, 0.29, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(1.00, 0.28, 0.29, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(1.00, 0.28, 0.29, 1.00)
    colors[clr.SliderGrab]           = ImVec4(1.00, 0.19, 0.19, 0.40)
    colors[clr.SliderGrabActive]     = ImVec4(0.89, 0.00, 0.19, 1.00)
    colors[clr.Button]               = ImVec4(0.08, 0.08, 0.08, 0.65)
    colors[clr.ButtonHovered]        = ImVec4(0.15, 0.15, 0.15, 0.65)
    colors[clr.ButtonActive]         = ImVec4(0.15, 0.15, 0.15, 0.65)
    colors[clr.Header]               = ImVec4(0.33, 0.35, 0.36, 0.53)
    colors[clr.HeaderHovered]        = ImVec4(0.76, 0.28, 0.44, 0.67)
    colors[clr.HeaderActive]         = ImVec4(0.47, 0.47, 0.47, 0.67)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.ResizeGrip]           = ImVec4(1.00, 1.00, 1.00, 0.85)
    colors[clr.ResizeGripHovered]    = ImVec4(1.00, 1.00, 1.00, 0.60)
    colors[clr.ResizeGripActive]     = ImVec4(1.00, 1.00, 1.00, 0.90)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
    colors[clr.WindowBg]             = ImVec4(0.09, 0.09, 0.09, 0.94)
    colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 1.00)
    colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 1.00)
end
