local randomDelay = math.random(5, 12)
task.wait(randomDelay)

-- Função de ofuscação de nomes
local function obfuscateName()
    local chars = {"Game", "Ui", "System", "Tool", "Helper", "Manager", "Handler", "Controller"}
    local nums = tostring(math.random(1000, 9999))
    return chars[math.random(#chars)] .. nums
end

-- Nomes aleatórios para componentes
local guiName = obfuscateName()
local mainFrameName = obfuscateName()
local scriptName = obfuscateName()

-- Limpeza ultra-agressiva de sistemas de detecção
pcall(function()
    -- Remove detectores conhecidos
    local detectores = {
        "AntiCheat", "AC", "Detection", "Monitor", "Guard", "Security", 
        "Detector", "Scanner", "Watcher", "Tracker", "Observer", "Logger",
        "Reporter", "Checker", "Validator", "Inspector", "Auditor"
    }
    
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("LocalScript") or obj:IsA("Script") or obj:IsA("ModuleScript") then
            local name = obj.Name:lower()
            for _, detector in pairs(detectores) do
                if name:find(detector:lower()) then
                    task.spawn(function()
                        pcall(function()
                            obj.Disabled = true
                            task.wait(0.1)
                            obj:Destroy()
                        end)
                    end)
                end
            end
        end
    end
    
    -- Remove GUIs suspeitas mais eficientemente
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.PlayerGui then
            for _, gui in pairs(player.PlayerGui:GetChildren()) do
                local name = gui.Name:lower()
                local suspicious = {
                    "admin", "mod", "staff", "detect", "anti", "cheat", 
                    "hack", "exploit", "script", "monitor", "security"
                }
                for _, word in pairs(suspicious) do
                    if name:find(word) then
                        pcall(function() gui:Destroy() end)
                        break
                    end
                end
            end
        end
    end
end)

-- Services com verificação de segurança
local Services = {}
local serviceNames = {
    "Players", "TeleportService", "UserInputService", "TweenService", 
    "RunService", "ReplicatedStorage", "Lighting", "StarterPlayer", "GuiService"
}

for _, serviceName in pairs(serviceNames) do
    pcall(function()
        Services[serviceName] = game:GetService(serviceName)
    end)
end

local player = Services.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

-- Detecção de plataforma
local isMobile = Services.GuiService:IsTenFootInterface() or Services.UserInputService.TouchEnabled

-- === SISTEMA DE CAMUFLAGEM AVANÇADO ===

-- Interface com nomes ofuscados
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = player.PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Container Principal com camuflagem aprimorada - Ajustado para mobile
local MainFrame = Instance.new("Frame")
MainFrame.Name = mainFrameName
MainFrame.Size = isMobile and UDim2.new(0, 350, 0, 480) or UDim2.new(0, 380, 0, 520)
MainFrame.Position = isMobile and UDim2.new(0, -370, 0.5, -240) or UDim2.new(0, -400, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Sistema de detecção de ameaças
local threatLevel = 0
local maxThreatLevel = 10

local function increaseThreat(amount)
    threatLevel = threatLevel + (amount or 1)
    if threatLevel >= maxThreatLevel then
        threatLevel = 0
    end
end

-- Monitor de atividade suspeita (adaptado para mobile)
local lastMousePos = Vector2.new(0, 0)
local mouseMovements = 0
local keyPresses = 0
local touchInputs = 0

-- Input handling para mobile e PC
if isMobile then
    Services.UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        touchInputs = touchInputs + 1
        
        if touchInputs > 30 then
            increaseThreat(1)
            touchInputs = 0
        end
    end)
else
    Services.UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        
        keyPresses = keyPresses + 1
        
        if keyPresses > 20 then
            increaseThreat(2)
            keyPresses = 0
        end
        
        local suspiciousKeys = {
            Enum.KeyCode.F9, Enum.KeyCode.F10, Enum.KeyCode.F11,
            Enum.KeyCode.Delete, Enum.KeyCode.End, Enum.KeyCode.Home
        }
        
        for _, key in pairs(suspiciousKeys) do
            if input.KeyCode == key then
                increaseThreat(3)
                break
            end
        end
    end)
end

Services.RunService.Heartbeat:Connect(function()
    local currentMousePos = Vector2.new(mouse.X, mouse.Y)
    local distance = (currentMousePos - lastMousePos).Magnitude
    
    if distance > 0 then
        mouseMovements = mouseMovements + 1
    end
    
    lastMousePos = currentMousePos
    
    if mouseMovements > 120 then
        increaseThreat(1)
        mouseMovements = 0
    end
end)

task.spawn(function()
    while true do
        task.wait(10)
        threatLevel = math.max(0, threatLevel - 1)
        keyPresses = math.max(0, keyPresses - 5)
        mouseMovements = math.max(0, mouseMovements - 10)
        touchInputs = math.max(0, touchInputs - 10)
    end
end)

-- Stroke e corner com proteção
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(40, 40, 45)
Stroke.Thickness = 1
Stroke.Transparency = 0.3
Stroke.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

-- Header com proteção aprimorada
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

-- Título normal
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "EcoHub - MiniCity V1.0" .. (isMobile and " 📱" or "")
Title.TextColor3 = Color3.fromRGB(180, 180, 185)
Title.TextSize = isMobile and 14 or 16
Title.Font = Enum.Font.GothamMedium
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Botão Hide
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 30, 0, 30)
HideBtn.Position = UDim2.new(1, -35, 0, 5)
HideBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
HideBtn.Text = "—"
HideBtn.TextColor3 = Color3.fromRGB(160, 160, 165)
HideBtn.TextSize = 14
HideBtn.Font = Enum.Font.Gotham
HideBtn.BorderSizePixel = 0
HideBtn.Parent = Header

local HideBtnCorner = Instance.new("UICorner")
HideBtnCorner.CornerRadius = UDim.new(0, 6)
HideBtnCorner.Parent = HideBtn

