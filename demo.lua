local LocalCoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

-- DANH SÁCH USER VÀ RANK
local UserRanks = {
    ["khaden1999"] = "CREATOR",
    ["monkeynicehihi"] = "ADMIN"
}

local currentUserName = string.lower(LocalPlayer.Name)

-- PARENT AN TOÀN
local function GetSafeParent()
    local targetParent = nil
    if gethui then pcall(function() targetParent = gethui() end) end
    if not targetParent and LocalPlayer then pcall(function() targetParent = LocalPlayer:FindFirstChildOfClass("PlayerGui") end) end
    if not targetParent then pcall(function() targetParent = LocalCoreGui end) end
    return targetParent
end

local ParentGui = GetSafeParent()

-- DỌN DẸP UI CŨ
if ParentGui then
    for _, v in ipairs(ParentGui:GetChildren()) do
        if v.Name == "NicePrimePandelV1Gui" or v.Name == "NiceXTongHopV3Gui" then
            v:Destroy()
        end
    end
end

-- PALETTE MÀU CYBER NEON GLASS
local Theme = {
    Background = Color3.fromRGB(15, 17, 26),
    TopCard = Color3.fromRGB(22, 26, 40),
    Card = Color3.fromRGB(28, 33, 50),
    CardHover = Color3.fromRGB(38, 45, 68),
    Accent = Color3.fromRGB(0, 230, 180),
    AccentGlow = Color3.fromRGB(0, 255, 200),
    DevColor = Color3.fromRGB(0, 170, 255),
    Gold = Color3.fromRGB(255, 215, 0),
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(145, 155, 180),
    Border = Color3.fromRGB(45, 52, 78),
    Danger = Color3.fromRGB(255, 75, 100)
}

-- ĐA NGÔN NGỮ
local CurrentLang = "VIE"
local Translations = {
    VIE = {
        TabHome = "Tổng Quan", TabHop = "Chuyển Server", TabHubs = "Thư Viện Script",
        TabReport = "Trợ Giúp", TabSetting = "Cấu Hình", MaxPlayers = "Giới hạn người chơi:",
        HopLow = "Chuyển Server Ít Người", Rejoin = "Kết Nối Lại Game",
        Scanning = "⏳ Đang Tìm Server Tối Ưu...", Executing = "⚡ Đang Khởi Chạy...",
        Executed = "✓ KÍCH HOẠT THÀNH CÔNG", ReportBtn = "Sao Chép Link TikTok Hỗ Trợ",
        ReportSuccess = "✓ Đã Sao Chép Link TikTok!", LangTitle = "🌐 Ngôn Ngữ Display:",
        InfoTitle = "📢 Nhật Ký Cập Nhật:", InfoStatus = "✨ NICEPRIMEPANDEL V1 Official Released!",
        FixLagBtn = "Bật Chế Độ Tối Ưu Đồ Họa (Fix Lag)", FixLagSuccess = "✓ Đã Tối Ưu Đồ Họa Hoàn Toàn"
    },
    ENG = {
        TabHome = "Dashboard", TabHop = "Server Hop", TabHubs = "Script Vault",
        TabReport = "Support", TabSetting = "Settings", MaxPlayers = "Max players in server:",
        HopLow = "Hop To Low Server", Rejoin = "Rejoin Current Server",
        Scanning = "⏳ Searching Optimal Server...", Executing = "⚡ Executing Script...",
        Executed = "✓ SUCCESSFULLY EXECUTED", ReportBtn = "Copy TikTok Support Link",
        ReportSuccess = "✓ Copied TikTok Link!", LangTitle = "🌐 Language Setup:",
        InfoTitle = "📢 Release Notes:", InfoStatus = "✨ NICEPRIMEPANDEL V1 Official Released!",
        FixLagBtn = "Enable FPS Boost (Fix Lag)", FixLagSuccess = "✓ FPS Boost Applied"
    }
}

local TextRegistry = {}
local function RegisterText(textObject, langKey)
    table.insert(TextRegistry, {Object = textObject, Key = langKey})
    textObject.Text = Translations[CurrentLang][langKey] or textObject.Text
end

local function UpdateLanguage(newLang)
    CurrentLang = newLang
    for _, item in ipairs(TextRegistry) do
        if item.Object and item.Object.Parent and Translations[CurrentLang][item.Key] then
            item.Object.Text = Translations[CurrentLang][item.Key]
        end
    end
