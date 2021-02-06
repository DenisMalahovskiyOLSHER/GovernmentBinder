script_version("4.0")
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
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) .."*на груди весит бейджик ".. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Чем могу быть любезен?')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/do Дубинка на поясе.')
            wait(3500)
            sampSendChat('/todo Прошу вас вести себя аккуратно или я вас выгоню из банка*снимая дубинку')
            wait(3500)
            sampSendChat('/do Дубинка снята с пояса.')
            wait(3500)
            sampSendChat('/me берет дубинку в руки')
            wait(3500)
            sampSendChat('/do Дубинка в руках.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me накидывается на нарушителя и пытается заломать ему руки.')
            wait(3500)
            sampSendChat('/me крепко держа нарушителя за руки, выводит его на улицу.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/expel ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me вешает дубинку на пояс')
            wait(3500)
            sampSendChat('/do Дубинка на поясе.')
            end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me зашёл в базу данных Центрального Банка ')
            wait(3500)
            sampSendChat('/me нашёл профиль гражданина и вписал данные ')
            wait(3500)
            sampSendChat('/do Данные вписаны. ')
            wait(3500)
            sampSendChat('/me взял печать "ЦБ" ')
            wait(3500)
            sampSendChat('/do Печать "ЦБ" в руках. ')
            wait(3500)
            sampSendChat('/me поставил печать "ЦБ" ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Здравствуйте, я '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'. Вы желаете восстановить пин-код от карты?')
            wait(3500)
            sampSendChat('Хорошо, передайте мне ваш паспорт.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/me взял паспорт ')
            wait(3500)
            sampSendChat('/do Паспорт в руках. ')
            wait(3500)
            sampSendChat('Хорошо, сейчас будем восстанавливать. ')
            wait(3500)
            sampSendChat('/me пробил по базе данных карточек центрального банка имя и фамилию гражданина ')
            wait(3500)
            sampSendChat('/do Обнаружил карточку в базе данных.')
            wait(3500)
            sampSendChat('/me занес в базу данных новый пароль ')
            wait(3500)
            sampSendChat('/me восстановил пин код карточки гражданина ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('Здравствуйте, я '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'. Вы желаете оформить кредит?')
            wait(3500)
            sampSendChat('Хорошо, передайте мне ваш паспорт.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('Хорошо, сейчас будем оформлять документы на кредит.')
            wait(3500)
            sampSendChat('/me пробил по базе данных центрального банка имя и фамилию гражданина')
            wait(3500)
            sampSendChat('/do Обнаружил гражданина в базе данных.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('/r Докладывает: '.. u8:decode(mainini.config.NickNameText) ..' | Пост: №'.. u8:decode(mainini.config.Post) ..' | Состояние: стабильное')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) ..'*на груди весит бейджик '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Вы пришли к нам на собеседование ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Хорошо.Давайте свои документы. А именно паспорт,лицензии и мед.карта.')
            wait(3500)
            sampSendChat('/b Всё по рп')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me проверив документы, передал человеку напротив')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me взял лицензии в руки ')
            wait(3500)
            sampSendChat('/do Лицензии в руках.')
            wait(3500)
            sampSendChat('/me пролиснув пакет лицензий, отдал владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял мед.книжку в руки ')
            wait(3500)
            sampSendChat('/do Мед.книжка в руках.')
            wait(3500)
            sampSendChat('/me пролиснув Мед.книгу, отдала владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Документы в полном порядке ')
            wait(3500)
            sampSendChat('Вы приняты на стажировку.')
            wait(3500)
            sampSendChat('/do Под столом лежит пакет с формой и рацией.')
            wait(3500)
            sampSendChat('/me достал пакет и передала человеку напротив')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Приветствую всех, сейчас я проведу лекцию на тему "Дресс-Код".')
            wait(3500)
            sampSendChat('Во-первых, форма сотрудника должна быть поглажена и чиста.')
            wait(3500)
            sampSendChat('Во-вторых, Вы не должны выглядеть как на маскараде.')
            wait(3500)
            sampSendChat('Никаких маек, коротких юбок и т.д')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Уважаемые сотрудники Центрального банка, прошу минуточку внимание!')
            wait(3500)
            sampSendChat('Хочу вам сказать, что транспорт с должности "Охранник" - Запрещено брать!')
            wait(3500)
            sampSendChat('С должности "Ст.Охранник" тоже запрещено, будьте внимательны.')
            wait(3500)
            sampSendChat('Если увидели нарушителя который катаетcя на транспорте, нарушая устав.')
            wait(3500)
            sampSendChat('Подавайте в жалобную книгу на сотрудника который нарушил устав.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Приветствую вас на лекции о субординации.')
            wait(3500)
            sampSendChat('Для начала расскажу, что такое субординация.')
            wait(3500)
            sampSendChat('Субординация - правила подчинения младших по званию к старшим по званию уважение, отношение к ним.')
            wait(3500)
            sampSendChat('То есть младшие сотрудники должны выполнять приказы начальства.')
            wait(3500)
            sampSendChat('Кто ослушается - сперва получит устное предупреждение, последующий раз - выговор.')
            wait(3500)
            sampSendChat('Вы должны с уважением относится к начальству и старшим по должности на "Вы".')
            wait(3500)
            sampSendChat('Не нарушайте правила и не нарушайте субординацию дабы не получить наказание.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Поговорим так же и о Этикете...')
            wait(3500)
            sampSendChat('При начале диалога вы должны по приветствовать собеседника...')
            wait(3500)
            sampSendChat('...а в конце диалога попрощаться')
            wait(3500)
            sampSendChat('Соблюдать уважение при общении')
            wait(3500)
            sampSendChat('Запрещено, вмешиваться в чужой разговор')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Сейчас я прочитаю лекцию о вреде наркотиков.')
            wait(3500)
            sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
            wait(3500)
            sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
            wait(3500)
            sampSendChat('Зачастую наркозависимые психологически нестабильны.')
            wait(3500)
            sampSendChat('В среде употребляющих наркотики выше риск заражения заболеваниями.')
            wait(3500)
            sampSendChat('На сегодняшний день наиболее распространены следующие виды наркотиков...')
            wait(3500)
            sampSendChat('...марихуана, кокаин, амфетамины, экстази, опиум.')
            wait(3500)
            sampSendChat('Каждый может и должен противостоять наркомании.')
            wait(3500)
            sampSendChat('Обретите уверенность в том, что вам лично наркотики не нужны.')
            wait(3500)
            sampSendChat('Лекция закончена. Спасибо за внимание.')
        end)
end