-- ScrollFrame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -50)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = isMobile and 8 or 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 65)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Padding = UDim.new(0, 8)
Layout.Parent = ScrollFrame

-- === VARIÁVEIS GLOBAIS COM PROTEÇÃO ===
local gameState = {
    aimEnabled = false,
    aimOnHold = false,
    isMouseHeld = false,
    ignoredPlayers = {},
    playerListVisible = false,
    espEnabled = false,
    espObjects = {},
    circleEnabled = false,
    antiBlurEnabled = false,
    antiStaffEnabled = false,
    savedPosition = nil,
    farmActive = false,
    autoInvisible = true,
    aimRadius = 400,
    teamCheck = true,
    mobileAimEnabled = false,
    mobileAimButton = nil
}

-- Lista de staff atualizada
local staffList = {
    "jake56839ad", "CleitinDoGrau_Eb", "21peteca", "Lucalarte", "SPTmatheus123",
    "GuilhermeDRTgg", "Briessxz", "hardstyless", "Mundaka", "Isabelaaaaafofs",
    "HANRLLEY25", "kaleb_iaee", "brunizoraa", "rip_propleyfran", "pepezicador",
    "Jjhgul", "Dariosantos21048", "JEKER_2009", "tttonas", "MZPlug14k",
    "Dudubeterotv5", "Sargento_admOficial", "Cassiopia84un", "Hakplays", "Cleo_ptr"
}

-- === FUNÇÕES DE CRIAÇÃO COM PROTEÇÃO ===

local function createSection(name)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 25)
    section.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    section.BorderSizePixel = 0
    section.Parent = ScrollFrame
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 4)
    sectionCorner.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(140, 160, 180)
    label.TextSize = isMobile and 11 or 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section
    
    return section
end

local function createToggle(name, desc, callback)
    local toggle = Instance.new("Frame")
    toggle.Size = isMobile and UDim2.new(1, 0, 0, 55) or UDim2.new(1, 0, 0, 50)
    toggle.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    toggle.BorderSizePixel = 0
    toggle.Parent = ScrollFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -60, 0.6, 0)
    nameLabel.Position = UDim2.new(0, 12, 0, 2)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(200, 200, 205)
    nameLabel.TextSize = isMobile and 13 or 14
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = toggle
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -60, 0.4, 0)
    descLabel.Position = UDim2.new(0, 12, 0.6, -2)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(120, 120, 125)
    descLabel.TextSize = isMobile and 10 or 11
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true
    descLabel.Parent = toggle
    
    -- Switch (maior para mobile)
    local switchSize = isMobile and UDim2.new(0, 50, 0, 26) or UDim2.new(0, 45, 0, 22)
    local switch = Instance.new("TextButton")
    switch.Size = switchSize
    switch.Position = UDim2.new(1, -55, 0.5, switchSize.Y.Offset / -2)
    switch.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    switch.Text = ""
    switch.BorderSizePixel = 0
    switch.Parent = toggle
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(0, switchSize.Y.Offset / 2)
    switchCorner.Parent = switch
    
    local indicatorSize = isMobile and 20 or 18
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, indicatorSize, 0, indicatorSize)
    indicator.Position = UDim2.new(0, 3, 0.5, -indicatorSize/2)
    indicator.BackgroundColor3 = Color3.fromRGB(160, 160, 165)
    indicator.BorderSizePixel = 0
    indicator.Parent = switch
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, indicatorSize/2)
    indicatorCorner.Parent = indicator
    
    local enabled = false
    
    switch.MouseButton1Click:Connect(function()
        enabled = not enabled
        
        local targetColor = enabled and Color3.fromRGB(60, 130, 180) or Color3.fromRGB(40, 40, 45)
        local targetPos = enabled and UDim2.new(1, -indicatorSize-3, 0.5, -indicatorSize/2) or UDim2.new(0, 3, 0.5, -indicatorSize/2)
        
        Services.TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        Services.TweenService:Create(indicator, TweenInfo.new(0.2), {Position = targetPos}):Play()
        
        task.spawn(function()
            pcall(callback, enabled)
        end)
    end)
    
    return toggle
end

local function createButton(name, callback)
    local button = Instance.new("TextButton")
    button.Size = isMobile and UDim2.new(1, 0, 0, 45) or UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(180, 180, 185)
    button.TextSize = isMobile and 12 or 13
    button.Font = Enum.Font.Gotham
    button.BorderSizePixel = 0
    button.Parent = ScrollFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        Services.TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 55)}):Play()
        task.wait(0.1)
        Services.TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
        task.spawn(function()
            pcall(callback)
        end)
    end)
    
    return button
end

-- === BOTÃO DE AIMBOT MOBILE ===
local function createMobileAimButton()
    if not isMobile then return end
    
    local aimButton = Instance.new("TextButton")
    aimButton.Size = UDim2.new(0, 80, 0, 80)
    aimButton.Position = UDim2.new(1, -100, 1, -150)
    aimButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    aimButton.Text = "🎯"
    aimButton.TextColor3 = Color3.fromRGB(160, 160, 165)
    aimButton.TextSize = 24
    aimButton.Font = Enum.Font.GothamBold
    aimButton.BorderSizePixel = 0
    aimButton.Parent = ScreenGui
    aimButton.ZIndex = 10
    aimButton.Visible = false
    
    local aimCorner = Instance.new("UICorner")
    aimCorner.CornerRadius = UDim.new(0, 40)
    aimCorner.Parent = aimButton
    
    local aimStroke = Instance.new("UIStroke")
    aimStroke.Color = Color3.fromRGB(60, 60, 65)
    aimStroke.Thickness = 2
    aimStroke.Parent = aimButton
    
    -- Estados do botão
    local function updateButtonState()
        if gameState.aimEnabled then
            aimButton.BackgroundColor3 = Color3.fromRGB(60, 130, 180)
            aimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            aimStroke.Color = Color3.fromRGB(100, 170, 220)
        else
            aimButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            aimButton.TextColor3 = Color3.fromRGB(160, 160, 165)
            aimStroke.Color = Color3.fromRGB(60, 60, 65)
        end
    end
    
    aimButton.MouseButton1Click:Connect(function()
        gameState.aimEnabled = not gameState.aimEnabled
        updateButtonState()
        
        -- Feedback visual
        Services.TweenService:Create(aimButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 75, 0, 75)}):Play()
        task.wait(0.1)
        Services.TweenService:Create(aimButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 80, 0, 80)}):Play()
    end)
    
    gameState.mobileAimButton = aimButton
    updateButtonState()
    
    return aimButton