end

-- SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NicePrimePandelV1Gui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = ParentGui

-- NÚT TOGGLE MINI (NÚT MỞ MENU)
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "V1Toggle"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 15, 0.3, 0)
ToggleBtn.BackgroundColor3 = Theme.Background
ToggleBtn.Image = "rbxassetid://137468238820595"
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(1, 0)
UICornerToggle.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Theme.Accent
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrameV1"
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 16)
UICornerMain.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Border
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- TOP HEADER BAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, -24, 0, 48)
TopBar.Position = UDim2.new(0, 12, 0, 10)
TopBar.BackgroundColor3 = Theme.TopCard
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local UICornerTop = Instance.new("UICorner")
UICornerTop.CornerRadius = UDim.new(0, 12)
UICornerTop.Parent = TopBar

local TopStroke = Instance.new("UIStroke")
TopStroke.Color = Theme.Border
TopStroke.Thickness = 1
TopStroke.Parent = TopBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 300, 0, 22)
TitleText.Position = UDim2.new(0, 14, 0, 6)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Theme.TextPrimary
TitleText.TextSize = 13
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Text = "⚡ NICEPRIMEPANDEL V1"
TitleText.Parent = TopBar

local SubTitleText = Instance.new("TextLabel")
SubTitleText.Size = UDim2.new(0, 250, 0, 14)
SubTitleText.Position = UDim2.new(0, 14, 0, 26)
SubTitleText.BackgroundTransparency = 1
SubTitleText.TextColor3 = Theme.Accent
SubTitleText.TextSize = 9
SubTitleText.Font = Enum.Font.GothamBold
SubTitleText.TextXAlignment = Enum.TextXAlignment.Left
SubTitleText.Text = "PREMIUM EDITION • HAZUI TEAM"
SubTitleText.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = Theme.Danger
CloseBtn.BackgroundTransparency = 0.85
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Danger
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 8)
UICornerClose.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- NAVBAR TABS
local NavBar = Instance.new("Frame")
NavBar.Size = UDim2.new(1, -24, 0, 38)
NavBar.Position = UDim2.new(0, 12, 0, 64)
NavBar.BackgroundColor3 = Theme.TopCard
NavBar.BorderSizePixel = 0
NavBar.Parent = MainFrame

local UICornerNav = Instance.new("UICorner")
UICornerNav.CornerRadius = UDim.new(0, 10)
UICornerNav.Parent = NavBar

local NavList = Instance.new("UIListLayout")
NavList.FillDirection = Enum.FillDirection.Horizontal
NavList.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavList.VerticalAlignment = Enum.VerticalAlignment.Center
NavList.Padding = UDim.new(0, 6)
NavList.Parent = NavBar

-- CONTAINER NỘI DUNG
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -24, 1, -118)
ContentArea.Position = UDim2.new(0, 12, 0, 108)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local tabs = {}
local tabButtons = {}

local function CreateTab(langKey, iconText)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 95, 0, 28)
    tabBtn.BackgroundColor3 = Theme.Background
    tabBtn.TextColor3 = Theme.TextSecondary
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 9
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = NavBar

    RegisterText(tabBtn, langKey)
    local updateTabLabel = function()
        tabBtn.Text = iconText .. " " .. (Translations[CurrentLang][langKey] or "")
    end
    updateTabLabel()

    local UICornerTab = Instance.new("UICorner")
    UICornerTab.CornerRadius = UDim.new(0, 8)
    UICornerTab.Parent = tabBtn

    local tabMain = Instance.new("Frame")
    tabMain.Size = UDim2.new(1, 0, 1, 0)
    tabMain.BackgroundTransparency = 1
    tabMain.Visible = false
    tabMain.Parent = ContentArea

    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "Container"
    tabContainer.Size = UDim2.new(1, 0, 1, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.ScrollBarThickness = 2
    tabContainer.ScrollBarImageColor3 = Theme.Accent
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.Parent = tabMain

    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 8)
    TabList.Parent = tabContainer

    TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 12)
    end)

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Theme.Background
            b.TextColor3 = Theme.TextSecondary
        end
        tabMain.Visible = true
        tabBtn.BackgroundColor3 = Theme.Accent
        tabBtn.TextColor3 = Theme.Background
    end)

    table.insert(tabs, tabMain)
    table.insert(tabButtons, tabBtn)

    return tabMain, tabContainer, function() updateTabLabel() end