function RegisterHotkeysForGovernment()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function ()       
            sampSendChat('Здравствуйте, я '.. u8:decode(mainini.config.Rang) ..' - '.. u8:decode(mainini.config.NickNameText) ..'.')
            wait(3500)
            sampSendChat('/do На груди бейджик: '.. u8:decode(mainini.config.Rang) ..'.')
            wait(3500)
            sampSendChat('Чем могу вам помочь? ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function ()
            sampSendChat('/do Дубинка висит на поясе в специальном креплении.')
            wait(3500)
            sampSendChat('/me резким движением правой руки снял(а) дубинку с пояса')
            wait(3500)
            sampSendChat('/do Дубинка находится в правой руке.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function ()
            sampSendChat('/todo Прошу вас вести себя спокойно или я вас выведу из здания*снимая дубинку')
            wait(3500)
            sampSendChat('/do Дубинка снята с пояса.')
            wait(3500)
            sampSendChat('/me берет дубинку в правую руку')
            wait(3500)
            sampSendChat('/do Дубинка в правой руке.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function ()
            sampSendChat('/me накидывается на нарушителя и пытается заломать ему руки ')
            wait(3500)
            sampSendChat('/me крепко держа нарушителя за руки, выводит его на улицу ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/expel ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function ()
            sampSendChat('/do Дубинка находится в правой руке.')
            wait(3500)
            sampSendChat('/me плавным движением правой руки повесил(а) дубинку на пояс в специальное крепление')
            wait(3500)
            sampSendChat('/do Дубинка находится на поясе в специальном креплении.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function ()
            sampSendChat('/do Удостоверение находится в правом внутреннем кармане пиджака.')
            wait(3500)
            sampSendChat('/me плавным движением левой рукой приоткрыл пиджак')
            wait(3500)
            sampSendChat('/me достал правой рукой из внутреннего кармана пиджака удостоверение')
            wait(3500)
            sampSendChat('/do Удостоверение в правой руке.')
            wait(3500)
            sampSendChat('/me открыл удостоверение')
            wait(3500)
            sampSendChat('/do Удостоверение в открытом виде.')
            wait(3500)
            sampSendChat('/do В удостоверении написано: '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/showpass ")
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) ..'*на груди весит бейджик '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Вы пришли к нам на собеседование ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Хорошо.Давайте свои документы. А именно паспорт,лицензии и мед.карта.')
            wait(3500)
            sampSendChat('/b Всё по рп')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me проверив документы, передал человеку напротив')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me взял лицензии в руки ')
            wait(3500)
            sampSendChat('/do Лицензии в руках.')
            wait(3500)
            sampSendChat('/me пролиснув пакет лицензий, отдал владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял мед.книжку в руки ')
            wait(3500)
            sampSendChat('/do Мед.книжка в руках.')
            wait(3500)
            sampSendChat('/me пролиснув Мед.книгу, отдала владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Документы в полном порядке ')
            wait(3500)
            sampSendChat('Вы приняты на стажировку.')
            wait(3500)
            sampSendChat('/do Под столом лежит пакет с формой и рацией.')
            wait(3500)
            sampSendChat('/me достал пакет и передала человеку напротив')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Приветствую всех, сейчас я проведу лекцию на тему "Дресс-Код".')
            wait(3500)
            sampSendChat('Во-первых, форма сотрудника должна быть поглажена и чиста.')
            wait(3500)
            sampSendChat('Во-вторых, Вы не должны выглядеть как на маскараде.')
            wait(3500)
            sampSendChat('Никаких маек, коротких юбок и т.д')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Уважаемые сотрудники Центрального банка, прошу минуточку внимание!')
            wait(3500)
            sampSendChat('Хочу вам сказать, что транспорт с должности "Охранник" - Запрещено брать!')
            wait(3500)
            sampSendChat('С должности "Ст.Охранник" тоже запрещено, будьте внимательны.')
            wait(3500)
            sampSendChat('Если увидели нарушителя который катаетcя на транспорте, нарушая устав.')
            wait(3500)
            sampSendChat('Подавайте в жалобную книгу на сотрудника который нарушил устав.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Приветствую вас на лекции о субординации.')
            wait(3500)
            sampSendChat('Для начала расскажу, что такое субординация.')
            wait(3500)
            sampSendChat('Субординация - правила подчинения младших по званию к старшим по званию уважение, отношение к ним.')
            wait(3500)
            sampSendChat('То есть младшие сотрудники должны выполнять приказы начальства.')
            wait(3500)
            sampSendChat('Кто ослушается - сперва получит устное предупреждение, последующий раз - выговор.')
            wait(3500)
            sampSendChat('Вы должны с уважением относится к начальству и старшим по должности на "Вы".')
            wait(3500)
            sampSendChat('Не нарушайте правила и не нарушайте субординацию дабы не получить наказание.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Поговорим так же и о Этикете...')
            wait(3500)
            sampSendChat('При начале диалога вы должны по приветствовать собеседника...')
            wait(3500)
            sampSendChat('...а в конце диалога попрощаться')
            wait(3500)
            sampSendChat('Соблюдать уважение при общении')
            wait(3500)
            sampSendChat('Запрещено, вмешиваться в чужой разговор')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Сейчас я прочитаю лекцию о вреде наркотиков.')
            wait(3500)
            sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
            wait(3500)
            sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
            wait(3500)
            sampSendChat('Зачастую наркозависимые психологически нестабильны.')
            wait(3500)
            sampSendChat('В среде употребляющих наркотики выше риск заражения заболеваниями.')
            wait(3500)
            sampSendChat('На сегодняшний день наиболее распространены следующие виды наркотиков...')
            wait(3500)
            sampSendChat('...марихуана, кокаин, амфетамины, экстази, опиум.')
            wait(3500)
            sampSendChat('Каждый может и должен противостоять наркомании.')
            wait(3500)
            sampSendChat('Обретите уверенность в том, что вам лично наркотики не нужны.')
            wait(3500)
            sampSendChat('Лекция закончена. Спасибо за внимание.')
        end)
end

function RegisterHotkeysForArmy()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function ()
            sampSendChat('Здравия Желаю. Я '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'.')
            sampSendChat('/do На плечах погоны '.. u8:decode(mainini.config.Rang) ..'.')
            sampSendChat('/do Удостоверение в кармане.')
            sampSendChat('/me взял удостоверение с кармана, затем показал гражданину напротив.')
            sampSendChat('/do Показал удостоверение.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/showpass ")
            sampSendChat('Разрешите узнать, с какой целью вы приехали на охроняемую территорию.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function ()
            sampSendChat('/me протянул левую руку и взял документы')
            sampSendChat('/do Документы в левой руке.')
            sampSendChat('/me открыл документы и начал изучать')
            sampSendChat('/me изучил документы, затем закрыл его')
            sampSendChat('/me передал документы гражданину напротив')
            sampSendChat('/do Документы переданы.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function ()
            sampSendChat('/s От КПП на 10 Метров иначе я сочту это как неподченение и мы откроем огонь.') 
            sampSendChat('/s У вас 5 Секунд.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function ()
            sampSendChat('/me достал оружие из-за спины')
            sampSendChat('/do Оружие в руках.')
            sampSendChat('/me передернул затвор')
            sampSendChat('/do Оружие в боевой готовности.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function ()
            sampSendChat('/me поставил оружие на предохранитель')
            sampSendChat('/do Оружие на предохранителе.')
            sampSendChat('/me убрал оружие за спину')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function ()
            sampSendChat('Рядовой '.. u8:decode(mainini.config.NickNameText) ..' к разборке АК-47 приступил!')
            sampSendChat('/me Отделил магазин,затем снял с предохранителя и перезарядил')
            sampSendChat('/me Поставил автомат на пистолетную рукоятку и нажал на курок')
            sampSendChat('/me Вытащил шомпол и выкрутил пламегаситель,затем опустил автомат')
            sampSendChat('/me Снял крышку ствольной коробки и вытащил возвратный механизм')
            sampSendChat('/me Вытащил затвор с затворной рамой и отделил их от друг друга')
            sampSendChat('/me Вытащил газовую камеру')
            sampSendChat('Рядовой '.. u8:decode(mainini.config.NickNameText) ..' разборку закончил!.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function ()
            sampSendChat('Рядовой '.. u8:decode(mainini.config.NickNameText) ..' сборку АК-47 приступил.')
            sampSendChat('/me Присоединил затвор к затворной раме,затем вставил всё в автомат')
            sampSendChat('/me Присоединил возвратный механизм')
            sampSendChat('/me Закрыл ствольную коробку крышкой ствольной коробки')
            sampSendChat('/me Поставил автомат на пистолетную рукоятку и вставил шомпол')
            sampSendChat('/me Закрутил пламегаситель')
            sampSendChat('/me Нажал на спусковой кручок')
            sampSendChat('/me Поставил автомат на предохранитель.')
            sampSendChat('Рядовой '.. u8:decode(mainini.config.NickNameText) ..' сборку АК-47 закончил!.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function ()
            sampSendChat('/me взял в руки книгу с присягой.')
            sampSendChat('/me открыл книгу.')
            sampSendChat('Я, Рядовой '.. u8:decode(mainini.config.NickNameText) ..', торжественно присягаю на верность своей Родине.')
            sampSendChat('Клянусь свято соблюдать Конституцию Российской Федерации')
            sampSendChat('Клянусь строго выполнять требования воинских уставов.')
            sampSendChat('Клянусь строго выполнять приказы командиров и начальников')
            sampSendChat('Клянусь достойно исполнять воинский долг.')
            sampSendChat('Клянусь мужественно защищать свободу и независимость.')
            sampSendChat('Рядовой '.. u8:decode(mainini.config.NickNameText) ..' присягу окончил.')
            sampSendChat('/me закрыл книгу')
        end)
    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) ..'*на груди весит бейджик '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Вы пришли к нам на собеседование ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Хорошо.Давайте свои документы. А именно паспорт,лицензии и мед.карта.')
            wait(3500)
            sampSendChat('/b Всё по рп')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me проверив документы, передал человеку напротив')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me взял лицензии в руки ')
            wait(3500)
            sampSendChat('/do Лицензии в руках.')
            wait(3500)
            sampSendChat('/me пролиснув пакет лицензий, отдал владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял мед.книжку в руки ')
            wait(3500)
            sampSendChat('/do Мед.книжка в руках.')
            wait(3500)
            sampSendChat('/me пролиснув Мед.книгу, отдала владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Документы в полном порядке ')
            wait(3500)
            sampSendChat('Вы приняты на стажировку.')
            wait(3500)
            sampSendChat('/do Под столом лежит пакет с формой и рацией.')
            wait(3500)
            sampSendChat('/me достал пакет и передала человеку напротив')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Приветствую всех, сейчас я проведу лекцию на тему "Дресс-Код".')
            wait(3500)
            sampSendChat('Во-первых, форма сотрудника должна быть поглажена и чиста.')
            wait(3500)
            sampSendChat('Во-вторых, Вы не должны выглядеть как на маскараде.')
            wait(3500)
            sampSendChat('Никаких маек, коротких юбок и т.д')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Уважаемые сотрудники Центрального банка, прошу минуточку внимание!')
            wait(3500)
            sampSendChat('Хочу вам сказать, что транспорт с должности "Охранник" - Запрещено брать!')
            wait(3500)
            sampSendChat('С должности "Ст.Охранник" тоже запрещено, будьте внимательны.')
            wait(3500)
            sampSendChat('Если увидели нарушителя который катаетcя на транспорте, нарушая устав.')
            wait(3500)
            sampSendChat('Подавайте в жалобную книгу на сотрудника который нарушил устав.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Приветствую вас на лекции о субординации.')
            wait(3500)
            sampSendChat('Для начала расскажу, что такое субординация.')
            wait(3500)
            sampSendChat('Субординация - правила подчинения младших по званию к старшим по званию уважение, отношение к ним.')
            wait(3500)
            sampSendChat('То есть младшие сотрудники должны выполнять приказы начальства.')
            wait(3500)
            sampSendChat('Кто ослушается - сперва получит устное предупреждение, последующий раз - выговор.')
            wait(3500)
            sampSendChat('Вы должны с уважением относится к начальству и старшим по должности на "Вы".')
            wait(3500)
            sampSendChat('Не нарушайте правила и не нарушайте субординацию дабы не получить наказание.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Поговорим так же и о Этикете...')
            wait(3500)
            sampSendChat('При начале диалога вы должны по приветствовать собеседника...')
            wait(3500)
            sampSendChat('...а в конце диалога попрощаться')
            wait(3500)
            sampSendChat('Соблюдать уважение при общении')
            wait(3500)
            sampSendChat('Запрещено, вмешиваться в чужой разговор')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Сейчас я прочитаю лекцию о вреде наркотиков.')
            wait(3500)
            sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
            wait(3500)
            sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
            wait(3500)
            sampSendChat('Зачастую наркозависимые психологически нестабильны.')
            wait(3500)
            sampSendChat('В среде употребляющих наркотики выше риск заражения заболеваниями.')
            wait(3500)
            sampSendChat('На сегодняшний день наиболее распространены следующие виды наркотиков...')
            wait(3500)
            sampSendChat('...марихуана, кокаин, амфетамины, экстази, опиум.')
            wait(3500)
            sampSendChat('Каждый может и должен противостоять наркомании.')
            wait(3500)
            sampSendChat('Обретите уверенность в том, что вам лично наркотики не нужны.')
            wait(3500)
            sampSendChat('Лекция закончена. Спасибо за внимание.')
        end)
end

function RegisterHotkeysForGKB()
    rkeys.registerHotKey({ VK_F1 }, 1, true,
        function()
            sampSendChat('/do В правой руке находится папка с надписью "Клятва Гиппократа"..')
            wait(3500)
            sampSendChat('/me положив правую руку на сердце, встал на колени и раскрыл папку')
            wait(3500)
            sampSendChat('Клянусь Аполлоном врачом, Асклепием, Гигиеей и Панакеей и всеми богами и богинями...')
            wait(3500)
            sampSendChat('беря их в свидетели, исполнять честно, соответственно моим силам и моему разумению.')
            wait(3500)
            sampSendChat('Я направлю режим больных к их выгоде сообразно с моими силами и моим разумением, воздерживаясь...')
            wait(3500)
            sampSendChat('от причинения всякого вреда и несправедливости.')
            wait(3500)
            sampSendChat('Я не дам никому просимого у меня смертельного средства и не покажу пути для подобного замысла.')
            wait(3500)
            sampSendChat('Я ни в коем случае не буду делать сечения у страдающих каменной болезнью.')
            wait(3500)
            sampSendChat('предоставив это людям, занимающимся этим делом. В какой бы дом я ни вошел, я войду туда для пользы больного.')
            wait(3500)
            sampSendChat('/me опустив руку, встал на ноги и закрыл папку')
            wait(3500)
            sampSendChat('/do Папка с надписью "Клятва Гиппократа" находится в правой руке')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Здравствуйте, я '.. u8:decode(mainini.config.Rang) ..' - '.. u8:decode(mainini.config.NickNameText))
            wait(3500)
            sampSendChat('/do На груди висит бэйджек '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Могу ли я Вам чем-то помочь?')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do Мед. сумка на плече.')
            wait(3500)
            sampSendChat('/me снял мед.сумку')
            wait(3500)
            sampSendChat('/me открыл мед.сумку')
            wait(3500)
            sampSendChat('/me достал нужный препарат')
            wait(3500)
            sampSendChat('/do Препарат в руке.')
            wait(3500)
            sampSendChat('/me передал человеку напротив')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/heal ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Мед. карта обойдётся Вам в 2500 рублей.')
            wait(3500)
            sampSendChat('/b /pay ID 2500')
            wait(3500)
            sampSendChat('После оплаты, Вам будет выдана мед. карта.')
            wait(3500)
            sampSendChat('/me достал пачку чистых мед. карт и начал заполнять новую мед. карту')
            wait(3500)
            sampSendChat('/do Мед. карта готова. Статус: полностью здоров.')
            wait(3500)
            sampSendChat('/me передал готовую мед. карту человеку')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/medcard ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Рецепт будет стоить 1500 рублей.')
            wait(3500)
            sampSendChat('/b /pay ID 1500')
            wait(3500)
            sampSendChat('После оплаты, Вам будет выдан рецепт')
            wait(3500)
            sampSendChat('/me достал пачку чистых рецептов и передал человеку')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/recept ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('Здравствуйте, вы пришли на сеанс по выведению тату?')
            wait(3500)
            sampSendChat('Хорошо, это будет стоить вам 6000руб.')
            wait(3500)
            sampSendChat('Так же прошу вас передать мне ваш паспорт')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/me берёт паспорт у человека напротив')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me читает данные с паспорта.')
            wait(3500)
            sampSendChat('/todo Все хорошо*Передавая его обратно.')
            wait(3500)
            sampSendChat('Теперь снимайте с себя рубашку, чтоб я вывел ваши тату.')
            sampSendChat('/n /showtatu')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/do Аппарат для вышивки тату на столе.')
            wait(3500)
            sampSendChat('/me взял аппарат для извлечения тату.')
            wait(3500)
            sampSendChat('/do Аппарат в правой руке.')
            wait(3500)
            sampSendChat('/me начал выводить тату.')
            wait(3500)
            sampSendChat('Все, ваш сеанс окончен. Всего Вам доброго.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/unstuff ид 6000")
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('Стоимость одной аптечки составляет 650 рублей.')
            wait(3500)
            sampSendChat('/b Команда для покупки:')
            wait(3500)
            sampSendChat('/b /pay Мой ID 650.')
            wait(3500)
            sampSendChat('/me открыла сумку с аптечками.')
            wait(3500)
            sampSendChat('/me достала и сумки необходимое кол-во аптечек.')
            wait(3500)
            sampSendChat('/me пересчитав ещё раз, передала аптечки человеку.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/sellmed ")
        end)
    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) ..'*на груди весит бейджик '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Вы пришли к нам на собеседование ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Хорошо.Давайте свои документы. А именно паспорт,лицензии и мед.карта.')
            wait(3500)
            sampSendChat('/b Всё по рп')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me проверив документы, передал человеку напротив')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me взял лицензии в руки ')
            wait(3500)
            sampSendChat('/do Лицензии в руках.')
            wait(3500)
            sampSendChat('/me пролиснув пакет лицензий, отдал владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял мед.книжку в руки ')
            wait(3500)
            sampSendChat('/do Мед.книжка в руках.')
            wait(3500)
            sampSendChat('/me пролиснув Мед.книгу, отдала владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Документы в полном порядке ')
            wait(3500)
            sampSendChat('Вы приняты на стажировку.')
            wait(3500)
            sampSendChat('/do Под столом лежит пакет с формой и рацией.')
            wait(3500)
            sampSendChat('/me достал пакет и передала человеку напротив')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Приветствую всех, сейчас я проведу лекцию на тему "Дресс-Код".')
            wait(3500)
            sampSendChat('Во-первых, форма сотрудника должна быть поглажена и чиста.')
            wait(3500)
            sampSendChat('Во-вторых, Вы не должны выглядеть как на маскараде.')
            wait(3500)
            sampSendChat('Никаких маек, коротких юбок и т.д')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Уважаемые сотрудники Центрального банка, прошу минуточку внимание!')
            wait(3500)
            sampSendChat('Хочу вам сказать, что транспорт с должности "Охранник" - Запрещено брать!')
            wait(3500)
            sampSendChat('С должности "Ст.Охранник" тоже запрещено, будьте внимательны.')
            wait(3500)
            sampSendChat('Если увидели нарушителя который катаетcя на транспорте, нарушая устав.')
            wait(3500)
            sampSendChat('Подавайте в жалобную книгу на сотрудника который нарушил устав.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Приветствую вас на лекции о субординации.')
            wait(3500)
            sampSendChat('Для начала расскажу, что такое субординация.')
            wait(3500)
            sampSendChat('Субординация - правила подчинения младших по званию к старшим по званию уважение, отношение к ним.')
            wait(3500)
            sampSendChat('То есть младшие сотрудники должны выполнять приказы начальства.')
            wait(3500)
            sampSendChat('Кто ослушается - сперва получит устное предупреждение, последующий раз - выговор.')
            wait(3500)
            sampSendChat('Вы должны с уважением относится к начальству и старшим по должности на "Вы".')
            wait(3500)
            sampSendChat('Не нарушайте правила и не нарушайте субординацию дабы не получить наказание.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Поговорим так же и о Этикете...')
            wait(3500)
            sampSendChat('При начале диалога вы должны по приветствовать собеседника...')
            wait(3500)
            sampSendChat('...а в конце диалога попрощаться')
            wait(3500)
            sampSendChat('Соблюдать уважение при общении')
            wait(3500)
            sampSendChat('Запрещено, вмешиваться в чужой разговор')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Сейчас я прочитаю лекцию о вреде наркотиков.')
            wait(3500)
            sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
            wait(3500)
            sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
            wait(3500)
            sampSendChat('Зачастую наркозависимые психологически нестабильны.')
            wait(3500)
            sampSendChat('В среде употребляющих наркотики выше риск заражения заболеваниями.')
            wait(3500)
            sampSendChat('На сегодняшний день наиболее распространены следующие виды наркотиков...')
            wait(3500)
            sampSendChat('...марихуана, кокаин, амфетамины, экстази, опиум.')
            wait(3500)
            sampSendChat('Каждый может и должен противостоять наркомании.')
            wait(3500)
            sampSendChat('Обретите уверенность в том, что вам лично наркотики не нужны.')
            wait(3500)
            sampSendChat('Лекция закончена. Спасибо за внимание.')
        end)
end

function RegisterHotkeysForFSIN()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/do Дубинка на поясе')
            wait(3500)
            sampSendChat('/me снял дубинку с пояса.')
            wait(3500)
            sampSendChat('/do Дубинка в руках')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/do Дубинка в руке')
            wait(3500)
            sampSendChat('/me вешает дубинку на пояс.')
            wait(3500)
            sampSendChat('/do Дубинка на поясе')
        end)


    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me снял автомат с плеча.')
            wait(3500)
            sampSendChat('/do Автомат в руке.')
            wait(3500)
            sampSendChat('/me снял автомат с предохранителя.')
            wait(3500)
            sampSendChat('/me передернул затвор.')
            wait(3500)
            sampSendChat('/do Рука на спусковом крючке.')
            wait(3500)
            sampSendChat('/me готов стрелять.')
        end)


    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do Автомат в руках.')
            wait(3500)
            sampSendChat('/me поставил автомат на предохранитель.')
            wait(3500)
            sampSendChat('/me убрал автомат за плечо.')
            wait(3500)
            sampSendChat('/do Автомат на плече.')
        end)


    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me достает пистолет макарова из кобуры')
            wait(3500)
            sampSendChat('/do Пистолет макарова в руке')
            wait(3500)
            sampSendChat('/me снял пистолет макарова с предохранителя')
            wait(3500)
            sampSendChat('/me передернул затвор')
            wait(3500)
            sampSendChat('/do Рука на спусковом крючке')
            wait(3500)
            sampSendChat('/me готов стрелять') 
        end)


    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/do Пистолет макарова в руках')
            wait(3500)
            sampSendChat('/me поставил пистолет макарова на предохранитель')
            wait(3500)
            sampSendChat('/me убрал пистолет в кобуру')
            wait(3500)
            sampSendChat('/do Пистолет в кобуре')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/do Наручники висят на поясе.')
            wait(3500)
            sampSendChat('/me резким движением снял наручники с пояса')
            wait(3500)
            sampSendChat('/do Наручники в руках.')
            wait(3500)
            sampSendChat('/me надевает наручники на задержанного')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/cuff ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/do Ключ от наручников в руках.')
            wait(3500)
            sampSendChat('/me движением ключа снял наручники')
            wait(3500)
            sampSendChat('/do Наручники в руках.')
            wait(3500)
            sampSendChat('/me вешает наручники на пояс')
            sampSetChatInputText("/uncuff ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me взял заключённого под руку и ведёт за собой')
            wait(3500)
            sampSendChat('/do Сотрудник КСР ведёт заключённого.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/gotome ")
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) ..'*на груди весит бейджик '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Вы пришли к нам на собеседование ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Хорошо.Давайте свои документы. А именно паспорт,лицензии и мед.карта.')
            wait(3500)
            sampSendChat('/b Всё по рп')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me проверив документы, передал человеку напротив')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me взял лицензии в руки ')
            wait(3500)
            sampSendChat('/do Лицензии в руках.')
            wait(3500)
            sampSendChat('/me пролиснув пакет лицензий, отдал владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял мед.книжку в руки ')
            wait(3500)
            sampSendChat('/do Мед.книжка в руках.')
            wait(3500)
            sampSendChat('/me пролиснув Мед.книгу, отдала владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Документы в полном порядке ')
            wait(3500)
            sampSendChat('Вы приняты на стажировку.')
            wait(3500)
            sampSendChat('/do Под столом лежит пакет с формой и рацией.')
            wait(3500)
            sampSendChat('/me достал пакет и передала человеку напротив')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Приветствую всех, сейчас я проведу лекцию на тему "Дресс-Код".')
            wait(3500)
            sampSendChat('Во-первых, форма сотрудника должна быть поглажена и чиста.')
            wait(3500)
            sampSendChat('Во-вторых, Вы не должны выглядеть как на маскараде.')
            wait(3500)
            sampSendChat('Никаких маек, коротких юбок и т.д')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Уважаемые сотрудники Центрального банка, прошу минуточку внимание!')
            wait(3500)
            sampSendChat('Хочу вам сказать, что транспорт с должности "Охранник" - Запрещено брать!')
            wait(3500)
            sampSendChat('С должности "Ст.Охранник" тоже запрещено, будьте внимательны.')
            wait(3500)
            sampSendChat('Если увидели нарушителя который катаетcя на транспорте, нарушая устав.')
            wait(3500)
            sampSendChat('Подавайте в жалобную книгу на сотрудника который нарушил устав.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Приветствую вас на лекции о субординации.')
            wait(3500)
            sampSendChat('Для начала расскажу, что такое субординация.')
            wait(3500)
            sampSendChat('Субординация - правила подчинения младших по званию к старшим по званию уважение, отношение к ним.')
            wait(3500)
            sampSendChat('То есть младшие сотрудники должны выполнять приказы начальства.')
            wait(3500)
            sampSendChat('Кто ослушается - сперва получит устное предупреждение, последующий раз - выговор.')
            wait(3500)
            sampSendChat('Вы должны с уважением относится к начальству и старшим по должности на "Вы".')
            wait(3500)
            sampSendChat('Не нарушайте правила и не нарушайте субординацию дабы не получить наказание.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Поговорим так же и о Этикете...')
            wait(3500)
            sampSendChat('При начале диалога вы должны по приветствовать собеседника...')
            wait(3500)
            sampSendChat('...а в конце диалога попрощаться')
            wait(3500)
            sampSendChat('Соблюдать уважение при общении')
            wait(3500)
            sampSendChat('Запрещено, вмешиваться в чужой разговор')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Сейчас я прочитаю лекцию о вреде наркотиков.')
            wait(3500)
            sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
            wait(3500)
            sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
            wait(3500)
            sampSendChat('Зачастую наркозависимые психологически нестабильны.')
            wait(3500)
            sampSendChat('В среде употребляющих наркотики выше риск заражения заболеваниями.')
            wait(3500)
            sampSendChat('На сегодняшний день наиболее распространены следующие виды наркотиков...')
            wait(3500)
            sampSendChat('...марихуана, кокаин, амфетамины, экстази, опиум.')
            wait(3500)
            sampSendChat('Каждый может и должен противостоять наркомании.')
            wait(3500)
            sampSendChat('Обретите уверенность в том, что вам лично наркотики не нужны.')
            wait(3500)
            sampSendChat('Лекция закончена. Спасибо за внимание.')
        end)