end

-- === SISTEMA DE LISTA DE JOGADORES CORRIGIDO ===

local PlayerListFrame = nil

local function createPlayerList()
    if PlayerListFrame then
        PlayerListFrame:Destroy()
    end
    
    local listWidth = isMobile and 280 or 300
    local listHeight = isMobile and 350 or 400
    
    PlayerListFrame = Instance.new("Frame")
    PlayerListFrame.Name = obfuscateName()
    PlayerListFrame.Size = UDim2.new(0, listWidth, 0, listHeight)
    PlayerListFrame.Position = isMobile and UDim2.new(0, listWidth + 20, 0.5, -listHeight/2) or UDim2.new(0, 400, 0.5, -200)
    PlayerListFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    PlayerListFrame.BorderSizePixel = 0
    PlayerListFrame.Parent = ScreenGui
    PlayerListFrame.Active = true
    PlayerListFrame.Draggable = true
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 8)
    listCorner.Parent = PlayerListFrame
    
    local listStroke = Instance.new("UIStroke")
    listStroke.Color = Color3.fromRGB(40, 40, 45)
    listStroke.Thickness = 1
    listStroke.Transparency = 0.3
    listStroke.Parent = PlayerListFrame
    
    -- Header da lista
    local listHeader = Instance.new("Frame")
    listHeader.Size = UDim2.new(1, 0, 0, 40)
    listHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    listHeader.BorderSizePixel = 0
    listHeader.Parent = PlayerListFrame
    
    local listHeaderCorner = Instance.new("UICorner")
    listHeaderCorner.CornerRadius = UDim.new(0, 8)
    listHeaderCorner.Parent = listHeader
    
    local listTitle = Instance.new("TextLabel")
    listTitle.Size = UDim2.new(1, -50, 1, 0)
    listTitle.Position = UDim2.new(0, 15, 0, 0)
    listTitle.BackgroundTransparency = 1
    listTitle.Text = "Players - Ignore List"
    listTitle.TextColor3 = Color3.fromRGB(180, 180, 185)
    listTitle.TextSize = isMobile and 13 or 14
    listTitle.Font = Enum.Font.GothamMedium
    listTitle.TextXAlignment = Enum.TextXAlignment.Left
    listTitle.Parent = listHeader
    
    -- Botão fechar
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(160, 160, 165)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.Gotham
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = listHeader
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 6)
    closeBtnCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        gameState.playerListVisible = false
        local targetX = isMobile and (listWidth + 20) or 420
        Services.TweenService:Create(PlayerListFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(0, targetX, 0.5, -listHeight/2)
        }):Play()
        task.wait(0.3)
        if PlayerListFrame then
            PlayerListFrame:Destroy()
            PlayerListFrame = nil
        end
    end)
    
    -- Scroll da lista
    local listScroll = Instance.new("ScrollingFrame")
    listScroll.Size = UDim2.new(1, -10, 1, -50)
    listScroll.Position = UDim2.new(0, 5, 0, 45)
    listScroll.BackgroundTransparency = 1
    listScroll.ScrollBarThickness = isMobile and 8 or 3
    listScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 65)
    listScroll.BorderSizePixel = 0
    listScroll.Parent = PlayerListFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = listScroll
    
    -- Função para criar item do jogador
    local function createPlayerItem(p)
        local playerFrame = Instance.new("Frame")
        playerFrame.Size = isMobile and UDim2.new(1, 0, 0, 65) or UDim2.new(1, 0, 0, 60)
        playerFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
        playerFrame.BorderSizePixel = 0
        playerFrame.Parent = listScroll
        
        local playerCorner = Instance.new("UICorner")
        playerCorner.CornerRadius = UDim.new(0, 6)
        playerCorner.Parent = playerFrame
        
        -- Avatar do jogador
        local avatarSize = isMobile and 45 or 40
        local avatar = Instance.new("ImageLabel")
        avatar.Size = UDim2.new(0, avatarSize, 0, avatarSize)
        avatar.Position = UDim2.new(0, 10, 0.5, -avatarSize/2)
        avatar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        avatar.BorderSizePixel = 0
        avatar.Parent = playerFrame
        
        local avatarCorner = Instance.new("UICorner")
        avatarCorner.CornerRadius = UDim.new(0, avatarSize/2)
        avatarCorner.Parent = avatar
        
        -- Carrega avatar
        pcall(function()
            local userId = p.UserId
            avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=150&height=150&format=png"
        end)
        
        -- Nome do jogador
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -140, 0.6, 0)
        nameLabel.Position = UDim2.new(0, avatarSize + 20, 0, 5)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = p.Name
        nameLabel.TextColor3 = Color3.fromRGB(200, 200, 205)
        nameLabel.TextSize = isMobile and 12 or 13
        nameLabel.Font = Enum.Font.GothamMedium
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        nameLabel.Parent = playerFrame
        
        -- ID do jogador
        local idLabel = Instance.new("TextLabel")
        idLabel.Size = UDim2.new(1, -140, 0.4, 0)
        idLabel.Position = UDim2.new(0, avatarSize + 20, 0.6, -5)
        idLabel.BackgroundTransparency = 1
        idLabel.Text = "ID: " .. p.UserId
        idLabel.TextColor3 = Color3.fromRGB(120, 120, 125)
        idLabel.TextSize = isMobile and 9 or 10
        idLabel.Font = Enum.Font.Gotham
        idLabel.TextXAlignment = Enum.TextXAlignment.Left
        idLabel.Parent = playerFrame
        
        -- Botão ignore (maior para mobile)
        local btnWidth = isMobile and 75 or 70
        local btnHeight = isMobile and 28 or 25
        local ignoreBtnCorner = Instance.new("UICorner")
        ignoreBtnCorner.CornerRadius = UDim.new(0, 4)
        ignoreBtnCorner.Parent = ignoreBtn
        
        ignoreBtn.MouseButton1Click:Connect(function()
            if gameState.ignoredPlayers[p.UserId] then
                gameState.ignoredPlayers[p.UserId] = nil
                ignoreBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 180)
                ignoreBtn.Text = "Ignore"
            else
                gameState.ignoredPlayers[p.UserId] = true
                ignoreBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
                ignoreBtn.Text = "Unignore"
            end
        end)
        
        return playerFrame
    end
    
    -- Popula lista com jogadores atuais
    for _, p in pairs(Services.Players:GetPlayers()) do
        if p ~= player then
            createPlayerItem(p)
        end
    end
    
    -- Atualiza scroll
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        listScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- Monitora novos jogadores
    local playerAddedConnection
    playerAddedConnection = Services.Players.PlayerAdded:Connect(function(p)
        if PlayerListFrame and PlayerListFrame.Parent then
            createPlayerItem(p)
        else
            playerAddedConnection:Disconnect()
        end
    end)
    
    -- Monitora jogadores saindo
    local playerRemovingConnection
    playerRemovingConnection = Services.Players.PlayerRemoving:Connect(function(p)
        if PlayerListFrame and PlayerListFrame.Parent then
            for _, child in pairs(listScroll:GetChildren()) do
                if child:IsA("Frame") and child:FindFirstChild("TextLabel") then
                    local nameLabel = child:FindFirstChild("TextLabel")
                    if nameLabel and nameLabel.Text == p.Name then
                        child:Destroy()
                        break
                    end
                end
            end
        else
            playerRemovingConnection:Disconnect()
        end
    end)
    
    -- Animação de entrada
    local targetX = isMobile and 20 or 400
    Services.TweenService:Create(PlayerListFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, targetX, 0.5, -listHeight/2)
    }):Play()
    
    return PlayerListFrame