end

local function CreateButton(parentTab, langKeyOrText, callback, isDynamicLang)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 38)
    btn.BackgroundColor3 = Theme.Card
    btn.TextColor3 = Theme.TextPrimary
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = parentTab

    if isDynamicLang then
        RegisterText(btn, langKeyOrText)
        local setTxt = function() btn.Text = "    " .. (Translations[CurrentLang][langKeyOrText] or langKeyOrText) end
        setTxt()
    else
        btn.Text = "    " .. langKeyOrText
    end

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Theme.Border
    btnStroke.Thickness = 1
    btnStroke.Parent = btn

    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- TẠO CÁC TAB CHÍNH
local tabRefreshers = {}
local MainTab, MainTabScroll, ref1 = CreateTab("TabHome", "🏠")
local HopTab, HopTabScroll, ref2 = CreateTab("TabHop", "🌐")
local HubsTab, HubsTabScroll, ref3 = CreateTab("TabHubs", "🚀")
local ReportTab, ReportTabScroll, ref4 = CreateTab("TabReport", "💬")
local SettingTab, SettingTabScroll, ref5 = CreateTab("TabSetting", "⚙")
table.insert(tabRefreshers, ref1)
table.insert(tabRefreshers, ref2)
table.insert(tabRefreshers, ref3)
table.insert(tabRefreshers, ref4)
table.insert(tabRefreshers, ref5)

tabs[1].Visible = true
tabButtons[1].BackgroundColor3 = Theme.Accent
tabButtons[1].TextColor3 = Theme.Background

-- TAB 1: TỔNG QUAN
local WelcomeCard = Instance.new("Frame")
WelcomeCard.Size = UDim2.new(1, -4, 0, 105)
WelcomeCard.BackgroundColor3 = Theme.Card
WelcomeCard.BorderSizePixel = 0
WelcomeCard.Parent = MainTabScroll

local UICornerWel = Instance.new("UICorner")
UICornerWel.CornerRadius = UDim.new(0, 12)
UICornerWel.Parent = WelcomeCard

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Theme.Border
CardStroke.Thickness = 1
CardStroke.Parent = WelcomeCard

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 65, 0, 65)
AvatarImage.Position = UDim2.new(0, 14, 0.5, -32)
AvatarImage.BackgroundColor3 = Theme.Background
AvatarImage.Image = "rbxassetid://109678706275787"
AvatarImage.BorderSizePixel = 0
AvatarImage.Parent = WelcomeCard

local UICornerAvatar = Instance.new("UICorner")
UICornerAvatar.CornerRadius = UDim.new(1, 0)
UICornerAvatar.Parent = AvatarImage

local DisplayNameLabel = Instance.new("TextLabel")
DisplayNameLabel.Size = UDim2.new(1, -95, 0, 18)
DisplayNameLabel.Position = UDim2.new(0, 90, 0, 14)
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.TextColor3 = Theme.TextPrimary
DisplayNameLabel.TextSize = 12
DisplayNameLabel.Font = Enum.Font.GothamBold
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.Text = LocalPlayer.DisplayName
DisplayNameLabel.Parent = WelcomeCard

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(1, -95, 0, 16)
UsernameLabel.Position = UDim2.new(0, 90, 0, 32)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.TextColor3 = Theme.TextSecondary
UsernameLabel.TextSize = 10
UsernameLabel.Font = Enum.Font.Gotham
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Text = "@" .. LocalPlayer.Name .. " • NICE V1"
UsernameLabel.Parent = WelcomeCard

-- HIỂN THỊ RANK
local UserRankLabel = Instance.new("TextLabel")
UserRankLabel.Size = UDim2.new(1, -95, 0, 48)
UserRankLabel.Position = UDim2.new(0, 90, 0, 50)
UserRankLabel.BackgroundTransparency = 1
UserRankLabel.TextSize = 10
UserRankLabel.Font = Enum.Font.GothamBold
UserRankLabel.TextXAlignment = Enum.TextXAlignment.Left
UserRankLabel.TextWrapped = true
UserRankLabel.Parent = WelcomeCard