end

function RegisterHotkeysForSP()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/me включил мегафон')
            wait(3500)
            sampSendChat('/m Гражданин, остановите ваше транспортное средство и прижмитесь к обочине')
            wait(3500)
            sampSendChat('/m Заглушите двигатель, руки на руль и без резких движений')
            wait(3500)
            sampSendChat('/m В случае неподчинения я открою огонь по колесам...')
            wait(3500)
            sampSendChat('/m и вы будете занесены в федеральный розыск округа')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Здравствуйте, я '.. u8:decode(mainini.config.Rang) ..' МВД - '.. u8:decode(mainini.config.NickNameText))
            wait(3500)
            sampSendChat('/do Удостоверение в левом верхнем кармане.')
            wait(3500)
            sampSendChat('/me взял удостоверение из левого верхнего кармана')
            wait(3500)
            sampSendChat('/do На удостоверении написано "МВД РФ"')
            wait(3500)
            sampSendChat('/me открыл удостоверение на первой странице')
            wait(3500)
            sampSendChat('/me показывает человеку напротив в открытом виде')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/showbadge ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/do Протокол и ручка в руках.')
            wait(3500)
            sampSendChat('/me открыл протокол, после начал заполнять протокол')
            wait(3500)
            sampSendChat('/do Протокол составлен.')
            wait(3500)
            sampSendChat('/me вырвал листок из протокола')
            wait(3500)
            sampSendChat('/do На листке указано: "Штраф"')
            wait(3500)
            sampSendChat('/me выдал штраф нарушителю')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/ticket ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do Карманный Переносной Компьютер находится в правом кармане.')
            wait(3500)
            sampSendChat('/me достал из кармана КПК и зашел в базу данных МВД')
            wait(3500)
            sampSendChat('/me занёс подозреваемого в базу данных и убрал КПК в карман')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/su ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me повалил человека на землю, после чего прижал его спину коленом')
            wait(3500)
            sampSendChat('/do На поясе весят наручники.')
            wait(3500)
            sampSendChat('/me резким движением руки снял наручники с пояса')
            wait(3500)
            sampSendChat('/do Наручники в руках.')
            wait(3500)
            sampSendChat('/me заломал руки человеку')
            wait(3500)
            sampSendChat('/me надевает наручники человеку напротив')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/me поднял человека с земли')
            wait(3500)
            sampSendChat('/me заломал руку и повёл задержанного рядом за собой')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/me открыл дверь автомобиля')
            wait(3500)
            sampSendChat('/me пригнул голову задерживаему и посадил в автомобиль')
            wait(3500)
            sampSendChat('/do Задержанный в автомобиле.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/incar ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/do Ключи от камеры заключения находятся на специальном поясе.')
            wait(3500)
            sampSendChat('/me снял со специального пояса ключи от камеры заключенных')
            wait(3500)
            sampSendChat('/me вставил ключ от камеры в замочную скважину и открыл клетку')
            wait(3500)
            sampSendChat('/me схватил задержанного за рукав одежды и затолкал в камеру')
            wait(3500)
            sampSendChat('/do Процесс...')
            wait(3500)
            sampSendChat('/me захлопнул решетку, закрыл ее на замок и вытащил ключ из замка')
            wait(3500)
            sampSendChat('/me повесил комплект ключей на специальный пояс')
            wait(3500)
            sampSendChat('/do Ключи от камеры заключения находятся на специальном поясе.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/arrest ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me достал из кармана КПК')
            wait(3500)
            sampSendChat('/me Зашёл в базу данных розыскиваемых')
            wait(3500)
            sampSendChat('/me сверил все лица преступников с человеком стоящим напротив')
            wait(3500)
            sampSendChat('/do В базе данных розыскиваемых есть схожее лицо')
            wait(3500)
            sampSendChat('/me закрыл КПК')
            wait(3500)
            sampSendChat('/me положил КПК обратно в карман')
            wait(3500)
            sampSendChat('Мы вынуждены вас задержать, до выяснения всех обстоятельств')
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('Вы арестованы за нарушение законов области')
            wait(3500)
            sampSendChat('Вы имеете право хранить молчание - все что Вы скажите - будет использовано против Вас')
            wait(3500)
            sampSendChat('Вы имеете право на адвоката во время судебного заседания')
            wait(3500)
            sampSendChat('/todo Вам ясны Ваши права?*Пристально смотря на задержанного')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_F1 }, 1, true,
        function()
            sampSendChat('/do Дубинка на поясе.')
            wait(3500)
            sampSendChat('/me отцепил дубинку с пояса')
            wait(3500)
            sampSendChat('/do Дубинка в руке.')
            wait(3500)
            sampSendChat('/me нанес несколько показательных ударов')
            wait(3500)
            sampSendChat('/do Удары.')
            wait(3500)
            sampSendChat('/me повешал дубинку на пояс')
            wait(3500)
            sampSendChat('/do Дубинка на поясе.')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) ..'*на груди весит бейджик '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Вы пришли к нам на собеседование ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Хорошо.Давайте свои документы. А именно паспорт,лицензии и мед.карта.')
            wait(3500)
            sampSendChat('/b Всё по рп')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me проверив документы, передал человеку напротив')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me взял лицензии в руки ')
            wait(3500)
            sampSendChat('/do Лицензии в руках.')
            wait(3500)
            sampSendChat('/me пролиснув пакет лицензий, отдал владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял мед.книжку в руки ')
            wait(3500)
            sampSendChat('/do Мед.книжка в руках.')
            wait(3500)
            sampSendChat('/me пролиснув Мед.книгу, отдала владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Документы в полном порядке ')
            wait(3500)
            sampSendChat('Вы приняты на стажировку.')
            wait(3500)
            sampSendChat('/do Под столом лежит пакет с формой и рацией.')
            wait(3500)
            sampSendChat('/me достал пакет и передала человеку напротив')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Приветствую всех, сейчас я проведу лекцию на тему "Дресс-Код".')
            wait(3500)
            sampSendChat('Во-первых, форма сотрудника должна быть поглажена и чиста.')
            wait(3500)
            sampSendChat('Во-вторых, Вы не должны выглядеть как на маскараде.')
            wait(3500)
            sampSendChat('Никаких маек, коротких юбок и т.д')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Уважаемые сотрудники Центрального банка, прошу минуточку внимание!')
            wait(3500)
            sampSendChat('Хочу вам сказать, что транспорт с должности "Охранник" - Запрещено брать!')
            wait(3500)
            sampSendChat('С должности "Ст.Охранник" тоже запрещено, будьте внимательны.')
            wait(3500)
            sampSendChat('Если увидели нарушителя который катаетcя на транспорте, нарушая устав.')
            wait(3500)
            sampSendChat('Подавайте в жалобную книгу на сотрудника который нарушил устав.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Приветствую вас на лекции о субординации.')
            wait(3500)
            sampSendChat('Для начала расскажу, что такое субординация.')
            wait(3500)
            sampSendChat('Субординация - правила подчинения младших по званию к старшим по званию уважение, отношение к ним.')
            wait(3500)
            sampSendChat('То есть младшие сотрудники должны выполнять приказы начальства.')
            wait(3500)
            sampSendChat('Кто ослушается - сперва получит устное предупреждение, последующий раз - выговор.')
            wait(3500)
            sampSendChat('Вы должны с уважением относится к начальству и старшим по должности на "Вы".')
            wait(3500)
            sampSendChat('Не нарушайте правила и не нарушайте субординацию дабы не получить наказание.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Поговорим так же и о Этикете...')
            wait(3500)
            sampSendChat('При начале диалога вы должны по приветствовать собеседника...')
            wait(3500)
            sampSendChat('...а в конце диалога попрощаться')
            wait(3500)
            sampSendChat('Соблюдать уважение при общении')
            wait(3500)
            sampSendChat('Запрещено, вмешиваться в чужой разговор')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Сейчас я прочитаю лекцию о вреде наркотиков.')
            wait(3500)
            sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
            wait(3500)
            sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
            wait(3500)
            sampSendChat('Зачастую наркозависимые психологически нестабильны.')
            wait(3500)
            sampSendChat('В среде употребляющих наркотики выше риск заражения заболеваниями.')
            wait(3500)
            sampSendChat('На сегодняшний день наиболее распространены следующие виды наркотиков...')
            wait(3500)
            sampSendChat('...марихуана, кокаин, амфетамины, экстази, опиум.')
            wait(3500)
            sampSendChat('Каждый может и должен противостоять наркомании.')
            wait(3500)
            sampSendChat('Обретите уверенность в том, что вам лично наркотики не нужны.')
            wait(3500)
            sampSendChat('Лекция закончена. Спасибо за внимание.')
        end)