end

-- === SISTEMA ESP CORRIGIDO COM VERIFICAÇÃO DE TIME ===

local function getTeamColor(p)
    pcall(function()
        if p.Team and p.Team.TeamColor then
            return p.Team.TeamColor.Color
        end
    end)
    -- Cor padrão para jogadores sem team
    return Color3.fromRGB(255, 255, 255)
end

local function isSameTeam(p1, p2)
    if not gameState.teamCheck then return false end
    
    -- Se ambos têm team e são do mesmo team
    if p1.Team and p2.Team and p1.Team == p2.Team then
        return true
    end
    
    return false
end

local function createAdvancedESP(p)
    if not p.Character then return end
    
    local character = p.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    
    if not rootPart or not humanoid then return end
    
    -- Verifica se é do mesmo team
    local sameTeam = isSameTeam(player, p)
    local teamColor = getTeamColor(p)
    
    -- Highlight com cor do time
    local highlight = Instance.new("Highlight")
    highlight.Parent = character
    highlight.Adornee = character
    highlight.Name = obfuscateName()
    
    -- Cores diferentes para teams
    if sameTeam then
        -- Team aliado - verde
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineTransparency = 0.3
    else
        -- Team inimigo ou sem team - usar cor do team ou vermelho
        if p.Team then
            highlight.FillColor = teamColor
            highlight.OutlineColor = teamColor
        else
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(200, 0, 0)
        end
        highlight.FillTransparency = 0.8
        highlight.OutlineTransparency = 0.5
    end
    
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    -- Billboard com informações do team e distância (ajustado para mobile)
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = character:FindFirstChild("Head") or rootPart
    billboard.Size = isMobile and UDim2.new(0, 140, 0, 65) or UDim2.new(0, 150, 0, 70)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Name = obfuscateName()
    
    -- Frame principal do billboard
    local billboardFrame = Instance.new("Frame")
    billboardFrame.Size = UDim2.new(1, 0, 1, 0)
    billboardFrame.BackgroundTransparency = 1
    billboardFrame.Parent = billboard
    
    -- Nome do jogador
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = billboardFrame
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = p.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = isMobile and 13 or 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextScaled = true
    
    -- Team do jogador
    local teamLabel = Instance.new("TextLabel")
    teamLabel.Parent = billboardFrame
    teamLabel.Size = UDim2.new(1, 0, 0.3, 0)
    teamLabel.Position = UDim2.new(0, 0, 0.4, 0)
    teamLabel.BackgroundTransparency = 1
    teamLabel.Text = p.Team and ("[" .. p.Team.Name .. "]") or "[No Team]"
    teamLabel.TextColor3 = sameTeam and Color3.fromRGB(0, 255, 0) or (p.Team and teamColor or Color3.fromRGB(255, 255, 255))
    teamLabel.TextSize = isMobile and 11 or 12
    teamLabel.Font = Enum.Font.Gotham
    teamLabel.TextStrokeTransparency = 0.7
    teamLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    teamLabel.TextScaled = true
    
    -- Distância do jogador
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Parent = billboardFrame
    distanceLabel.Size = UDim2.new(1, 0, 0.3, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.7, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = "0m"
    distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distanceLabel.TextSize = isMobile and 9 or 10
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.TextStrokeTransparency = 0.7
    distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distanceLabel.TextScaled = true
    
    gameState.espObjects[p] = {highlight, billboard, distanceLabel}
    
    -- Atualiza cor quando o team muda
    local teamConnection
    teamConnection = p:GetPropertyChangedSignal("Team"):Connect(function()
        if highlight and highlight.Parent then
            local newSameTeam = isSameTeam(player, p)
            local newTeamColor = getTeamColor(p)
            
            if newSameTeam then
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
                teamLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                if p.Team then
                    highlight.FillColor = newTeamColor
                    highlight.OutlineColor = newTeamColor
                    teamLabel.TextColor3 = newTeamColor
                else
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(200, 0, 0)
                    teamLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            
            teamLabel.Text = p.Team and ("[" .. p.Team.Name .. "]") or "[No Team]"
        else
            teamConnection:Disconnect()
        end
    end)
    
    -- Atualiza distância
    local distanceConnection
    distanceConnection = Services.RunService.Heartbeat:Connect(function()
        if billboard and billboard.Parent and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (rootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            distanceLabel.Text = math.floor(distance) .. "m"
        else
            distanceConnection:Disconnect()
        end
    end)
end

local function removeESP(p)
    if gameState.espObjects[p] then
        for _, obj in pairs(gameState.espObjects[p]) do
            if obj then 
                pcall(function()
                    obj:Destroy()
                end)
            end
        end
        gameState.espObjects[p] = nil
    end
end

-- === SISTEMA AIMBOT MELHORADO PARA MOBILE E PC ===

-- Detecção do botão do mouse/touch
if isMobile then
    -- Para mobile, usa o botão de aimbot
    -- O estado já é controlado pelo botão mobile
else
    -- Para PC, detecta clique do mouse
    Services.UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            gameState.isMouseHeld = true
        end
    end)

    Services.UserInputService.InputEnded:Connect(function(input, processed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            gameState.isMouseHeld = false
        end
    end)
end

-- Função melhorada para encontrar jogador mais próximo
local function getClosestValidPlayer()
    local closest = nil
    local shortestDistance = math.huge
    local playerPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if not playerPosition then return nil end
    
    for _, p in pairs(Services.Players:GetPlayers()) do
        if p ~= player and not gameState.ignoredPlayers[p.UserId] and p.Character then
            local character = p.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local head = character:FindFirstChild("Head")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and head and rootPart then
                -- Verifica se é do mesmo team e se deve ignorar
                if gameState.teamCheck and isSameTeam(player, p) then
                    continue -- Pula jogadores do mesmo team
                end
                
                -- Calcula distância 3D real
                local worldDistance = (rootPart.Position - playerPosition.Position).Magnitude
                
                -- Só considera jogadores dentro do raio máximo
                if worldDistance > gameState.aimRadius then
                    continue
                end
                
                -- Calcula posição na tela
                local screenPos, onScreen = camera:WorldToScreenPoint(head.Position)
                
                if onScreen then
                    local mousePos = Vector2.new(mouse.X, mouse.Y)
                    local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
                    local screenDistance = (screenPoint - mousePos).Magnitude
                    
                    -- Raio dinâmico baseado na distância (maior para mobile)
                    local baseRadius = isMobile and 400 or 300
                    local maxScreenRadius = math.clamp(baseRadius / (worldDistance / 50), 120, 500)
                    
                    if screenDistance < maxScreenRadius and worldDistance < shortestDistance then
                        closest = p
                        shortestDistance = worldDistance
                    end
                end
            end
        end
    end
    
    return closest
end

-- Aimbot melhorado e mais preciso (funciona em mobile e PC)
local aimSmoothness = isMobile and 0.15 or 0.12
local lastAimTime = 0
local aimVariation = 0
local targetHistory = {}

local function aimAtTarget()
    if not gameState.aimEnabled then return end
    
    -- Para mobile: sempre ativo quando enabled
    -- Para PC: verifica se deve mirar (botão pressionado ou modo contínuo)
    if not isMobile and not gameState.aimOnHold and not gameState.isMouseHeld then return end
    
    local currentTime = tick()
    if currentTime - lastAimTime < 0.013 then return end -- ~75 FPS
    lastAimTime = currentTime
    
    local target = getClosestValidPlayer()
    if not target or not target.Character then return end
    
    local character = target.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local head = character:FindFirstChild("Head")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or humanoid.Health <= 0 or not head or not rootPart then return end
    
    -- Predição de movimento simples
    local targetVelocity = rootPart.AssemblyLinearVelocity or Vector3.new(0, 0, 0)
    local distance = (rootPart.Position - camera.CFrame.Position).Magnitude
    local timeToHit = distance / 500 -- Velocidade aproximada de projétil
    local predictedPosition = head.Position + (targetVelocity * timeToHit * 0.3)
    
    -- Variação humanizada (mais suave para mobile)
    aimVariation = aimVariation + (math.random(-50, 50) / (isMobile and 15000 or 10000))
    aimVariation = math.clamp(aimVariation, -0.003, 0.003)
    
    local humanOffset = Vector3.new(
        math.sin(currentTime * 1.8) * aimVariation,
        math.cos(currentTime * 1.3) * aimVariation,
        math.sin(currentTime * 0.9) * aimVariation * 0.5
    )
    
    local finalTarget = predictedPosition + humanOffset
    local cameraPosition = camera.CFrame.Position
    local direction = (finalTarget - cameraPosition).Unit
    local newCFrame = CFrame.lookAt(cameraPosition, cameraPosition + direction)
    
    -- Suavização adaptativa (mais suave para mobile)
    local baseSmoothness = isMobile and 0.15 or 0.12
    local adaptiveSmoothness = math.clamp(baseSmoothness * (distance / 80), 0.08, isMobile and 0.3 or 0.25)
    
    -- Aplica o aimbot
    camera.CFrame = camera.CFrame:Lerp(newCFrame, adaptiveSmoothness)
    
    -- Histórico de alvos para consistência
    table.insert(targetHistory, target)
    if #targetHistory > 5 then
        table.remove(targetHistory, 1)
    end
end

-- === SISTEMA ANTI-BLUR MELHORADO ===

local function setupAntiBlur()
    if not gameState.antiBlurEnabled then return end
    
    pcall(function()
        local lighting = Services.Lighting
        
        -- Remove efeitos existentes
        for _, effect in pairs(lighting:GetChildren()) do
            if effect:IsA("BlurEffect") or effect:IsA("DepthOfFieldEffect") or effect:IsA("ColorCorrectionEffect") then
                task.spawn(function()
                    effect.Enabled = false
                    task.wait(0.1)
                    if effect.Parent then
                        effect:Destroy()
                    end
                end)
            end
        end
        
        -- Monitor contínuo
        lighting.ChildAdded:Connect(function(child)
            if gameState.antiBlurEnabled then
                task.spawn(function()
                    if child:IsA("BlurEffect") or child:IsA("DepthOfFieldEffect") or child:IsA("ColorCorrectionEffect") then
                        child.Enabled = false
                        task.wait(0.1)
                        if child.Parent then
                            child:Destroy()
                        end
                    end
                end)
            end
        end)
    end)
end

-- === CÍRCULO DE MIRA ULTRA-DISCRETO ===

local crosshairGui = nil
local function createCrosshair()
    if crosshairGui then
        crosshairGui:Destroy()
    end
    
    crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = obfuscateName()
    crosshairGui.Parent = player.PlayerGui
    crosshairGui.ResetOnSpawn = false
    crosshairGui.IgnoreGuiInset = true
    crosshairGui.DisplayOrder = 10
    
    local circleSize = isMobile and 6 or 4
    local circle = Instance.new("Frame")
    circle.Name = obfuscateName()
    circle.Size = UDim2.new(0, circleSize, 0, circleSize)
    circle.Position = UDim2.new(0.5, -circleSize/2, 0.5, -circleSize/2)
    circle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    circle.BackgroundTransparency = 0.4
    circle.BorderSizePixel = 0
    circle.Parent = crosshairGui
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle
    
    -- Animação sutil
    task.spawn(function()
        while crosshairGui and crosshairGui.Parent do
            circle.BackgroundTransparency = 0.4
            task.wait(math.random(3, 8))
            circle.BackgroundTransparency = 0.6
            task.wait(0.1)
        end
    end)
    
    return crosshairGui
end

-- === SISTEMA ANTI-STAFF MELHORADO ===

local function checkForStaff()
    if not gameState.antiStaffEnabled then return end
    
    pcall(function()
        for _, p in pairs(Services.Players:GetPlayers()) do
            if p ~= player then
                local playerName = p.Name:lower()
                for _, staffName in pairs(staffList) do
                    if playerName == staffName:lower() or playerName:find(staffName:lower()) then
                        task.wait(math.random(2, 5))
                        Services.TeleportService:Teleport(game.PlaceId)
                        return
                    end
                end
                
                -- Verifica grupos suspeitos
                pcall(function()
                    if p:IsInGroup(1) then
                        increaseThreat(5)
                    end
                end)
            end
        end
    end)
end

-- === CRIAR INTERFACE CORRIGIDA ===

createSection("🎯 Combat System" .. (isMobile and " 📱" or ""))

createToggle("Smart Aimbot", "Aimbot inteligente focado em jogadores próximos", function(state)
    gameState.aimEnabled = state
    
    -- Para mobile, mostra/esconde o botão de aimbot
    if isMobile and gameState.mobileAimButton then
        gameState.mobileAimButton.Visible = state
        if state then
            Services.TweenService:Create(gameState.mobileAimButton, TweenInfo.new(0.3), {
                Position = UDim2.new(1, -100, 1, -150)
            }):Play()
        else
            Services.TweenService:Create(gameState.mobileAimButton, TweenInfo.new(0.3), {
                Position = UDim2.new(1, -100, 1, -80)
            }):Play()
        end
    end
end)

if not isMobile then
    createToggle("Hold Mode", "Aimbot apenas quando segura botão esquerdo", function(state)
        gameState.aimOnHold = not state -- Inverte para que true = contínuo
    end)
end

createToggle("Team Check", "Ignora jogadores do mesmo time", function(state)
    gameState.teamCheck = state
end)

createButton("Player Ignore List", function()
    if not gameState.playerListVisible then
        gameState.playerListVisible = true
        createPlayerList()
    else
        gameState.playerListVisible = false
        if PlayerListFrame then
            local listWidth = isMobile and 280 or 300
            local listHeight = isMobile and 350 or 400
            local targetX = isMobile and (listWidth + 20) or 420
            Services.TweenService:Create(PlayerListFrame, TweenInfo.new(0.3), {
                Position = UDim2.new(0, targetX, 0.5, -listHeight/2)
            }):Play()
            task.wait(0.3)
            PlayerListFrame:Destroy()
            PlayerListFrame = nil
        end
    end
end)

createToggle("Crosshair", "Mira discreta no centro da tela", function(state)
    gameState.circleEnabled = state
    if state then
        if crosshairGui then
            crosshairGui:Destroy()
            crosshairGui = nil
        end
        createCrosshair()
    else
        if crosshairGui then
            crosshairGui:Destroy()
            crosshairGui = nil
        end
    end
end)

createSection("👁️ Visual System")

createToggle("Team ESP", "ESP com cores de time e distância", function(state)
    gameState.espEnabled = state
    if not state then
        -- Remove todos os ESPs
        for p, _ in pairs(gameState.espObjects) do
            removeESP(p)
        end
    end
end)

createToggle("Anti-Blur", "Remove todos os efeitos de blur", function(state)
    gameState.antiBlurEnabled = state
    if state then
        setupAntiBlur()
    end
end)

createSection("🛡️ Protection")

createToggle("Staff Detection", "Detecta staff e muda servidor automaticamente", function(state)
    gameState.antiStaffEnabled = state
end)

createToggle("Threat Monitor", "Monitor de ameaças em tempo real", function(state)
    -- Sem print para não aparecer no F9
end)

createSection("⚙️ Settings")

createButton("Aimbot Range: " .. gameState.aimRadius .. "m", function()
    if gameState.aimRadius == 400 then
        gameState.aimRadius = 600
    elseif gameState.aimRadius == 600 then
        gameState.aimRadius = 800
    elseif gameState.aimRadius == 800 then
        gameState.aimRadius = 200
    else
        gameState.aimRadius = 400
    end
    
    -- Atualiza o texto do botão
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Text:find("Aimbot Range") then
            child.Text = "Aimbot Range: " .. gameState.aimRadius .. "m"
            break
        end
    end
end)

createSection("⚡ Performance")

createButton("Server Hop", function()
    task.spawn(function()
        Services.TeleportService:Teleport(game.PlaceId)
    end)
end)

createButton("Deep Clean", function()
    pcall(function()
        settings().Rendering.QualityLevel = 1
        workspace.StreamingEnabled = true
        
        for i = 1, 3 do
            collectgarbage("collect")
            task.wait(0.1)
        end
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Explosion") or obj:IsA("Fire") or obj:IsA("Smoke") then
                obj:Destroy()
            end
        end
    end)
end)

-- === CRIAR BOTÃO MOBILE SE NECESSÁRIO ===
if isMobile then
    createMobileAimButton()
end

-- === LOOPS PRINCIPAIS PROTEGIDOS ===

-- Aimbot Loop Otimizado
local aimConnection = Services.RunService.Heartbeat:Connect(function()
    task.spawn(function()
        pcall(aimAtTarget)
    end)
end)

-- ESP Loop melhorado com verificação de time
Services.RunService.Heartbeat:Connect(function()
    if not gameState.espEnabled then 
        -- Remove ESPs se desabilitado
        for p, _ in pairs(gameState.espObjects) do
            removeESP(p)
        end
        return 
    end
    
    task.spawn(function()
        pcall(function()
            for _, p in pairs(Services.Players:GetPlayers()) do
                if p ~= player then
                    if p.Character and not gameState.espObjects[p] then
                        createAdvancedESP(p)
                    elseif not p.Character and gameState.espObjects[p] then
                        removeESP(p)
                    end
                end
            end
        end)
    end)
end)

-- Loop de monitoramento de ameaças
task.spawn(function()
    while true do
        pcall(function()
            local scriptCount = 0
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("LocalScript") and obj.Enabled then
                    scriptCount = scriptCount + 1
                end
            end
            
            if scriptCount > 50 then
                increaseThreat(1)
            end
            
            for _, gui in pairs(player.PlayerGui:GetChildren()) do
                local name = gui.Name:lower()
                if name:find("admin") or name:find("mod") or name:find("detect") then
                    increaseThreat(2)
                end
            end
        end)
        
        task.wait(math.random(5, 10))
    end
end)

-- Loop anti-staff
task.spawn(function()
    while true do
        checkForStaff()
        task.wait(math.random(15, 30))
    end
end)

-- === EVENTOS PROTEGIDOS ===

-- Novos jogadores
Services.Players.PlayerAdded:Connect(function(p)
    task.wait(math.random(1, 3))
    if gameState.espEnabled and p.Character then
        createAdvancedESP(p)
    end
    
    task.spawn(function()
        task.wait(2)
        checkForStaff()
    end)
end)

-- Jogadores saindo
Services.Players.PlayerRemoving:Connect(function(p)
    removeESP(p)
    if gameState.ignoredPlayers[p.UserId] then
        gameState.ignoredPlayers[p.UserId] = nil
    end
end)

-- === CONTROLES APRIMORADOS ===

-- Hide/Show
local isHidden = false
HideBtn.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    
    local targetX = isHidden and (isMobile and -370 or -400) or (isMobile and 10 or 20)
    
    if isHidden then
        Services.TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(0, targetX, 0.5, isMobile and -240 or -260)
        }):Play()
        HideBtn.Text = "+"
    else
        Services.TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(0, targetX, 0.5, isMobile and -240 or -260)
        }):Play()
        HideBtn.Text = "—"
    end