local function UpdateUserRankDisplay()
    local userRole = UserRanks[currentUserName]
    
    if userRole == "ADMIN" then
        UserRankLabel.Text = "RANK: ADMIN 👑"
        UserRankLabel.TextColor3 = Theme.Gold
    elseif userRole == "CREATOR" then
        UserRankLabel.Text = "RANK: Contents Creators 👑"
        UserRankLabel.TextColor3 = Theme.Accent
    else
        UserRankLabel.Text = "UNLOCK Contents Creators / Admin\n- 1k fl\n- nội dung sạch tất cả điều hiện"
        UserRankLabel.TextColor3 = Theme.TextSecondary
    end
end

UpdateUserRankDisplay()

-- TAB 2: HOP SERVER
local HopConfigFrame = Instance.new("Frame")
HopConfigFrame.Size = UDim2.new(1, -4, 0, 42)
HopConfigFrame.BackgroundColor3 = Theme.Card
HopConfigFrame.BorderSizePixel = 0
HopConfigFrame.Parent = HopTabScroll

local UICornerHopConfig = Instance.new("UICorner")
UICornerHopConfig.CornerRadius = UDim.new(0, 10)
UICornerHopConfig.Parent = HopConfigFrame

local MaxPlayersLabel = Instance.new("TextLabel")
MaxPlayersLabel.Size = UDim2.new(0.65, 0, 1, 0)
MaxPlayersLabel.Position = UDim2.new(0, 12, 0, 0)
MaxPlayersLabel.BackgroundTransparency = 1
MaxPlayersLabel.TextColor3 = Theme.TextPrimary
MaxPlayersLabel.TextSize = 10
MaxPlayersLabel.Font = Enum.Font.GothamMedium
MaxPlayersLabel.TextXAlignment = Enum.TextXAlignment.Left
MaxPlayersLabel.Parent = HopConfigFrame
RegisterText(MaxPlayersLabel, "MaxPlayers")

local MaxPlayersBox = Instance.new("TextBox")
MaxPlayersBox.Size = UDim2.new(0, 44, 0, 24)
MaxPlayersBox.Position = UDim2.new(1, -54, 0.5, -12)
MaxPlayersBox.BackgroundColor3 = Theme.Background
MaxPlayersBox.TextColor3 = Theme.Accent
MaxPlayersBox.Font = Enum.Font.GothamBold
MaxPlayersBox.TextSize = 10
MaxPlayersBox.Text = "1"
MaxPlayersBox.BorderSizePixel = 0
MaxPlayersBox.Parent = HopConfigFrame

local UICornerBox = Instance.new("UICorner")
UICornerBox.CornerRadius = UDim.new(0, 6)
UICornerBox.Parent = MaxPlayersBox

