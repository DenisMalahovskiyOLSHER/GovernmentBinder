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
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) .."*�� ����� ����� ������� ".. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('��� ���� ���� �������?')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/do ������� �� �����.')
            wait(3500)
            sampSendChat('/todo ����� ��� ����� ���� ��������� ��� � ��� ������ �� �����*������ �������')
            wait(3500)
            sampSendChat('/do ������� ����� � �����.')
            wait(3500)
            sampSendChat('/me ����� ������� � ����')
            wait(3500)
            sampSendChat('/do ������� � �����.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ������������ �� ���������� � �������� �������� ��� ����.')
            wait(3500)
            sampSendChat('/me ������ ����� ���������� �� ����, ������� ��� �� �����.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/expel ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ������ ������� �� ����')
            wait(3500)
            sampSendChat('/do ������� �� �����.')
            end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me ����� � ���� ������ ������������ ����� ')
            wait(3500)
            sampSendChat('/me ����� ������� ���������� � ������ ������ ')
            wait(3500)
            sampSendChat('/do ������ �������. ')
            wait(3500)
            sampSendChat('/me ���� ������ "��" ')
            wait(3500)
            sampSendChat('/do ������ "��" � �����. ')
            wait(3500)
            sampSendChat('/me �������� ������ "��" ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('������������, � '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'. �� ������� ������������ ���-��� �� �����?')
            wait(3500)
            sampSendChat('������, ��������� ��� ��� �������.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/me ���� ������� ')
            wait(3500)
            sampSendChat('/do ������� � �����. ')
            wait(3500)
            sampSendChat('������, ������ ����� ���������������. ')
            wait(3500)
            sampSendChat('/me ������ �� ���� ������ �������� ������������ ����� ��� � ������� ���������� ')
            wait(3500)
            sampSendChat('/do ��������� �������� � ���� ������.')
            wait(3500)
            sampSendChat('/me ����� � ���� ������ ����� ������ ')
            wait(3500)
            sampSendChat('/me ����������� ��� ��� �������� ���������� ')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('������������, � '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'. �� ������� �������� ������?')
            wait(3500)
            sampSendChat('������, ��������� ��� ��� �������.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('������, ������ ����� ��������� ��������� �� ������.')
            wait(3500)
            sampSendChat('/me ������ �� ���� ������ ������������ ����� ��� � ������� ����������')
            wait(3500)
            sampSendChat('/do ��������� ���������� � ���� ������.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/bankmenu ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('/r �����������: '.. u8:decode(mainini.config.NickNameText) ..' | ����: �'.. u8:decode(mainini.config.Post) ..' | ���������: ����������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) ..'*�� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('�� ������ � ��� �� ������������� ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������.������� ���� ���������. � ������ �������,�������� � ���.�����.')
            wait(3500)
            sampSendChat('/b �� �� ��')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ���������, ������� �������� ��������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ���� �������� � ���� ')
            wait(3500)
            sampSendChat('/do �������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ��������, ����� ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� ���.������ � ���� ')
            wait(3500)
            sampSendChat('/do ���.������ � �����.')
            wait(3500)
            sampSendChat('/me ��������� ���.�����, ������ ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('��������� � ������ ������� ')
            wait(3500)
            sampSendChat('�� ������� �� ����������.')
            wait(3500)
            sampSendChat('/do ��� ������ ����� ����� � ������ � ������.')
            wait(3500)
            sampSendChat('/me ������ ����� � �������� �������� ��������')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('����������� ����, ������ � ������� ������ �� ���� "�����-���".')
            wait(3500)
            sampSendChat('��-������, ����� ���������� ������ ���� ��������� � �����.')
            wait(3500)
            sampSendChat('��-������, �� �� ������ ��������� ��� �� ���������.')
            wait(3500)
            sampSendChat('������� ����, �������� ���� � �.�')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('��������� ���������� ������������ �����, ����� ��������� ��������!')
            wait(3500)
            sampSendChat('���� ��� �������, ��� ��������� � ��������� "��������" - ��������� �����!')
            wait(3500)
            sampSendChat('� ��������� "��.��������" ���� ���������, ������ �����������.')
            wait(3500)
            sampSendChat('���� ������� ���������� ������� ������c� �� ����������, ������� �����.')
            wait(3500)
            sampSendChat('��������� � �������� ����� �� ���������� ������� ������� �����.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('����������� ��� �� ������ � ������������.')
            wait(3500)
            sampSendChat('��� ������ ��������, ��� ����� ������������.')
            wait(3500)
            sampSendChat('������������ - ������� ���������� ������� �� ������ � ������� �� ������ ��������, ��������� � ���.')
            wait(3500)
            sampSendChat('�� ���� ������� ���������� ������ ��������� ������� ����������.')
            wait(3500)
            sampSendChat('��� ���������� - ������ ������� ������ ��������������, ����������� ��� - �������.')
            wait(3500)
            sampSendChat('�� ������ � ��������� ��������� � ���������� � ������� �� ��������� �� "��".')
            wait(3500)
            sampSendChat('�� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('��������� ��� �� � � �������...')
            wait(3500)
            sampSendChat('��� ������ ������� �� ������ �� �������������� �����������...')
            wait(3500)
            sampSendChat('...� � ����� ������� �����������')
            wait(3500)
            sampSendChat('��������� �������� ��� �������')
            wait(3500)
            sampSendChat('���������, ����������� � ����� ��������')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('������ � �������� ������ � ����� ����������.')
            wait(3500)
            sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
            wait(3500)
            sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
            wait(3500)
            sampSendChat('�������� �������������� �������������� �����������.')
            wait(3500)
            sampSendChat('� ����� ������������� ��������� ���� ���� ��������� �������������.')
            wait(3500)
            sampSendChat('�� ����������� ���� �������� �������������� ��������� ���� ����������...')
            wait(3500)
            sampSendChat('...���������, ������, ����������, �������, �����.')
            wait(3500)
            sampSendChat('������ ����� � ������ ������������� ����������.')
            wait(3500)
            sampSendChat('�������� ����������� � ���, ��� ��� ����� ��������� �� �����.')
            wait(3500)
            sampSendChat('������ ���������. ������� �� ��������.')
        end)
end

function RegisterHotkeysForGovernment()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function ()       
            sampSendChat('������������, � '.. u8:decode(mainini.config.Rang) ..' - '.. u8:decode(mainini.config.NickNameText) ..'.')
            wait(3500)
            sampSendChat('/do �� ����� �������: '.. u8:decode(mainini.config.Rang) ..'.')
            wait(3500)
            sampSendChat('��� ���� ��� ������? ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function ()
            sampSendChat('/do ������� ����� �� ����� � ����������� ���������.')
            wait(3500)
            sampSendChat('/me ������ ��������� ������ ���� ����(�) ������� � �����')
            wait(3500)
            sampSendChat('/do ������� ��������� � ������ ����.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function ()
            sampSendChat('/todo ����� ��� ����� ���� �������� ��� � ��� ������ �� ������*������ �������')
            wait(3500)
            sampSendChat('/do ������� ����� � �����.')
            wait(3500)
            sampSendChat('/me ����� ������� � ������ ����')
            wait(3500)
            sampSendChat('/do ������� � ������ ����.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function ()
            sampSendChat('/me ������������ �� ���������� � �������� �������� ��� ���� ')
            wait(3500)
            sampSendChat('/me ������ ����� ���������� �� ����, ������� ��� �� ����� ')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/expel ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function ()
            sampSendChat('/do ������� ��������� � ������ ����.')
            wait(3500)
            sampSendChat('/me ������� ��������� ������ ���� �������(�) ������� �� ���� � ����������� ���������')
            wait(3500)
            sampSendChat('/do ������� ��������� �� ����� � ����������� ���������.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function ()
            sampSendChat('/do ������������� ��������� � ������ ���������� ������� �������.')
            wait(3500)
            sampSendChat('/me ������� ��������� ����� ����� ��������� ������')
            wait(3500)
            sampSendChat('/me ������ ������ ����� �� ����������� ������� ������� �������������')
            wait(3500)
            sampSendChat('/do ������������� � ������ ����.')
            wait(3500)
            sampSendChat('/me ������ �������������')
            wait(3500)
            sampSendChat('/do ������������� � �������� ����.')
            wait(3500)
            sampSendChat('/do � ������������� ��������: '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/showpass ")
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) ..'*�� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('�� ������ � ��� �� ������������� ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������.������� ���� ���������. � ������ �������,�������� � ���.�����.')
            wait(3500)
            sampSendChat('/b �� �� ��')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ���������, ������� �������� ��������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ���� �������� � ���� ')
            wait(3500)
            sampSendChat('/do �������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ��������, ����� ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� ���.������ � ���� ')
            wait(3500)
            sampSendChat('/do ���.������ � �����.')
            wait(3500)
            sampSendChat('/me ��������� ���.�����, ������ ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('��������� � ������ ������� ')
            wait(3500)
            sampSendChat('�� ������� �� ����������.')
            wait(3500)
            sampSendChat('/do ��� ������ ����� ����� � ������ � ������.')
            wait(3500)
            sampSendChat('/me ������ ����� � �������� �������� ��������')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('����������� ����, ������ � ������� ������ �� ���� "�����-���".')
            wait(3500)
            sampSendChat('��-������, ����� ���������� ������ ���� ��������� � �����.')
            wait(3500)
            sampSendChat('��-������, �� �� ������ ��������� ��� �� ���������.')
            wait(3500)
            sampSendChat('������� ����, �������� ���� � �.�')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('��������� ���������� ������������ �����, ����� ��������� ��������!')
            wait(3500)
            sampSendChat('���� ��� �������, ��� ��������� � ��������� "��������" - ��������� �����!')
            wait(3500)
            sampSendChat('� ��������� "��.��������" ���� ���������, ������ �����������.')
            wait(3500)
            sampSendChat('���� ������� ���������� ������� ������c� �� ����������, ������� �����.')
            wait(3500)
            sampSendChat('��������� � �������� ����� �� ���������� ������� ������� �����.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('����������� ��� �� ������ � ������������.')
            wait(3500)
            sampSendChat('��� ������ ��������, ��� ����� ������������.')
            wait(3500)
            sampSendChat('������������ - ������� ���������� ������� �� ������ � ������� �� ������ ��������, ��������� � ���.')
            wait(3500)
            sampSendChat('�� ���� ������� ���������� ������ ��������� ������� ����������.')
            wait(3500)
            sampSendChat('��� ���������� - ������ ������� ������ ��������������, ����������� ��� - �������.')
            wait(3500)
            sampSendChat('�� ������ � ��������� ��������� � ���������� � ������� �� ��������� �� "��".')
            wait(3500)
            sampSendChat('�� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('��������� ��� �� � � �������...')
            wait(3500)
            sampSendChat('��� ������ ������� �� ������ �� �������������� �����������...')
            wait(3500)
            sampSendChat('...� � ����� ������� �����������')
            wait(3500)
            sampSendChat('��������� �������� ��� �������')
            wait(3500)
            sampSendChat('���������, ����������� � ����� ��������')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('������ � �������� ������ � ����� ����������.')
            wait(3500)
            sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
            wait(3500)
            sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
            wait(3500)
            sampSendChat('�������� �������������� �������������� �����������.')
            wait(3500)
            sampSendChat('� ����� ������������� ��������� ���� ���� ��������� �������������.')
            wait(3500)
            sampSendChat('�� ����������� ���� �������� �������������� ��������� ���� ����������...')
            wait(3500)
            sampSendChat('...���������, ������, ����������, �������, �����.')
            wait(3500)
            sampSendChat('������ ����� � ������ ������������� ����������.')
            wait(3500)
            sampSendChat('�������� ����������� � ���, ��� ��� ����� ��������� �� �����.')
            wait(3500)
            sampSendChat('������ ���������. ������� �� ��������.')
        end)
end

function RegisterHotkeysForArmy()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function ()
            sampSendChat('������� �����. � '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText) ..'.')
            sampSendChat('/do �� ������ ������ '.. u8:decode(mainini.config.Rang) ..'.')
            sampSendChat('/do ������������� � �������.')
            sampSendChat('/me ���� ������������� � �������, ����� ������� ���������� ��������.')
            sampSendChat('/do ������� �������������.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/showpass ")
            sampSendChat('��������� ������, � ����� ����� �� �������� �� ���������� ����������.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function ()
            sampSendChat('/me �������� ����� ���� � ���� ���������')
            sampSendChat('/do ��������� � ����� ����.')
            sampSendChat('/me ������ ��������� � ����� �������')
            sampSendChat('/me ������ ���������, ����� ������ ���')
            sampSendChat('/me ������� ��������� ���������� ��������')
            sampSendChat('/do ��������� ��������.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function ()
            sampSendChat('/s �� ��� �� 10 ������ ����� � ����� ��� ��� ������������ � �� ������� �����.') 
            sampSendChat('/s � ��� 5 ������.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function ()
            sampSendChat('/me ������ ������ ��-�� �����')
            sampSendChat('/do ������ � �����.')
            sampSendChat('/me ���������� ������')
            sampSendChat('/do ������ � ������ ����������.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function ()
            sampSendChat('/me �������� ������ �� ��������������')
            sampSendChat('/do ������ �� ��������������.')
            sampSendChat('/me ����� ������ �� �����')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function ()
            sampSendChat('������� '.. u8:decode(mainini.config.NickNameText) ..' � �������� ��-47 ���������!')
            sampSendChat('/me ������� �������,����� ���� � �������������� � �����������')
            sampSendChat('/me �������� ������� �� ����������� �������� � ����� �� �����')
            sampSendChat('/me ������� ������ � �������� �������������,����� ������� �������')
            sampSendChat('/me ���� ������ ��������� ������� � ������� ���������� ��������')
            sampSendChat('/me ������� ������ � ��������� ����� � ������� �� �� ���� �����')
            sampSendChat('/me ������� ������� ������')
            sampSendChat('������� '.. u8:decode(mainini.config.NickNameText) ..' �������� ��������!.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function ()
            sampSendChat('������� '.. u8:decode(mainini.config.NickNameText) ..' ������ ��-47 ���������.')
            sampSendChat('/me ����������� ������ � ��������� ����,����� ������� �� � �������')
            sampSendChat('/me ����������� ���������� ��������')
            sampSendChat('/me ������ ��������� ������� ������� ��������� �������')
            sampSendChat('/me �������� ������� �� ����������� �������� � ������� ������')
            sampSendChat('/me �������� �������������')
            sampSendChat('/me ����� �� ��������� ������')
            sampSendChat('/me �������� ������� �� ��������������.')
            sampSendChat('������� '.. u8:decode(mainini.config.NickNameText) ..' ������ ��-47 ��������!.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function ()
            sampSendChat('/me ���� � ���� ����� � ��������.')
            sampSendChat('/me ������ �����.')
            sampSendChat('�, ������� '.. u8:decode(mainini.config.NickNameText) ..', ������������ �������� �� �������� ����� ������.')
            sampSendChat('������� ����� ��������� ����������� ���������� ���������')
            sampSendChat('������� ������ ��������� ���������� �������� �������.')
            sampSendChat('������� ������ ��������� ������� ���������� � �����������')
            sampSendChat('������� �������� ��������� �������� ����.')
            sampSendChat('������� ����������� �������� ������� � �������������.')
            sampSendChat('������� '.. u8:decode(mainini.config.NickNameText) ..' ������� �������.')
            sampSendChat('/me ������ �����')
        end)
    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) ..'*�� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('�� ������ � ��� �� ������������� ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������.������� ���� ���������. � ������ �������,�������� � ���.�����.')
            wait(3500)
            sampSendChat('/b �� �� ��')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ���������, ������� �������� ��������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ���� �������� � ���� ')
            wait(3500)
            sampSendChat('/do �������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ��������, ����� ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� ���.������ � ���� ')
            wait(3500)
            sampSendChat('/do ���.������ � �����.')
            wait(3500)
            sampSendChat('/me ��������� ���.�����, ������ ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('��������� � ������ ������� ')
            wait(3500)
            sampSendChat('�� ������� �� ����������.')
            wait(3500)
            sampSendChat('/do ��� ������ ����� ����� � ������ � ������.')
            wait(3500)
            sampSendChat('/me ������ ����� � �������� �������� ��������')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('����������� ����, ������ � ������� ������ �� ���� "�����-���".')
            wait(3500)
            sampSendChat('��-������, ����� ���������� ������ ���� ��������� � �����.')
            wait(3500)
            sampSendChat('��-������, �� �� ������ ��������� ��� �� ���������.')
            wait(3500)
            sampSendChat('������� ����, �������� ���� � �.�')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('��������� ���������� ������������ �����, ����� ��������� ��������!')
            wait(3500)
            sampSendChat('���� ��� �������, ��� ��������� � ��������� "��������" - ��������� �����!')
            wait(3500)
            sampSendChat('� ��������� "��.��������" ���� ���������, ������ �����������.')
            wait(3500)
            sampSendChat('���� ������� ���������� ������� ������c� �� ����������, ������� �����.')
            wait(3500)
            sampSendChat('��������� � �������� ����� �� ���������� ������� ������� �����.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('����������� ��� �� ������ � ������������.')
            wait(3500)
            sampSendChat('��� ������ ��������, ��� ����� ������������.')
            wait(3500)
            sampSendChat('������������ - ������� ���������� ������� �� ������ � ������� �� ������ ��������, ��������� � ���.')
            wait(3500)
            sampSendChat('�� ���� ������� ���������� ������ ��������� ������� ����������.')
            wait(3500)
            sampSendChat('��� ���������� - ������ ������� ������ ��������������, ����������� ��� - �������.')
            wait(3500)
            sampSendChat('�� ������ � ��������� ��������� � ���������� � ������� �� ��������� �� "��".')
            wait(3500)
            sampSendChat('�� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('��������� ��� �� � � �������...')
            wait(3500)
            sampSendChat('��� ������ ������� �� ������ �� �������������� �����������...')
            wait(3500)
            sampSendChat('...� � ����� ������� �����������')
            wait(3500)
            sampSendChat('��������� �������� ��� �������')
            wait(3500)
            sampSendChat('���������, ����������� � ����� ��������')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('������ � �������� ������ � ����� ����������.')
            wait(3500)
            sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
            wait(3500)
            sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
            wait(3500)
            sampSendChat('�������� �������������� �������������� �����������.')
            wait(3500)
            sampSendChat('� ����� ������������� ��������� ���� ���� ��������� �������������.')
            wait(3500)
            sampSendChat('�� ����������� ���� �������� �������������� ��������� ���� ����������...')
            wait(3500)
            sampSendChat('...���������, ������, ����������, �������, �����.')
            wait(3500)
            sampSendChat('������ ����� � ������ ������������� ����������.')
            wait(3500)
            sampSendChat('�������� ����������� � ���, ��� ��� ����� ��������� �� �����.')
            wait(3500)
            sampSendChat('������ ���������. ������� �� ��������.')
        end)
end

function RegisterHotkeysForGKB()
    rkeys.registerHotKey({ VK_F1 }, 1, true,
        function()
            sampSendChat('/do � ������ ���� ��������� ����� � �������� "������ ����������"..')
            wait(3500)
            sampSendChat('/me ������� ������ ���� �� ������, ����� �� ������ � ������� �����')
            wait(3500)
            sampSendChat('������� ��������� ������, ���������, ������� � �������� � ����� ������ � ��������...')
            wait(3500)
            sampSendChat('���� �� � ���������, ��������� ������, �������������� ���� ����� � ����� ���������.')
            wait(3500)
            sampSendChat('� �������� ����� ������� � �� ������ ��������� � ����� ������ � ���� ����������, �������������...')
            wait(3500)
            sampSendChat('�� ���������� ������� ����� � ����������������.')
            wait(3500)
            sampSendChat('� �� ��� ������ ��������� � ���� ������������ �������� � �� ������ ���� ��� ��������� �������.')
            wait(3500)
            sampSendChat('� �� � ���� ������ �� ���� ������ ������� � ���������� �������� ��������.')
            wait(3500)
            sampSendChat('����������� ��� �����, ������������ ���� �����. � ����� �� ��� � �� �����, � ����� ���� ��� ������ ��������.')
            wait(3500)
            sampSendChat('/me ������� ����, ����� �� ���� � ������ �����')
            wait(3500)
            sampSendChat('/do ����� � �������� "������ ����������" ��������� � ������ ����')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('������������, � '.. u8:decode(mainini.config.Rang) ..' - '.. u8:decode(mainini.config.NickNameText))
            wait(3500)
            sampSendChat('/do �� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('���� �� � ��� ���-�� ������?')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do ���. ����� �� �����.')
            wait(3500)
            sampSendChat('/me ���� ���.�����')
            wait(3500)
            sampSendChat('/me ������ ���.�����')
            wait(3500)
            sampSendChat('/me ������ ������ ��������')
            wait(3500)
            sampSendChat('/do �������� � ����.')
            wait(3500)
            sampSendChat('/me ������� �������� ��������')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/heal ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('���. ����� �������� ��� � 2500 ������.')
            wait(3500)
            sampSendChat('/b /pay ID 2500')
            wait(3500)
            sampSendChat('����� ������, ��� ����� ������ ���. �����.')
            wait(3500)
            sampSendChat('/me ������ ����� ������ ���. ���� � ����� ��������� ����� ���. �����')
            wait(3500)
            sampSendChat('/do ���. ����� ������. ������: ��������� ������.')
            wait(3500)
            sampSendChat('/me ������� ������� ���. ����� ��������')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/medcard ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('������ ����� ������ 1500 ������.')
            wait(3500)
            sampSendChat('/b /pay ID 1500')
            wait(3500)
            sampSendChat('����� ������, ��� ����� ����� ������')
            wait(3500)
            sampSendChat('/me ������ ����� ������ �������� � ������� ��������')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/recept ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('������������, �� ������ �� ����� �� ��������� ����?')
            wait(3500)
            sampSendChat('������, ��� ����� ������ ��� 6000���.')
            wait(3500)
            sampSendChat('��� �� ����� ��� �������� ��� ��� �������')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/me ���� ������� � �������� ��������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me ������ ������ � ��������.')
            wait(3500)
            sampSendChat('/todo ��� ������*��������� ��� �������.')
            wait(3500)
            sampSendChat('������ �������� � ���� �������, ���� � ����� ���� ����.')
            sampSendChat('/n /showtatu')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/do ������� ��� ������� ���� �� �����.')
            wait(3500)
            sampSendChat('/me ���� ������� ��� ���������� ����.')
            wait(3500)
            sampSendChat('/do ������� � ������ ����.')
            wait(3500)
            sampSendChat('/me ����� �������� ����.')
            wait(3500)
            sampSendChat('���, ��� ����� �������. ����� ��� �������.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/unstuff �� 6000")
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('��������� ����� ������� ���������� 650 ������.')
            wait(3500)
            sampSendChat('/b ������� ��� �������:')
            wait(3500)
            sampSendChat('/b /pay ��� ID 650.')
            wait(3500)
            sampSendChat('/me ������� ����� � ���������.')
            wait(3500)
            sampSendChat('/me ������� � ����� ����������� ���-�� �������.')
            wait(3500)
            sampSendChat('/me ���������� ��� ���, �������� ������� ��������.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/sellmed ")
        end)
    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) ..'*�� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('�� ������ � ��� �� ������������� ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������.������� ���� ���������. � ������ �������,�������� � ���.�����.')
            wait(3500)
            sampSendChat('/b �� �� ��')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ���������, ������� �������� ��������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ���� �������� � ���� ')
            wait(3500)
            sampSendChat('/do �������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ��������, ����� ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� ���.������ � ���� ')
            wait(3500)
            sampSendChat('/do ���.������ � �����.')
            wait(3500)
            sampSendChat('/me ��������� ���.�����, ������ ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('��������� � ������ ������� ')
            wait(3500)
            sampSendChat('�� ������� �� ����������.')
            wait(3500)
            sampSendChat('/do ��� ������ ����� ����� � ������ � ������.')
            wait(3500)
            sampSendChat('/me ������ ����� � �������� �������� ��������')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('����������� ����, ������ � ������� ������ �� ���� "�����-���".')
            wait(3500)
            sampSendChat('��-������, ����� ���������� ������ ���� ��������� � �����.')
            wait(3500)
            sampSendChat('��-������, �� �� ������ ��������� ��� �� ���������.')
            wait(3500)
            sampSendChat('������� ����, �������� ���� � �.�')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('��������� ���������� ������������ �����, ����� ��������� ��������!')
            wait(3500)
            sampSendChat('���� ��� �������, ��� ��������� � ��������� "��������" - ��������� �����!')
            wait(3500)
            sampSendChat('� ��������� "��.��������" ���� ���������, ������ �����������.')
            wait(3500)
            sampSendChat('���� ������� ���������� ������� ������c� �� ����������, ������� �����.')
            wait(3500)
            sampSendChat('��������� � �������� ����� �� ���������� ������� ������� �����.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('����������� ��� �� ������ � ������������.')
            wait(3500)
            sampSendChat('��� ������ ��������, ��� ����� ������������.')
            wait(3500)
            sampSendChat('������������ - ������� ���������� ������� �� ������ � ������� �� ������ ��������, ��������� � ���.')
            wait(3500)
            sampSendChat('�� ���� ������� ���������� ������ ��������� ������� ����������.')
            wait(3500)
            sampSendChat('��� ���������� - ������ ������� ������ ��������������, ����������� ��� - �������.')
            wait(3500)
            sampSendChat('�� ������ � ��������� ��������� � ���������� � ������� �� ��������� �� "��".')
            wait(3500)
            sampSendChat('�� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('��������� ��� �� � � �������...')
            wait(3500)
            sampSendChat('��� ������ ������� �� ������ �� �������������� �����������...')
            wait(3500)
            sampSendChat('...� � ����� ������� �����������')
            wait(3500)
            sampSendChat('��������� �������� ��� �������')
            wait(3500)
            sampSendChat('���������, ����������� � ����� ��������')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('������ � �������� ������ � ����� ����������.')
            wait(3500)
            sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
            wait(3500)
            sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
            wait(3500)
            sampSendChat('�������� �������������� �������������� �����������.')
            wait(3500)
            sampSendChat('� ����� ������������� ��������� ���� ���� ��������� �������������.')
            wait(3500)
            sampSendChat('�� ����������� ���� �������� �������������� ��������� ���� ����������...')
            wait(3500)
            sampSendChat('...���������, ������, ����������, �������, �����.')
            wait(3500)
            sampSendChat('������ ����� � ������ ������������� ����������.')
            wait(3500)
            sampSendChat('�������� ����������� � ���, ��� ��� ����� ��������� �� �����.')
            wait(3500)
            sampSendChat('������ ���������. ������� �� ��������.')
        end)
end

function RegisterHotkeysForFSIN()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/do ������� �� �����')
            wait(3500)
            sampSendChat('/me ���� ������� � �����.')
            wait(3500)
            sampSendChat('/do ������� � �����')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/do ������� � ����')
            wait(3500)
            sampSendChat('/me ������ ������� �� ����.')
            wait(3500)
            sampSendChat('/do ������� �� �����')
        end)


    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� ������� � �����.')
            wait(3500)
            sampSendChat('/do ������� � ����.')
            wait(3500)
            sampSendChat('/me ���� ������� � ��������������.')
            wait(3500)
            sampSendChat('/me ���������� ������.')
            wait(3500)
            sampSendChat('/do ���� �� ��������� ������.')
            wait(3500)
            sampSendChat('/me ����� ��������.')
        end)


    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ������� �� ��������������.')
            wait(3500)
            sampSendChat('/me ����� ������� �� �����.')
            wait(3500)
            sampSendChat('/do ������� �� �����.')
        end)


    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ������� �������� �������� �� ������')
            wait(3500)
            sampSendChat('/do �������� �������� � ����')
            wait(3500)
            sampSendChat('/me ���� �������� �������� � ��������������')
            wait(3500)
            sampSendChat('/me ���������� ������')
            wait(3500)
            sampSendChat('/do ���� �� ��������� ������')
            wait(3500)
            sampSendChat('/me ����� ��������') 
        end)


    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/do �������� �������� � �����')
            wait(3500)
            sampSendChat('/me �������� �������� �������� �� ��������������')
            wait(3500)
            sampSendChat('/me ����� �������� � ������')
            wait(3500)
            sampSendChat('/do �������� � ������')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/do ��������� ����� �� �����.')
            wait(3500)
            sampSendChat('/me ������ ��������� ���� ��������� � �����')
            wait(3500)
            sampSendChat('/do ��������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ��������� �� ������������')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/cuff ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/do ���� �� ���������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ���� ���������')
            wait(3500)
            sampSendChat('/do ��������� � �����.')
            wait(3500)
            sampSendChat('/me ������ ��������� �� ����')
            sampSetChatInputText("/uncuff ")
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me ���� ������������ ��� ���� � ���� �� �����')
            wait(3500)
            sampSendChat('/do ��������� ��� ���� ������������.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/gotome ")
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) ..'*�� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('�� ������ � ��� �� ������������� ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������.������� ���� ���������. � ������ �������,�������� � ���.�����.')
            wait(3500)
            sampSendChat('/b �� �� ��')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ���������, ������� �������� ��������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ���� �������� � ���� ')
            wait(3500)
            sampSendChat('/do �������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ��������, ����� ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� ���.������ � ���� ')
            wait(3500)
            sampSendChat('/do ���.������ � �����.')
            wait(3500)
            sampSendChat('/me ��������� ���.�����, ������ ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('��������� � ������ ������� ')
            wait(3500)
            sampSendChat('�� ������� �� ����������.')
            wait(3500)
            sampSendChat('/do ��� ������ ����� ����� � ������ � ������.')
            wait(3500)
            sampSendChat('/me ������ ����� � �������� �������� ��������')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('����������� ����, ������ � ������� ������ �� ���� "�����-���".')
            wait(3500)
            sampSendChat('��-������, ����� ���������� ������ ���� ��������� � �����.')
            wait(3500)
            sampSendChat('��-������, �� �� ������ ��������� ��� �� ���������.')
            wait(3500)
            sampSendChat('������� ����, �������� ���� � �.�')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('��������� ���������� ������������ �����, ����� ��������� ��������!')
            wait(3500)
            sampSendChat('���� ��� �������, ��� ��������� � ��������� "��������" - ��������� �����!')
            wait(3500)
            sampSendChat('� ��������� "��.��������" ���� ���������, ������ �����������.')
            wait(3500)
            sampSendChat('���� ������� ���������� ������� ������c� �� ����������, ������� �����.')
            wait(3500)
            sampSendChat('��������� � �������� ����� �� ���������� ������� ������� �����.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('����������� ��� �� ������ � ������������.')
            wait(3500)
            sampSendChat('��� ������ ��������, ��� ����� ������������.')
            wait(3500)
            sampSendChat('������������ - ������� ���������� ������� �� ������ � ������� �� ������ ��������, ��������� � ���.')
            wait(3500)
            sampSendChat('�� ���� ������� ���������� ������ ��������� ������� ����������.')
            wait(3500)
            sampSendChat('��� ���������� - ������ ������� ������ ��������������, ����������� ��� - �������.')
            wait(3500)
            sampSendChat('�� ������ � ��������� ��������� � ���������� � ������� �� ��������� �� "��".')
            wait(3500)
            sampSendChat('�� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('��������� ��� �� � � �������...')
            wait(3500)
            sampSendChat('��� ������ ������� �� ������ �� �������������� �����������...')
            wait(3500)
            sampSendChat('...� � ����� ������� �����������')
            wait(3500)
            sampSendChat('��������� �������� ��� �������')
            wait(3500)
            sampSendChat('���������, ����������� � ����� ��������')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('������ � �������� ������ � ����� ����������.')
            wait(3500)
            sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
            wait(3500)
            sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
            wait(3500)
            sampSendChat('�������� �������������� �������������� �����������.')
            wait(3500)
            sampSendChat('� ����� ������������� ��������� ���� ���� ��������� �������������.')
            wait(3500)
            sampSendChat('�� ����������� ���� �������� �������������� ��������� ���� ����������...')
            wait(3500)
            sampSendChat('...���������, ������, ����������, �������, �����.')
            wait(3500)
            sampSendChat('������ ����� � ������ ������������� ����������.')
            wait(3500)
            sampSendChat('�������� ����������� � ���, ��� ��� ����� ��������� �� �����.')
            wait(3500)
            sampSendChat('������ ���������. ������� �� ��������.')
        end)
end

function RegisterHotkeysForSP()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/me ������� �������')
            wait(3500)
            sampSendChat('/m ���������, ���������� ���� ������������ �������� � ���������� � �������')
            wait(3500)
            sampSendChat('/m ��������� ���������, ���� �� ���� � ��� ������ ��������')
            wait(3500)
            sampSendChat('/m � ������ ������������ � ������ ����� �� �������...')
            wait(3500)
            sampSendChat('/m � �� ������ �������� � ����������� ������ ������')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������������, � '.. u8:decode(mainini.config.Rang) ..' ��� - '.. u8:decode(mainini.config.NickNameText))
            wait(3500)
            sampSendChat('/do ������������� � ����� ������� �������.')
            wait(3500)
            sampSendChat('/me ���� ������������� �� ������ �������� �������')
            wait(3500)
            sampSendChat('/do �� ������������� �������� "��� ��"')
            wait(3500)
            sampSendChat('/me ������ ������������� �� ������ ��������')
            wait(3500)
            sampSendChat('/me ���������� �������� �������� � �������� ����')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/showbadge ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/do �������� � ����� � �����.')
            wait(3500)
            sampSendChat('/me ������ ��������, ����� ����� ��������� ��������')
            wait(3500)
            sampSendChat('/do �������� ���������.')
            wait(3500)
            sampSendChat('/me ������ ������ �� ���������')
            wait(3500)
            sampSendChat('/do �� ������ �������: "�����"')
            wait(3500)
            sampSendChat('/me ����� ����� ����������')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/ticket ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/do ��������� ���������� ��������� ��������� � ������ �������.')
            wait(3500)
            sampSendChat('/me ������ �� ������� ��� � ����� � ���� ������ ���')
            wait(3500)
            sampSendChat('/me ���� �������������� � ���� ������ � ����� ��� � ������')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/su ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ������� �������� �� �����, ����� ���� ������ ��� ����� �������')
            wait(3500)
            sampSendChat('/do �� ����� ����� ���������.')
            wait(3500)
            sampSendChat('/me ������ ��������� ���� ���� ��������� � �����')
            wait(3500)
            sampSendChat('/do ��������� � �����.')
            wait(3500)
            sampSendChat('/me ������� ���� ��������')
            wait(3500)
            sampSendChat('/me �������� ��������� �������� ��������')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/me ������ �������� � �����')
            wait(3500)
            sampSendChat('/me ������� ���� � ���� ������������ ����� �� �����')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/me ������ ����� ����������')
            wait(3500)
            sampSendChat('/me ������� ������ ������������ � ������� � ����������')
            wait(3500)
            sampSendChat('/do ����������� � ����������.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/incar ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/do ����� �� ������ ���������� ��������� �� ����������� �����.')
            wait(3500)
            sampSendChat('/me ���� �� ������������ ����� ����� �� ������ �����������')
            wait(3500)
            sampSendChat('/me ������� ���� �� ������ � �������� �������� � ������ ������')
            wait(3500)
            sampSendChat('/me ������� ������������ �� ����� ������ � �������� � ������')
            wait(3500)
            sampSendChat('/do �������...')
            wait(3500)
            sampSendChat('/me ��������� �������, ������ �� �� ����� � ������� ���� �� �����')
            wait(3500)
            sampSendChat('/me ������� �������� ������ �� ����������� ����')
            wait(3500)
            sampSendChat('/do ����� �� ������ ���������� ��������� �� ����������� �����.')
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/arrest ')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/me ������ �� ������� ���')
            wait(3500)
            sampSendChat('/me ����� � ���� ������ �������������')
            wait(3500)
            sampSendChat('/me ������ ��� ���� ������������ � ��������� ������� ��������')
            wait(3500)
            sampSendChat('/do � ���� ������ ������������� ���� ������ ����')
            wait(3500)
            sampSendChat('/me ������ ���')
            wait(3500)
            sampSendChat('/me ������� ��� ������� � ������')
            wait(3500)
            sampSendChat('�� ��������� ��� ���������, �� ��������� ���� �������������')
        end)

    rkeys.registerHotKey({ VK_NUMPAD9 }, 1, true,
        function()
            sampSendChat('�� ���������� �� ��������� ������� �������')
            wait(3500)
            sampSendChat('�� ������ ����� ������� �������� - ��� ��� �� ������� - ����� ������������ ������ ���')
            wait(3500)
            sampSendChat('�� ������ ����� �� �������� �� ����� ��������� ���������')
            wait(3500)
            sampSendChat('/todo ��� ���� ���� �����?*���������� ������ �� ������������')
            wait(3500)
        end)

    rkeys.registerHotKey({ VK_F1 }, 1, true,
        function()
            sampSendChat('/do ������� �� �����.')
            wait(3500)
            sampSendChat('/me ������� ������� � �����')
            wait(3500)
            sampSendChat('/do ������� � ����.')
            wait(3500)
            sampSendChat('/me ����� ��������� ������������� ������')
            wait(3500)
            sampSendChat('/do �����.')
            wait(3500)
            sampSendChat('/me ������� ������� �� ����')
            wait(3500)
            sampSendChat('/do ������� �� �����.')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) ..'*�� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('�� ������ � ��� �� ������������� ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������.������� ���� ���������. � ������ �������,�������� � ���.�����.')
            wait(3500)
            sampSendChat('/b �� �� ��')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ���������, ������� �������� ��������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ���� �������� � ���� ')
            wait(3500)
            sampSendChat('/do �������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ��������, ����� ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� ���.������ � ���� ')
            wait(3500)
            sampSendChat('/do ���.������ � �����.')
            wait(3500)
            sampSendChat('/me ��������� ���.�����, ������ ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('��������� � ������ ������� ')
            wait(3500)
            sampSendChat('�� ������� �� ����������.')
            wait(3500)
            sampSendChat('/do ��� ������ ����� ����� � ������ � ������.')
            wait(3500)
            sampSendChat('/me ������ ����� � �������� �������� ��������')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('����������� ����, ������ � ������� ������ �� ���� "�����-���".')
            wait(3500)
            sampSendChat('��-������, ����� ���������� ������ ���� ��������� � �����.')
            wait(3500)
            sampSendChat('��-������, �� �� ������ ��������� ��� �� ���������.')
            wait(3500)
            sampSendChat('������� ����, �������� ���� � �.�')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('��������� ���������� ������������ �����, ����� ��������� ��������!')
            wait(3500)
            sampSendChat('���� ��� �������, ��� ��������� � ��������� "��������" - ��������� �����!')
            wait(3500)
            sampSendChat('� ��������� "��.��������" ���� ���������, ������ �����������.')
            wait(3500)
            sampSendChat('���� ������� ���������� ������� ������c� �� ����������, ������� �����.')
            wait(3500)
            sampSendChat('��������� � �������� ����� �� ���������� ������� ������� �����.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('����������� ��� �� ������ � ������������.')
            wait(3500)
            sampSendChat('��� ������ ��������, ��� ����� ������������.')
            wait(3500)
            sampSendChat('������������ - ������� ���������� ������� �� ������ � ������� �� ������ ��������, ��������� � ���.')
            wait(3500)
            sampSendChat('�� ���� ������� ���������� ������ ��������� ������� ����������.')
            wait(3500)
            sampSendChat('��� ���������� - ������ ������� ������ ��������������, ����������� ��� - �������.')
            wait(3500)
            sampSendChat('�� ������ � ��������� ��������� � ���������� � ������� �� ��������� �� "��".')
            wait(3500)
            sampSendChat('�� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('��������� ��� �� � � �������...')
            wait(3500)
            sampSendChat('��� ������ ������� �� ������ �� �������������� �����������...')
            wait(3500)
            sampSendChat('...� � ����� ������� �����������')
            wait(3500)
            sampSendChat('��������� �������� ��� �������')
            wait(3500)
            sampSendChat('���������, ����������� � ����� ��������')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('������ � �������� ������ � ����� ����������.')
            wait(3500)
            sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
            wait(3500)
            sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
            wait(3500)
            sampSendChat('�������� �������������� �������������� �����������.')
            wait(3500)
            sampSendChat('� ����� ������������� ��������� ���� ���� ��������� �������������.')
            wait(3500)
            sampSendChat('�� ����������� ���� �������� �������������� ��������� ���� ����������...')
            wait(3500)
            sampSendChat('...���������, ������, ����������, �������, �����.')
            wait(3500)
            sampSendChat('������ ����� � ������ ������������� ����������.')
            wait(3500)
            sampSendChat('�������� ����������� � ���, ��� ��� ����� ��������� �� �����.')
            wait(3500)
            sampSendChat('������ ���������. ������� �� ��������.')
        end)
end

function RegisterHotkeysForRCR()
    rkeys.registerHotKey({ VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
            wait(5000)
            sampSendChat('/news ������������, ������� ��������������')
            wait(5000)
            sampSendChat('/news � ���� � *���������* ������������ �. "�����", ��� �������')
            wait(5000)
            sampSendChat('/news � ������� � ��� ���� � ������')
            wait(5000)
            sampSendChat('/news � ������ ��������� ������� �������� ��� ������� ���� 25')
            wait(5000)
            sampSendChat('/news ������� ��� ���� �� �������� ����� � ���� ����')
            wait(5000)
            sampSendChat('/news � ������ ������� ������� ���� 17 � �������,��������� ����� �������')
            wait(5000)
            sampSendChat('/news �������� �� �������� �� ���� � ������� �����')
            wait(5000)
            sampSendChat('/news � ���.�������� �������� ���� 25 �� ����� ����')
            wait(5000)
            sampSendChat('/news � �� ���� ������� ������ �������')
            wait(4000)
            sampSendChat('/news �������, ��� ���� � ����')
            wait(4000)
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
            wait(5000)
            sampSendChat('/news �����������, ������� ��������������, � ����� ������������ '.. u8:decode(mainini.config.Nameorg) ..'.')
            wait(5000)
            sampSendChat('/news ������� � ���� � - '.. u8:decode(mainini.config.Rang) ..' '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ������ � ������� ���� �� ���� ���� ������� � ������������.')
            wait(5000)
            sampSendChat('/news ������ � ������� ������� � �� ������.')
            wait(5000)
            sampSendChat('/news ���� ������, �� ������ ��������� ���� ������� � ������������.')
            wait(5000)
            sampSendChat('/news �� �����: '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news � � �� ���� ���������� � ������ �����.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/news �� ���� �� ����������� ��� ����.')
            wait(5000)
            sampSendChat('/news � ���� ��� � - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
            wait(5000)
            sampSendChat('/news ������������, ������� ��������������')
            wait(5000)
            sampSendChat('/news � ���� � - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news � ������� � ��� ���� � ������')
            wait(5000)
            sampSendChat('/news � ������ ��������� ������� �������� ��� ������� ���� 25')
            wait(5000)
            sampSendChat('/news ������� ��� ���� �� �������� ����� � ���� ����')
            wait(5000)
            sampSendChat('/news � ������ ������� ������� ���� 17 � �������,��������� ����� �������')
            wait(5000)
            sampSendChat('/news �������� �� �������� �� ���� � ������� �����')
            wait(5000)
            sampSendChat('/news � ���.�������� �������� ���� 25 �� ����� ����')
            wait(5000)
            sampSendChat('/news � �� ���� ������� ������ �������')
            wait(4000)
            sampSendChat('/news �������, ��� ���� � ����')
            wait(4000)
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
            wait(5000)
            sampSendChat('/news �����������, ������� ��������������, � ����� ������������ '.. u8:decode(mainini.config.Nameorg) ..'.')
            wait(5000)
            sampSendChat('/news � ���� � - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ������ � ������� ���� �� ���� ���� ������� � ������������.')
            wait(5000)
            sampSendChat('/news ������ � ������� ������� � �� ������.')
            wait(5000)
            sampSendChat('/news ���� ������, �� ������ ��������� ���� ������� � ������������.')
            wait(5000)
            sampSendChat('/news �� �����: '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news � � �� ���� ���������� � ������ �����.')
        end)

    rkeys.registerHotKey({ VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('news �� ���� �� ����������� ��� ����.')
            wait(5000)
            sampSendChat('/news � ���� ��� � - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('/news � ���� ��� � - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news ������������, ������� �������������� ')
            wait(5000)
            sampSendChat('/news � ���� � - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news � ������� � ��� ��������� ������� ')
            wait(5000)
            sampSendChat('/news � ��������� �������. ��������:�����, � �� ������ ������� ����� ������ ��� �������...')
            wait(5000)
            sampSendChat('/news ������ ����� �����.')
            wait(5000)
            sampSendChat('/news ������ ��������� ������ - 1 ���� �� ���� �����������.')
            wait(5000)
            sampSendChat('/news � ������ �� �� 5-�� ������.')
            wait(5000)
            sampSendChat('/news �� ��� ������ ��� ����� ��������.')
            wait(5000)
            sampSendChat('/news ��� ���� ����� ���� ��������� ����� ��������� ������ �� ���� ���� ��� �������� � ����.')
            wait(5000)
            sampSendChat('/news ���� ������ ���������� �� ����� '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news ��� ��� 1 ������ ����� �������� ���� � ��������')
        end)

    rkeys.registerHotKey({ VK_NUMPAD6 }, 1, true,
        function()
            sampSendChat('/news ��������� ���.')
            wait(4000)
            sampSendChat('/news ����� ������� ���� - ��������� � ����� ������������.')
            wait(4000)
            sampSendChat('/news � �� ���� � ���������� ���������.')
            wait(4000)
            sampSendChat('/news �������, ��� ���� � ����.')
            wait(4000)
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
        end)

    rkeys.registerHotKey({ VK_NUMPAD7 }, 1, true,
        function()
            sampSendChat('/news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
            wait(5000)
            sampSendChat('/news ������������, ������� �������������� ')
            wait(5000)
            sampSendChat('/news � ���� � - '.. u8:decode(mainini.config.Rang) ..', '.. u8:decode(mainini.config.NickNameText))
            wait(5000)
            sampSendChat('/news � ������� � ��� ��������� ���������')
            wait(5000)
            sampSendChat('/news � ��������� ������. ��������:5 + 5, � �� ������ ������� ����� �����..')
            wait(5000)
            sampSendChat('/news ����� ����� 10.')
            wait(5000)
            sampSendChat('/news ������ ��������� ������ - 1 ���� �� ���� �����������.')
            wait(5000)
            sampSendChat('/news � ������ �� �� 5-�� ������.')
            wait(5000)
            sampSendChat('/news �� ��� ������ ��� ����� ��������.')
            wait(5000)
            sampSendChat('/news ��� ���� ����� ���� ��������� ����� ��������� ������ �� ���� ���� ��� �������� � ����.')
            wait(5000)
            sampSendChat('/news ���� ������ ���������� �� ����� '.. u8:decode(mainini.config.Number))
            wait(5000)
            sampSendChat('/news ��� ��� 1 ������ ����� �������� ���� � ��������')
        end)

    rkeys.registerHotKey({ VK_NUMPAD8 }, 1, true,
        function()
            sampSendChat('/news ��������� ���.')
            wait(4000)
            sampSendChat('/news ����� ������� ���� - ��������� � ����� ������������.')
            wait(4000)
            sampSendChat('/news � �� ���� � ���������� ���������.')
            wait(4000)
            sampSendChat('/news �������, ��� ���� � ����.')
            wait(4000)
            sampSendChat('/news /news ...::: ����������� �������� � '.. u8:decode(mainini.config.Nameorg) ..' �:::...')
        end)


    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('/todo ������������ ���� ����� '.. u8:decode(mainini.config.NickNameText) ..'*�� ����� ����� ������� '.. u8:decode(mainini.config.Rang))
            wait(3500)
            sampSendChat('�� ������ � ��� �� ������������� ?')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('������.������� ���� ���������. � ������ �������,�������� � ���.�����.')
            wait(3500)
            sampSendChat('/b �� �� ��')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('/me ���� �������')
            wait(3500)
            sampSendChat('/do ������� � �����.')
            wait(3500)
            sampSendChat('/me �������� ���������, ������� �������� ��������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('/me ���� �������� � ���� ')
            wait(3500)
            sampSendChat('/do �������� � �����.')
            wait(3500)
            sampSendChat('/me ��������� ����� ��������, ����� ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('/me ���� ���.������ � ���� ')
            wait(3500)
            sampSendChat('/do ���.������ � �����.')
            wait(3500)
            sampSendChat('/me ��������� ���.�����, ������ ���������')
        end)

    rkeys.registerHotKey({ VK_CONTROL, VK_NUMPAD5 }, 1, true,
        function()
            sampSendChat('��������� � ������ ������� ')
            wait(3500)
            sampSendChat('�� ������� �� ����������.')
            wait(3500)
            sampSendChat('/do ��� ������ ����� ����� � ������ � ������.')
            wait(3500)
            sampSendChat('/me ������ ����� � �������� �������� ��������')
            wait(3500)
            sampSetChatInputEnabled(true)
            sampSetChatInputText("/invite ")
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD0 }, 1, true,
        function()
            sampSendChat('����������� ����, ������ � ������� ������ �� ���� "�����-���".')
            wait(3500)
            sampSendChat('��-������, ����� ���������� ������ ���� ��������� � �����.')
            wait(3500)
            sampSendChat('��-������, �� �� ������ ��������� ��� �� ���������.')
            wait(3500)
            sampSendChat('������� ����, �������� ���� � �.�')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD1 }, 1, true,
        function()
            sampSendChat('��������� ���������� ������������ �����, ����� ��������� ��������!')
            wait(3500)
            sampSendChat('���� ��� �������, ��� ��������� � ��������� "��������" - ��������� �����!')
            wait(3500)
            sampSendChat('� ��������� "��.��������" ���� ���������, ������ �����������.')
            wait(3500)
            sampSendChat('���� ������� ���������� ������� ������c� �� ����������, ������� �����.')
            wait(3500)
            sampSendChat('��������� � �������� ����� �� ���������� ������� ������� �����.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD2 }, 1, true,
        function()
            sampSendChat('����������� ��� �� ������ � ������������.')
            wait(3500)
            sampSendChat('��� ������ ��������, ��� ����� ������������.')
            wait(3500)
            sampSendChat('������������ - ������� ���������� ������� �� ������ � ������� �� ������ ��������, ��������� � ���.')
            wait(3500)
            sampSendChat('�� ���� ������� ���������� ������ ��������� ������� ����������.')
            wait(3500)
            sampSendChat('��� ���������� - ������ ������� ������ ��������������, ����������� ��� - �������.')
            wait(3500)
            sampSendChat('�� ������ � ��������� ��������� � ���������� � ������� �� ��������� �� "��".')
            wait(3500)
            sampSendChat('�� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������.')
        end)

    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD3 }, 1, true,
        function()
            sampSendChat('��������� ��� �� � � �������...')
            wait(3500)
            sampSendChat('��� ������ ������� �� ������ �� �������������� �����������...')
            wait(3500)
            sampSendChat('...� � ����� ������� �����������')
            wait(3500)
            sampSendChat('��������� �������� ��� �������')
            wait(3500)
            sampSendChat('���������, ����������� � ����� ��������')
        end)


    rkeys.registerHotKey({ VK_MENU, VK_NUMPAD4 }, 1, true,
        function()
            sampSendChat('������ � �������� ������ � ����� ����������.')
            wait(3500)
            sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
            wait(3500)
            sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
            wait(3500)
            sampSendChat('�������� �������������� �������������� �����������.')
            wait(3500)
            sampSendChat('� ����� ������������� ��������� ���� ���� ��������� �������������.')
            wait(3500)
            sampSendChat('�� ����������� ���� �������� �������������� ��������� ���� ����������...')
            wait(3500)
            sampSendChat('...���������, ������, ����������, �������, �����.')
            wait(3500)
            sampSendChat('������ ����� � ������ ������������� ����������.')
            wait(3500)
            sampSendChat('�������� ����������� � ���, ��� ��� ����� ��������� �� �����.')
            wait(3500)
            sampSendChat('������ ���������. ������� �� ��������.')
        end)

end

update_state = false

local script_vers = 11
local script_vers_text = "11.0"

local update_url = "https://raw.githubusercontent.com/DenisMalahovskiyOLSHER/GovernmentBinder/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://github.com/thechampguess/scripts/blob/master/autoupdate_lesson_16.luac?raw=true" -- ��� ���� ������
local script_path = thisScript().path


function main()
    while not isSampAvailable() do wait(100) end
    --if '185.169.134.108' ~= nil and '185.169.134.108' ~= sampGetCurrentServerAddress() then 
    --    sampAddChatMessage('[Government AHK] {d5dedd} �� ����� �� �� �������� ������. ������ �������� ������', 0xfe4749)
    --    thisScript():unload()
    --else
        sampAddChatMessage("[Government AHK] {d5dedd}������ ��� ������� ��������.", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}�����: {fe4749}Denis_Richard", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}����� ������� ���� �������: {fe4749}F3.", 0xfe4749)
        sampAddChatMessage("[Government AHK] {d5dedd}������ �������: {fe4749}v."..thisScript().version, 0xfe4749)
    --end

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("������ ������� ��������!", -1)
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
        if imgui.Button(u8"�������", imgui.ImVec2(135, 35)) then
            menu = 1
        end
        imgui.SameLine()
        if imgui.Button(u8"����� �����������", imgui.ImVec2(135, 35)) then
            menu = 2
        end
        --imgui.SameLine()
        --if imgui.Button(u8"���������", imgui.ImVec2(135, 35)) then
        --    menu = 3
        --end
        imgui.SameLine()
        if imgui.Button(u8"����������", imgui.ImVec2(135, 35)) then
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
                imgui.Text(fa.ICON_USER_CIRCLE ..u8"    �������: ".. sampGetPlayerNickname(id))
                imgui.Text(fa.ICON_ADDRESS_BOOK ..u8"    ID: ".. id)
                imgui.Text(fa.ICON_WIFI ..u8"   ����: ".. sampGetPlayerPing(id))
                imgui.Text(fa.ICON_HEARTBEAT ..u8"    ��������: ".. sampGetPlayerHealth(id))
                imgui.Text(fa.ICON_SHIELD ..u8"     �����: ".. sampGetPlayerArmor(id))
                imgui.Text(fa.ICON_SERVER ..u8"     ������: Rodina RP 04")
            imgui.EndChild()
            imgui.NewLine()
            imgui.NewLine()
            imgui.NewLine()
            imgui.NewLine()
            imgui.Button(u8"        ������: 4.0 \n�����: Denis_Richard", imgui.ImVec2(230, 45))
        imgui.EndChild()
        imgui.NextColumn()
        imgui.SetColumnWidth(-1, 930)
        imgui.BeginChild("##zagolovok", imgui.ImVec2(930, 525), false, imgui.WindowFlags.NoScrollbar)
            if not menu then 
                menu = 1 
            end
            if menu == 1 then
                imgui.CenterText(u8"�������")
                imgui.NewLine()
                if imgui.InputText(u8'NickName �� �������', NickNameText) then
                    mainini.config.NickNameText = NickNameText.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'�������� �����������', Nameorg) then
                    mainini.config.Nameorg = Nameorg.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'��� �����������', Teg) then
                    mainini.config.Teg = Teg.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'�������� �����', Rang) then
                    mainini.config.Rang = Rang.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'������ /gov �1 ��� ����', GOV1) then
                    mainini.config.GOV1 = GOV1.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'������ /gov �2 ��� ����', GOV2) then
                    mainini.config.GOV2 = GOV2.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'������ /gov �3 ��� ����', GOV3) then
                    mainini.config.GOV3 = GOV3.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'����� ��������', Number) then
                    mainini.config.Number = Number.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'����� �����', Post) then
                    mainini.config.Post = Post.v
                    inicfg.save(mainini, savee)
                end
                imgui.NewLine()
                if imgui.InputText(u8'����� �������� /gov (H:M:S)', TimeGovka) then
                    mainini.config.TimeGovka = TimeGovka.v
                    inicfg.save(mainini, savee)
                end
            elseif menu == 2 then
                imgui.CenterText(u8"����� �����������")
                imgui.NewLine()
                if imgui.Button(u8'���-��', imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForGovernment()
                    sampAddChatMessage("[Government Binder] {d5dedd}������� ����������� - {fe4749}�������������.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"����", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForBank()
                    sampAddChatMessage("[Government Binder] {d5dedd}������� ����������� - {fe4749}����.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"���", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForSP()
                    sampAddChatMessage("[Government Binder] {d5dedd}������� ����������� - {fe4749}���.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"��", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForRCR()
                    sampAddChatMessage("[Government Binder] {d5dedd}������� ����������� - {fe4749}������������.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"���", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForGKB()
                    sampAddChatMessage("[Government Binder] {d5dedd}������� ����������� - {fe4749}���.", 0xfe4749)
                end
                if imgui.Button(u8"�����", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForArmy()
                    sampAddChatMessage("[Government Binder] {d5dedd}������� ����������� - {fe4749}�����.", 0xfe4749)
                end
                imgui.SameLine()
                if imgui.Button(u8"����", imgui.ImVec2(158, 46)) then
                    clearAllHotkeys()
                    RegisterHotkeysForFSIN()
                    sampAddChatMessage("[Government Binder] {d5dedd}������� ����������� - {fe4749}����.", 0xfe4749)
                end
            elseif menu == 3 then
                imgui.CenterText(u8"����������")
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
    sampSendChat("/d [".. u8:decode(mainini.config.Teg) .."] - [����] ������� ��������������� ����� ��������.")
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV1))
    wait(3500)
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV2))
    wait(3500)
    sampSendChat("/gov [".. u8:decode(mainini.config.Teg) .."] ".. u8:decode(mainini.config.GOV3))
    sampSendChat("/d [".. u8:decode(mainini.config.Teg) .."] - [".. u8:decode(mainini.config.Teg) .."] �c�������� ��������������� ����� ��������.")
    wait(3500)
    sampSendChat("/rb [Government Binder] ��������������� ����� �������� ���� ����������: ".. u8:decode(mainini.config.NickNameText))
end
function onScriptTerminate(script, quitGame)
    if script == thisScript() then
        inicfg.save(mainini, savee)
        sampAddChatMessage('[Government Binder]{d5dedd} ������ �������� �������� ������ � �������� ���������', 0xfe4749)
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