end)

-- Controles de teclado melhorados (apenas para PC)
if not isMobile then
    local guiVisible = false
    Services.UserInputService.InputBegan:Connect(function(key, processed)
        if processed then return end
        
        if key.KeyCode == Enum.KeyCode.Insert then
            guiVisible = not guiVisible
            
            if guiVisible then
                Services.TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                    Position = UDim2.new(0, 20, 0.5, -260)
                }):Play()
            else
                Services.TweenService:Create(MainFrame, TweenInfo.new(0.3), {
                    Position = UDim2.new(0, -400, 0.5, -260)
                }):Play()
            end
        end
        
        if key.KeyCode == Enum.KeyCode.End then
            Services.TeleportService:Teleport(game.PlaceId)
        end
        
        if key.KeyCode == Enum.KeyCode.Home then
            threatLevel = 0
        end
        
        -- Toggle rápido do aimbot
        if key.KeyCode == Enum.KeyCode.RightControl then
            gameState.aimEnabled = not gameState.aimEnabled
        end
    end)
end

-- === CONTROLES TOUCH PARA MOBILE ===
if isMobile then
    -- Gesture para mostrar/esconder o menu (swipe da borda esquerda)
    local swipeStartX = nil
    local menuVisible = false
    
    Services.UserInputService.TouchSwipe:Connect(function(swipeDirection, numberOfTouches)
        if swipeDirection == Enum.SwipeDirection.Right and numberOfTouches == 1 then
            if not menuVisible then
                menuVisible = true
                Services.TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                    Position = UDim2.new(0, 10, 0.5, -240)
                }):Play()
            end
        elseif swipeDirection == Enum.SwipeDirection.Left and numberOfTouches == 1 then
            if menuVisible then
                menuVisible = false
                Services.TweenService:Create(MainFrame, TweenInfo.new(0.3), {
                    Position = UDim2.new(0, -370, 0.5, -240)
                }):Play()
            end
        end
    end)
    
    -- Touch na borda para mostrar menu
    Services.UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        
        local touchPos = touch.Position
        if touchPos.X < 50 and not menuVisible then
            menuVisible = true
            Services.TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                Position = UDim2.new(0, 10, 0.5, -240)
            }):Play()
        end
    end)