CreateButton(HopTabScroll, "HopLow", function(btn)
    btn.Text = "    " .. Translations[CurrentLang]["Scanning"]
    pcall(function()
        local maxAllowed = tonumber(MaxPlayersBox.Text) or 1
        local validServers = {}
        local cursor = ""
        for page = 1, 5 do
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            if cursor ~= "" then url = url .. "&cursor=" .. cursor end
            local success, result = pcall(function() return game:HttpGet(url) end)
            if success then
                local data = HttpService:JSONDecode(result)
                if data and data.data then
                    for _, s in ipairs(data.data) do
                        if s.playing and s.playing <= maxAllowed and s.playing >= 1 and s.id ~= game.JobId then
                            table.insert(validServers, s.id)
                        end
                    end
                    if data.nextPageCursor then cursor = data.nextPageCursor else break end
                else break end
            else break end
            task.wait(0.1)
        end

        if #validServers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, validServers[math.random(1, #validServers)], LocalPlayer)
        else
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
end, true)

CreateButton(HopTabScroll, "Rejoin", function()
    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
end, true)

-- TAB 3: SCRIPT HUBS
local GameSelectionFrame = Instance.new("Frame")
GameSelectionFrame.Size = UDim2.new(1, 0, 1, 0)
GameSelectionFrame.BackgroundTransparency = 1
GameSelectionFrame.Parent = HubsTabScroll

local SelectionList = Instance.new("UIListLayout")
SelectionList.SortOrder = Enum.SortOrder.LayoutOrder
SelectionList.Padding = UDim.new(0, 8)
SelectionList.Parent = GameSelectionFrame

local SubCategoryFrame = Instance.new("Frame")
SubCategoryFrame.Size = UDim2.new(1, 0, 1, 0)
SubCategoryFrame.BackgroundTransparency = 1
SubCategoryFrame.Visible = false
SubCategoryFrame.Parent = HubsTab

local SubList = Instance.new("UIListLayout")
SubList.SortOrder = Enum.SortOrder.LayoutOrder
SubList.Padding = UDim.new(0, 8)
SubList.Parent = SubCategoryFrame

local BackToGamesBtn = Instance.new("TextButton")
BackToGamesBtn.Size = UDim2.new(1, -4, 0, 32)
BackToGamesBtn.BackgroundColor3 = Theme.TopCard
BackToGamesBtn.TextColor3 = Theme.Accent
BackToGamesBtn.Font = Enum.Font.GothamBold
BackToGamesBtn.TextSize = 10
BackToGamesBtn.Text = "⬅ Trở Lại Danh Sách Game"
BackToGamesBtn.BorderSizePixel = 0
BackToGamesBtn.Parent = SubCategoryFrame

local UICornerBackGames = Instance.new("UICorner")
UICornerBackGames.CornerRadius = UDim.new(0, 8)
UICornerBackGames.Parent = BackToGamesBtn

BackToGamesBtn.MouseButton1Click:Connect(function()
    SubCategoryFrame.Visible = false
    GameSelectionFrame.Visible = true
end)

local BtnNoKeyOption = CreateButton(SubCategoryFrame, "🔓 STEAL AN EGG (NO KEY)", function() end, false)
local BtnKeyOption = CreateButton(SubCategoryFrame, "🔑 STEAL AN EGG (KEY)", function() end, false)

-- KHU VỰC NO KEY
local NoKeyFrame = Instance.new("Frame")
NoKeyFrame.Size = UDim2.new(1, 0, 1, 0)
NoKeyFrame.BackgroundTransparency = 1
NoKeyFrame.Visible = false
NoKeyFrame.Parent = HubsTab

local BackToSubBtn1 = Instance.new("TextButton")
BackToSubBtn1.Size = UDim2.new(1, -4, 0, 32)
BackToSubBtn1.BackgroundColor3 = Theme.TopCard
BackToSubBtn1.TextColor3 = Theme.Accent
BackToSubBtn1.Font = Enum.Font.GothamBold
BackToSubBtn1.TextSize = 10
BackToSubBtn1.Text = "⬅ Trở Lại Tùy Chọn Key / No Key"
BackToSubBtn1.BorderSizePixel = 0
BackToSubBtn1.Parent = NoKeyFrame

local UICornerBackSub1 = Instance.new("UICorner")
UICornerBackSub1.CornerRadius = UDim.new(0, 8)
UICornerBackSub1.Parent = BackToSubBtn1

BackToSubBtn1.MouseButton1Click:Connect(function()
    NoKeyFrame.Visible = false
    SubCategoryFrame.Visible = true
end)

local SearchNoKeyFrame = Instance.new("Frame")
SearchNoKeyFrame.Size = UDim2.new(1, -4, 0, 32)
SearchNoKeyFrame.Position = UDim2.new(0, 0, 0, 38)
SearchNoKeyFrame.BackgroundColor3 = Theme.Card
SearchNoKeyFrame.BorderSizePixel = 0
SearchNoKeyFrame.Parent = NoKeyFrame

local UICornerSearch1 = Instance.new("UICorner")
UICornerSearch1.CornerRadius = UDim.new(0, 8)
UICornerSearch1.Parent = SearchNoKeyFrame

local SearchNoKeyBox = Instance.new("TextBox")
SearchNoKeyBox.Size = UDim2.new(1, -16, 1, 0)
SearchNoKeyBox.Position = UDim2.new(0, 8, 0, 0)
SearchNoKeyBox.BackgroundTransparency = 1
SearchNoKeyBox.TextColor3 = Theme.TextPrimary
SearchNoKeyBox.PlaceholderColor3 = Theme.TextSecondary
SearchNoKeyBox.Font = Enum.Font.GothamMedium
SearchNoKeyBox.TextSize = 10
SearchNoKeyBox.Text = ""
SearchNoKeyBox.PlaceholderText = "🔍 Nhập tên Script (No Key)..."
SearchNoKeyBox.TextXAlignment = Enum.TextXAlignment.Left
SearchNoKeyBox.Parent = SearchNoKeyFrame

local NoKeyScroll = Instance.new("ScrollingFrame")
NoKeyScroll.Size = UDim2.new(1, 0, 1, -76)
NoKeyScroll.Position = UDim2.new(0, 0, 0, 76)
NoKeyScroll.BackgroundTransparency = 1
NoKeyScroll.ScrollBarThickness = 2
NoKeyScroll.Parent = NoKeyFrame

local NoKeyList = Instance.new("UIListLayout")
NoKeyList.SortOrder = Enum.SortOrder.LayoutOrder
NoKeyList.Padding = UDim.new(0, 8)
NoKeyList.Parent = NoKeyScroll

NoKeyList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    NoKeyScroll.CanvasSize = UDim2.new(0, 0, 0, NoKeyList.AbsoluteContentSize.Y + 10)
end)