end

function RegisterHotkeysForRCR()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Здравствуйте, дорогие радиослушатели')
            wait(5000)
            sampSendChat('/news С вами я *Должность* радиостанции г. "Город", Имя Фамилия')
            wait(5000)
            sampSendChat('/news И сегодня у нас эфир о Погоде')
            wait(5000)
            sampSendChat('/news В городе Лыткарино сегодня Солнечно без осадков плюс 25')
            wait(5000)
            sampSendChat('/news Говорят это одна из отличный погод в этом году')
            wait(5000)
            sampSendChat('/news В городе Арзамас сегодня плюс 17 и Облачно,ожидается дождь вечером')
            wait(5000)
            sampSendChat('/news Советуем не выходить из дома в позднее время')
            wait(5000)
            sampSendChat('/news В пгт.Батырево Солнечно плюс 25 до самой ночи')
            wait(5000)
            sampSendChat('/news А на этом прогноз погоды окончен')
            wait(4000)
            sampSendChat('/news Спасибо, что были с нами')
            wait(4000)
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Приветствую, дорогие радиослушатели, в эфире Радиостанция '.. u8:decode(mainini.config.Nameorg) ..'.')
            wait(5000)
            sampSendChat('/news Сегодня с вами я - '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news Сейчас я проведу эфир на тему Ваши приветы и поздравления.')
            wait(5000)
            sampSendChat('/news Сейчас я объясню правила и мы начнем.')
            wait(5000)
            sampSendChat('/news Суть такова, Вы должны присылать свои приветы и поздравления.')
            wait(5000)
            sampSendChat('/news На номер: '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news А я их буду озвучивать в прямом эфире.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/news На этом мы заканчиваем наш эфир.')
            wait(5000)
            sampSendChat('/news С вами был я - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Здравствуйте, дорогие радиослушатели')
            wait(5000)
            sampSendChat('/news С вами я - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news И сегодня у нас эфир о Погоде')
            wait(5000)
            sampSendChat('/news В городе Лыткарино сегодня Солнечно без осадков плюс 25')
            wait(5000)
            sampSendChat('/news Говорят это одна из отличный погод в этом году')
            wait(5000)
            sampSendChat('/news В городе Арзамас сегодня плюс 17 и Облачно,ожидается дождь вечером')
            wait(5000)
            sampSendChat('/news Советуем не выходить из дома в позднее время')
            wait(5000)
            sampSendChat('/news В пгт.Батырево Солнечно плюс 25 до самой ночи')
            wait(5000)
            sampSendChat('/news А на этом прогноз погоды окончен')
            wait(4000)
            sampSendChat('/news Спасибо, что были с нами')
            wait(4000)
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Приветствую, дорогие радиослушатели, в эфире Радиостанция '.. u8:decode(mainini.config.Nameorg) ..'.')
            wait(5000)
            sampSendChat('/news С вами я - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news Сейчас я проведу эфир на тему Ваши приветы и поздравления.')
            wait(5000)
            sampSendChat('/news Сейчас я объясню правила и мы начнем.')
            wait(5000)
            sampSendChat('/news Суть такова, Вы должны присылать свои приветы и поздравления.')
            wait(5000)
            sampSendChat('/news На номер: '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news А я их буду озвучивать в прямом эфире.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('news На этом мы заканчиваем наш эфир.')
            wait(5000)
            sampSendChat('/news С вами был я - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/news С вами был я - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news Здравствуйте, дорогие радиослушатели ')
            wait(5000)
            sampSendChat('/news С вами я - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news И сегодня у нас викторина Столицы ')
            wait(5000)
            sampSendChat('/news Я загадываю столицы. Например:Пекин, а Вы должны сказать какой страны эта столица...')
            wait(5000)
            sampSendChat('/news Страна будет Китай.')
            wait(5000)
            sampSendChat('/news Каждая угаданная страна - 1 балл на счет ответившего.')
            wait(5000)
            sampSendChat('/news А играем мы до 5-ти баллов.')
            wait(5000)
            sampSendChat('/news Но для начала нам нужны спонсоры.')
            wait(5000)
            sampSendChat('/news Для того чтобы быть спонсором можно перевести деньги на банк счет или передать в руки.')
            wait(5000)
            sampSendChat('/news Свои ответы отправляем на номер '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news Даю Вам 1 минуту чтобы добавить Меня в контакты')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/news Поздравим его.')
            wait(4000)
            sampSendChat('/news Чтобы забрать приз - подойдите к офису Радиостанции.')
            wait(4000)
            sampSendChat('/news А на этом я заканчиваю викторину.')
            wait(4000)
            sampSendChat('/news Спасибо, что были с нами.')
            wait(4000)
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
            wait(5000)
            sampSendChat('/news Здравствуйте, дорогие радиослушатели ')
            wait(5000)
            sampSendChat('/news С вами я - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news И сегодня у нас викторина Математик')
            wait(5000)
            sampSendChat('/news Я загадываю пример. Например:5 + 5, а Вы должны сказать какой ответ..')
            wait(5000)
            sampSendChat('/news Ответ будет 10.')
            wait(5000)
            sampSendChat('/news Каждый угаданный пример - 1 балл на счет ответившего.')
            wait(5000)
            sampSendChat('/news А играем мы до 5-ти баллов.')
            wait(5000)
            sampSendChat('/news Но для начала нам нужны спонсоры.')
            wait(5000)
            sampSendChat('/news Для того чтобы быть спонсором можно перевести деньги на банк счет или передать в руки.')
            wait(5000)
            sampSendChat('/news Свои ответы отправляем на номер '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news Даю Вам 1 минуту чтобы добавить Меня в контакты')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/news Поздравим его.')
            wait(4000)
            sampSendChat('/news Чтобы забрать приз - подойдите к офису Радиостанции.')
            wait(4000)
            sampSendChat('/news А на этом я заканчиваю викторину.')
            wait(4000)
            sampSendChat('/news Спасибо, что были с нами.')
            wait(4000)
            sampSendChat('/news /news ...::: Музыкальная заставка « '.. u8:decode(mainini.config.Nameorg) ..' »:::...')
        end)


    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo Здравствуйте меня зовут '.. u8:decode(mainini.config.NickNameText) ..'*на груди весит бейджик '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('Вы пришли к нам на собеседование ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Хорошо.Давайте свои документы. А именно паспорт,лицензии и мед.карта.')
            wait(3500)
            sampSendChat('/b Всё по рп')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me взял паспорт')
            wait(3500)
            sampSendChat('/do Паспорт в руках.')
            wait(3500)
            sampSendChat('/me проверив документы, передал человеку напротив')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me взял лицензии в руки ')
            wait(3500)
            sampSendChat('/do Лицензии в руках.')
            wait(3500)
            sampSendChat('/me пролиснув пакет лицензий, отдал владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me взял мед.книжку в руки ')
            wait(3500)
            sampSendChat('/do Мед.книжка в руках.')
            wait(3500)
            sampSendChat('/me пролиснув Мед.книгу, отдала владельцу')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('Документы в полном порядке ')
            wait(3500)
            sampSendChat('Вы приняты на стажировку.')
            wait(3500)
            sampSendChat('/do Под столом лежит пакет с формой и рацией.')
            wait(3500)
            sampSendChat('/me достал пакет и передала человеку напротив')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('Приветствую всех, сейчас я проведу лекцию на тему "Дресс-Код".')
            wait(3500)
            sampSendChat('Во-первых, форма сотрудника должна быть поглажена и чиста.')
            wait(3500)
            sampSendChat('Во-вторых, Вы не должны выглядеть как на маскараде.')
            wait(3500)
            sampSendChat('Никаких маек, коротких юбок и т.д')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('Уважаемые сотрудники Центрального банка, прошу минуточку внимание!')
            wait(3500)
            sampSendChat('Хочу вам сказать, что транспорт с должности "Охранник" - Запрещено брать!')
            wait(3500)
            sampSendChat('С должности "Ст.Охранник" тоже запрещено, будьте внимательны.')
            wait(3500)
            sampSendChat('Если увидели нарушителя который катаетcя на транспорте, нарушая устав.')
            wait(3500)
            sampSendChat('Подавайте в жалобную книгу на сотрудника который нарушил устав.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('Приветствую вас на лекции о субординации.')
            wait(3500)
            sampSendChat('Для начала расскажу, что такое субординация.')
            wait(3500)
            sampSendChat('Субординация - правила подчинения младших по званию к старшим по званию уважение, отношение к ним.')
            wait(3500)
            sampSendChat('То есть младшие сотрудники должны выполнять приказы начальства.')
            wait(3500)
            sampSendChat('Кто ослушается - сперва получит устное предупреждение, последующий раз - выговор.')
            wait(3500)
            sampSendChat('Вы должны с уважением относится к начальству и старшим по должности на "Вы".')
            wait(3500)
            sampSendChat('Не нарушайте правила и не нарушайте субординацию дабы не получить наказание.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('Поговорим так же и о Этикете...')
            wait(3500)
            sampSendChat('При начале диалога вы должны по приветствовать собеседника...')
            wait(3500)
            sampSendChat('...а в конце диалога попрощаться')
            wait(3500)
            sampSendChat('Соблюдать уважение при общении')
            wait(3500)
            sampSendChat('Запрещено, вмешиваться в чужой разговор')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('Сейчас я прочитаю лекцию о вреде наркотиков.')
            wait(3500)
            sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
            wait(3500)
            sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
            wait(3500)
            sampSendChat('Зачастую наркозависимые психологически нестабильны.')
            wait(3500)
            sampSendChat('В среде употребляющих наркотики выше риск заражения заболеваниями.')
            wait(3500)
            sampSendChat('На сегодняшний день наиболее распространены следующие виды наркотиков...')
            wait(3500)
            sampSendChat('...марихуана, кокаин, амфетамины, экстази, опиум.')
            wait(3500)
            sampSendChat('Каждый может и должен противостоять наркомании.')
            wait(3500)
            sampSendChat('Обретите уверенность в том, что вам лично наркотики не нужны.')
            wait(3500)
            sampSendChat('Лекция закончена. Спасибо за внимание.')
        end)

end

update_state = false

local script_vers = 11
local script_vers_text = "11.0"

local update_url = "https://raw.githubusercontent.com/DenisMalahovskiyOLSHER/GovernmentBinder/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "https://github.com/thechampguess/scripts/blob/master/autoupdate_lesson_16.luac?raw=true" -- тут свою ссылку
local script_path = thisScript().path


function main()
    while not isSampAvailable() do wait(100) end
    --if '185.169.134.108' ~= nil and '185.169.134.108' ~= sampGetCurrentServerAddress() then 
    --    sampAddChatMessage('[Government AHK] {d5dedd} Вы зашли не на основной сервер. Скрипт завершил работу', 0xfe4749)
    --    thisScript():unload()
    --else
        sampAddChatMessage("[Government AHK] {d5dedd}Скрипт был успешно загружен.", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}Автор: {fe4749}Denis_Richard", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}Чтобы открыть меню нажмите: {fe4749}F3.", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}Версия скрипта: {fe4749}v."..thisScript().version, 0xfe4749)
    --end

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("Скрипт успешно обновлен!", -1)
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
        if imgui.Button(u8"Главная", imgui.ImVec2(135, 35)) then
            menu = 1
        end
        imgui.SameLine()
        if imgui.Button(u8"Выбор организации", imgui.ImVec2(135, 35)) then
            menu = 2
        end
        --imgui.SameLine()
        --if imgui.Button(u8"Настройки", imgui.ImVec2(135, 35)) then
        --    menu = 3
        --end
        imgui.SameLine()
        if imgui.Button(u8"Информация", imgui.ImVec2(135, 35)) then
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
                imgui.Text(fa.ICON_USER_CIRCLE ..u8"    Никнейм: ".. sampGetPlayerNickname(id))
                imgui.Text(fa.ICON_ADDRESS_BOOK ..u8"    ID: ".. id)
                imgui.Text(fa.ICON_WIFI ..u8"   Пинг: ".. sampGetPlayerPing(id))
                imgui.Text(fa.ICON_HEARTBEAT ..u8"    Здоровье: ".. sampGetPlayerHealth(id))
                imgui.Text(fa.ICON_SHIELD ..u8"     Броня: ".. sampGetPlayerArmor(id))
                imgui.Text(fa.ICON_SERVER ..u8"     Сервер: Rodina RP 04")
            imgui.EndChild()
            imgui.NewLine()
            imgui.NewLine()
            imgui.NewLine()
            imgui.NewLine()
            imgui.Button(u8"        Версия: 4.0 \nАвтор: Denis_Richard", imgui.ImVec2(230, 45))
        imgui.EndChild()
        imgui.NextColumn()
        imgui.SetColumnWidth(-1, 930)
        imgui.BeginChild("##zagolovok", imgui.ImVec2(930, 525), false, imgui.WindowFlags.NoScrollbar)
            if not menu then 
                menu = 1 
            end
            if menu == 1 then
                imgui.CenterText(u8"Главная")
                imgui.NewLine()
                if imgui.InputText(u8'NickName на русском', NickNameText) then
                    mainini.config.NickNameText = NickNameText.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Название организации', Nameorg) then
                    mainini.config.Nameorg = Nameorg.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Тег организации', Teg) then
                    mainini.config.Teg = Teg.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Название ранга', Rang) then
                    mainini.config.Rang = Rang.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Строка /gov №1 без тега', GOV1) then
                    mainini.config.GOV1 = GOV1.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Строка /gov №2 без тега', GOV2) then
                    mainini.config.GOV2 = GOV2.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Строка /gov №3 без тега', GOV3) then
                    mainini.config.GOV3 = GOV3.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Номер телефона', Number) then
                    mainini.config.Number = Number.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Номер поста', Post) then
                    mainini.config.Post = Post.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'Время отправки /gov (H:M:S)', TimeGovka) then
                    mainini.config.TimeGovka = TimeGovka.v
                    inicfg.save(mainini, savee)
                end
            elseif menu == 2 then
                imgui.CenterText(u8"Выбор организации")
                imgui.NewLine()
                if imgui.Button(u8'Пра-во', imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForGovernment()
                    sampAddChatMessage("[Government Binder] {d5dedd}Выбрана организация - {fe4749}Правительство.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"Банк", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForBank()
                    sampAddChatMessage("[Government Binder] {d5dedd}Выбрана организация - {fe4749}Банк.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"МВД", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForSP()
                    sampAddChatMessage("[Government Binder] {d5dedd}Выбрана организация - {fe4749}МВД.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"РЦ", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForRCR()
                    sampAddChatMessage("[Government Binder] {d5dedd}Выбрана организация - {fe4749}Радиостанция.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"ГКБ", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForGKB()
                    sampAddChatMessage("[Government Binder] {d5dedd}Выбрана организация - {fe4749}ГКБ.", 0xfe4749)
                end
                if imgui.Button(u8"Армия", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForArmy()
                    sampAddChatMessage("[Government Binder] {d5dedd}Выбрана организация - {fe4749}Армия.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"ФСИН", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForFSIN()
                    sampAddChatMessage("[Government Binder] {d5dedd}Выбрана организация - {fe4749}ФСИН.", 0xfe4749)
                end
            elseif menu == 3 then
                imgui.CenterText(u8"Информация")
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
    sampSendChat("/d [".. u8:decode(mainini.config.Teg) .."] - [Всем] Занимаю государственную Волну новостей.")
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV1))
    wait(3500)
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV2))
    wait(3500)
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV3))
    sampSendChat("/d [".. u8:decode(mainini.config.Teg) .."] - [".. u8:decode(mainini.config.Teg) .."] Оcвобождаю государственную Волну новостей.")
    wait(3500)
    sampSendChat("/rb [Government Binder] Государственная волна новостей была отправлена: ".. u8:decode(mainini.config.NickNameText))
end
function onScriptTerminate(script, quitGame)
    if script == thisScript() then
        inicfg.save(mainini, savee)
        sampAddChatMessage('[Government Binder]{d5dedd} Скрипт аварийно завершил работу и сохранил настройки', 0xfe4749)
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