end

-- === INICIALIZAÇÃO FINAL ===

task.wait(0.5)

-- Entrada suave
local targetX = isMobile and 10 or 20
local targetY = isMobile and -240 or -260

Services.TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0, targetX, 0.5, targetY)
}):Play()

task.wait(0.3)

-- Atualizar scroll
Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- === SISTEMAS DE PROTEÇÃO FINAL ===

local performanceMonitor = task.spawn(function()
    while true do
        pcall(function()
            local fps = 1 / Services.RunService.Heartbeat:Wait()
            
            if fps < 20 then
                aimSmoothness = isMobile and 0.08 or 0.06
                -- Reduz qualidade do ESP em FPS baixo
                if gameState.espEnabled then
                    for p, objects in pairs(gameState.espObjects) do
                        for _, obj in pairs(objects) do
                            if obj and obj:IsA("BillboardGui") then
                                obj.Enabled = false
                            end
                        end
                    end
                    
                    task.wait(2)
                    
                    for p, objects in pairs(gameState.espObjects) do
                        for _, obj in pairs(objects) do
                            if obj and obj:IsA("BillboardGui") then
                                obj.Enabled = true
                            end
                        end
                    end
                end
            else
                aimSmoothness = isMobile and 0.15 or 0.12
            end
        end)
        
        task.wait(5)
    end
end)