-- KHU VỰC KEY
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(1, 0, 1, 0)
KeyFrame.BackgroundTransparency = 1
KeyFrame.Visible = false
KeyFrame.Parent = HubsTab

local BackToSubBtn2 = Instance.new("TextButton")
BackToSubBtn2.Size = UDim2.new(1, -4, 0, 32)
BackToSubBtn2.BackgroundColor3 = Theme.TopCard
BackToSubBtn2.TextColor3 = Theme.Accent
BackToSubBtn2.Font = Enum.Font.GothamBold
BackToSubBtn2.TextSize = 10
BackToSubBtn2.Text = "⬅ Trở Lại Tùy Chọn Key / No Key"
BackToSubBtn2.BorderSizePixel = 0
BackToSubBtn2.Parent = KeyFrame

local UICornerBackSub2 = Instance.new("UICorner")
UICornerBackSub2.CornerRadius = UDim.new(0, 8)
UICornerBackSub2.Parent = BackToSubBtn2

BackToSubBtn2.MouseButton1Click:Connect(function()
    KeyFrame.Visible = false
    SubCategoryFrame.Visible = true
end)

local SearchKeyFrame = Instance.new("Frame")
SearchKeyFrame.Size = UDim2.new(1, -4, 0, 32)
SearchKeyFrame.Position = UDim2.new(0, 0, 0, 38)
SearchKeyFrame.BackgroundColor3 = Theme.Card
SearchKeyFrame.BorderSizePixel = 0
SearchKeyFrame.Parent = KeyFrame

local UICornerSearch2 = Instance.new("UICorner")
UICornerSearch2.CornerRadius = UDim.new(0, 8)
UICornerSearch2.Parent = SearchKeyFrame

local SearchKeyBox = Instance.new("TextBox")
SearchKeyBox.Size = UDim2.new(1, -16, 1, 0)
SearchKeyBox.Position = UDim2.new(0, 8, 0, 0)
SearchKeyBox.BackgroundTransparency = 1
SearchKeyBox.TextColor3 = Theme.TextPrimary
SearchKeyBox.PlaceholderColor3 = Theme.TextSecondary
SearchKeyBox.Font = Enum.Font.GothamMedium
SearchKeyBox.TextSize = 10
SearchKeyBox.Text = ""
SearchKeyBox.PlaceholderText = "🔍 Nhập tên Script (Key)..."
SearchKeyBox.TextXAlignment = Enum.TextXAlignment.Left
SearchKeyBox.Parent = SearchKeyFrame

local KeyScroll = Instance.new("ScrollingFrame")
KeyScroll.Size = UDim2.new(1, 0, 1, -76)
KeyScroll.Position = UDim2.new(0, 0, 0, 76)
KeyScroll.BackgroundTransparency = 1
KeyScroll.ScrollBarThickness = 2
KeyScroll.Parent = KeyFrame

local KeyList = Instance.new("UIListLayout")
KeyList.SortOrder = Enum.SortOrder.LayoutOrder
KeyList.Padding = UDim.new(0, 8)
KeyList.Parent = KeyScroll

KeyList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    KeyScroll.CanvasSize = UDim2.new(0, 0, 0, KeyList.AbsoluteContentSize.Y + 10)
end)

-- SỰ KIỆN MỞ SUB TAB
CreateButton(GameSelectionFrame, "🥚 STEAL AN EGG", function()
    GameSelectionFrame.Visible = false
    SubCategoryFrame.Visible = true
end, false)

BtnNoKeyOption.MouseButton1Click:Connect(function()
    SubCategoryFrame.Visible = false
    NoKeyFrame.Visible = true
end)

BtnKeyOption.MouseButton1Click:Connect(function()
    SubCategoryFrame.Visible = false
    KeyFrame.Visible = true
end)

-- LIST SCRIPTS NO KEY
local noKeyScriptButtons = {}

local btnAjjan = CreateButton(NoKeyScroll, "AJJAN HUB", function(btn)
    btn.Text = "    " .. Translations[CurrentLang]["Executing"]
    pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/271f96ca25f29ae395be1c0f9e6f4ead.lua"))() end)
    task.wait(0.5)
    btn.Text = "    " .. Translations[CurrentLang]["Executed"]
end, false)
table.insert(noKeyScriptButtons, btnAjjan)

local btnChilly = CreateButton(NoKeyScroll, "CHILLY HUB", function(btn)
    btn.Text = "    " .. Translations[CurrentLang]["Executing"]
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/chilly.lua"))() end)
    task.wait(0.5)
    btn.Text = "    " .. Translations[CurrentLang]["Executed"]
end, false)
table.insert(noKeyScriptButtons, btnChilly)

local btnAris = CreateButton(NoKeyScroll, "ARIS HUB", function(btn)
    btn.Text = "    " .. Translations[CurrentLang]["Executing"]
    pcall(function() loadstring(game:HttpGet("https://vxezestudio.online/api/scripts/script_kfXJrZUcmVdSv/stream/init"))() end)
    task.wait(0.5)
    btn.Text = "    " .. Translations[CurrentLang]["Executed"]
end, false)
table.insert(noKeyScriptButtons, btnAris)

-- LIST SCRIPTS KEY
local keyScriptButtons = {}

-- XỬ LÝ LỌC SCRIPT KHI GÕ TÌM KIẾM
SearchNoKeyBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchNoKeyBox.Text)
    for _, btn in pairs(noKeyScriptButtons) do
        if query == "" then
            btn.Visible = true
        else
            btn.Visible = string.find(string.lower(btn.Text), query) ~= nil
        end
    end
end)

SearchKeyBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchKeyBox.Text)
    for _, btn in pairs(keyScriptButtons) do
        if query == "" then
            btn.Visible = true
        else
            btn.Visible = string.find(string.lower(btn.Text), query) ~= nil
        end
    end
end)

-- TAB 4: TRỢ GIÚP
CreateButton(ReportTabScroll, "ReportBtn", function(btn)
    pcall(function() if setclipboard then setclipboard("https://www.tiktok.com/@nice001hi") end end)
    btn.Text = "    " .. Translations[CurrentLang]["ReportSuccess"]
    task.wait(2)
    btn.Text = "    " .. Translations[CurrentLang]["ReportBtn"]
end, true)

-- TAB 5: CẤU HÌNH
local LangCard = Instance.new("Frame")
LangCard.Size = UDim2.new(1, -4, 0, 46)
LangCard.BackgroundColor3 = Theme.Card
LangCard.BorderSizePixel = 0
LangCard.Parent = SettingTabScroll

local UICornerLangCard = Instance.new("UICorner")
UICornerLangCard.CornerRadius = UDim.new(0, 10)
UICornerLangCard.Parent = LangCard

local LangTitle = Instance.new("TextLabel")
LangTitle.Size = UDim2.new(0.55, 0, 1, 0)
LangTitle.Position = UDim2.new(0, 12, 0, 0)
LangTitle.BackgroundTransparency = 1
LangTitle.TextColor3 = Theme.TextPrimary
LangTitle.TextSize = 10
LangTitle.Font = Enum.Font.GothamBold
LangTitle.TextXAlignment = Enum.TextXAlignment.Left
LangTitle.Parent = LangCard
RegisterText(LangTitle, "LangTitle")