-- Sistema de auto-limpeza
local cleanupSystem = task.spawn(function()
    while true do
        task.wait(math.random(120, 300))
        
        pcall(function()
            collectgarbage("collect")
            
            -- Remove ESPs de jogadores que saíram
            for p, objects in pairs(gameState.espObjects) do
                if not Services.Players:FindFirstChild(p.Name) then
                    removeESP(p)
                end
            end
            
            -- Verifica integridade da GUI
            if not ScreenGui.Parent or not MainFrame.Parent then
                error("GUI integrity compromised")
            end
        end)
    end
end)

-- Limpeza ao sair
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        pcall(function()
            if aimConnection then aimConnection:Disconnect() end
            if performanceMonitor then task.cancel(performanceMonitor) end
            if cleanupSystem then task.cancel(cleanupSystem) end
            
            for p, _ in pairs(gameState.espObjects) do
                removeESP(p)
            end
            
            if crosshairGui then
                crosshairGui:Destroy()
            end
            
            if PlayerListFrame then
                PlayerListFrame:Destroy()
            end
            
            if gameState.mobileAimButton then
                gameState.mobileAimButton:Destroy()
            end
            
            gameState = {}
            threatLevel = 0
            
            collectgarbage("collect")
        end)
    end
end)

-- === NOTIFICAÇÃO FINAL SILENCIOSA (SEM PRINTS) ===
task.spawn(function()
    task.wait(1)
    
    if MainFrame and MainFrame.Parent and ScreenGui then
        local finalNotif = Instance.new("Frame")
        finalNotif.Size = UDim2.new(0, 320, 0, 90)
        finalNotif.Position = UDim2.new(1, 0, 0, 50)
        finalNotif.BackgroundColor3 = Color3.fromRGB(15, 25, 15)
        finalNotif.BorderSizePixel = 0
        finalNotif.Parent = ScreenGui
        
        local finalCorner = Instance.new("UICorner")
        finalCorner.CornerRadius = UDim.new(0, 8)
        finalCorner.Parent = finalNotif
        
        local finalText = Instance.new("TextLabel")
        finalText.Size = UDim2.new(1, -20, 1, 0)
        finalText.Position = UDim2.new(0, 10, 0, 0)
        finalText.BackgroundTransparency = 1
        finalText.Text = "🛡️ Sistema Discreto V1.0 ATIVO - CORRIGIDO\n✅ Lista de jogadores com avatar funcionando\n🎯 Aimbot ignora jogadores selecionados\n👁️ ESP com cores de time automáticas\n⌨️ Insert = Menu | End = Server Hop"
        finalText.TextColor3 = Color3.fromRGB(100, 255, 100)
        finalText.TextSize = 11
        finalText.Font = Enum.Font.Gotham
        finalText.TextWrapped = true
        finalText.TextXAlignment = Enum.TextXAlignment.Left
        finalText.TextYAlignment = Enum.TextYAlignment.Center
        finalText.Parent = finalNotif
        
        local enterTween = Services.TweenService:Create(
            finalNotif, 
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
            { Position = UDim2.new(1, -340, 0, 50) }
        )
        enterTween:Play()
        
        task.wait(7)
        
        local exitTweenFrame = Services.TweenService:Create(
            finalNotif, 
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 
            { 
                Position = UDim2.new(1, 0, 0, 50), 
                BackgroundTransparency = 1 
            }
        )
        
        local exitTweenText = Services.TweenService:Create(
            finalText, 
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 
            { TextTransparency = 1 }
        )
        
        exitTweenFrame:Play()
        exitTweenText:Play()
        
        exitTweenFrame.Completed:Connect(function()
            finalNotif:Destroy()
        end)
    end
end)