local BtnVIE = Instance.new("TextButton")
BtnVIE.Size = UDim2.new(0, 48, 0, 24)
BtnVIE.Position = UDim2.new(1, -108, 0.5, -12)
BtnVIE.BackgroundColor3 = Theme.Accent
BtnVIE.TextColor3 = Theme.Background
BtnVIE.Font = Enum.Font.GothamBold
BtnVIE.TextSize = 10
BtnVIE.Text = "VIE 🇻🇳"
BtnVIE.BorderSizePixel = 0
BtnVIE.Parent = LangCard

local UICornerVIE = Instance.new("UICorner")
UICornerVIE.CornerRadius = UDim.new(0, 6)
UICornerVIE.Parent = BtnVIE

local BtnENG = Instance.new("TextButton")
BtnENG.Size = UDim2.new(0, 48, 0, 24)
BtnENG.Position = UDim2.new(1, -54, 0.5, -12)
BtnENG.BackgroundColor3 = Theme.Background
BtnENG.TextColor3 = Theme.TextSecondary
BtnENG.Font = Enum.Font.GothamBold
BtnENG.TextSize = 10
BtnENG.Text = "ENG 🇺🇸"
BtnENG.BorderSizePixel = 0
BtnENG.Parent = LangCard

local UICornerENG = Instance.new("UICorner")
UICornerENG.CornerRadius = UDim.new(0, 6)
UICornerENG.Parent = BtnENG

local function ApplyLangChange(lang)
    UpdateLanguage(lang)
    for _, rf in ipairs(tabRefreshers) do rf() end
    if lang == "VIE" then
        BtnVIE.BackgroundColor3 = Theme.Accent
        BtnVIE.TextColor3 = Theme.Background
        BtnENG.BackgroundColor3 = Theme.Background
        BtnENG.TextColor3 = Theme.TextSecondary
    else
        BtnENG.BackgroundColor3 = Theme.Accent
        BtnENG.TextColor3 = Theme.Background
        BtnVIE.BackgroundColor3 = Theme.Background
        BtnVIE.TextColor3 = Theme.TextSecondary
    end
end

BtnVIE.MouseButton1Click:Connect(function() ApplyLangChange("VIE") end)
BtnENG.MouseButton1Click:Connect(function() ApplyLangChange("ENG") end)

local InfoCard = Instance.new("Frame")
InfoCard.Size = UDim2.new(1, -4, 0, 46)
InfoCard.BackgroundColor3 = Theme.Card
InfoCard.BorderSizePixel = 0
InfoCard.Parent = SettingTabScroll

local UICornerInfoCard = Instance.new("UICorner")
UICornerInfoCard.CornerRadius = UDim.new(0, 10)
UICornerInfoCard.Parent = InfoCard

local UpdateInfoTitle = Instance.new("TextLabel")
UpdateInfoTitle.Size = UDim2.new(1, -20, 0, 18)
UpdateInfoTitle.Position = UDim2.new(0, 12, 0, 4)
UpdateInfoTitle.BackgroundTransparency = 1
UpdateInfoTitle.TextColor3 = Theme.TextPrimary
UpdateInfoTitle.TextSize = 10
UpdateInfoTitle.Font = Enum.Font.GothamBold
UpdateInfoTitle.TextXAlignment = Enum.TextXAlignment.Left
UpdateInfoTitle.Parent = InfoCard
RegisterText(UpdateInfoTitle, "InfoTitle")

local UpdateStatusLabel = Instance.new("TextLabel")
UpdateStatusLabel.Size = UDim2.new(1, -20, 0, 16)
UpdateStatusLabel.Position = UDim2.new(0, 12, 0, 24)
UpdateStatusLabel.BackgroundTransparency = 1
UpdateStatusLabel.TextColor3 = Theme.Accent
UpdateStatusLabel.TextSize = 10
UpdateStatusLabel.Font = Enum.Font.GothamMedium
UpdateStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
UpdateStatusLabel.Parent = InfoCard
RegisterText(UpdateStatusLabel, "InfoStatus")

CreateButton(SettingTabScroll, "FixLagBtn", function(btn)
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 0
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("Sky") then 
                v.Enabled = false 
            end
        end
    end)

    for _, v in ipairs(workspace:GetDescendants()) do
        pcall(function()
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end)
    end
    btn.Text = "    " .. Translations[CurrentLang]["FixLagSuccess"]
end, true)
