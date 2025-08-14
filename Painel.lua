-- Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local PANEL_NAME = "EcoHubMiniCityGUI"

-- Remover painel antigo
if PlayerGui:FindFirstChild(PANEL_NAME) then
    PlayerGui[PANEL_NAME]:Destroy()
end

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = PANEL_NAME

local MainFrame = Instance.new("Frame")
MainFrame.Size = isMobile and UDim2.new(0, 250, 0, 250) or UDim2.new(0, 600, 0, 300)
MainFrame.Position = isMobile and UDim2.new(0.5, -125, 0.5, -125) or UDim2.new(0.5, -300, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = not isMobile
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "EcoHub - Mini City V1"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Container de botões
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Parent = MainFrame
ButtonContainer.Size = UDim2.new(1, -20, 1, -50)
ButtonContainer.Position = UDim2.new(0, 10, 0, 40)
ButtonContainer.BackgroundTransparency = 1

-- Botão minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 25
MinimizeBtn.AutoButtonColor = true

-- ===== Criar função de botão toggle =====
local function CreateToggleButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ButtonContainer
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, (#ButtonContainer:GetChildren()-1) * 40)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = name .. " [OFF]"
    
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        btn.Text = name .. (toggled and " [ON]" or " [OFF]")
        pcall(callback, toggled)
    end)
end

-- ===== Sistema Aimbot =====
local aimbotActive = false
local SelectedPlayer = nil

-- Frame lateral para lista de jogadores
local PlayerFrame = Instance.new("Frame")
PlayerFrame.Size = UDim2.new(0, 150, 0, 300)
PlayerFrame.Position = UDim2.new(1, 10, 0, 50)
PlayerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerFrame.BorderSizePixel = 0
PlayerFrame.Visible = false
PlayerFrame.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 5)
Corner.Parent = PlayerFrame

local TitlePlayers = Instance.new("TextLabel")
TitlePlayers.Parent = PlayerFrame
TitlePlayers.Size = UDim2.new(1, 0, 0, 30)
TitlePlayers.Position = UDim2.new(0, 0, 0, 0)
TitlePlayers.BackgroundTransparency = 1
TitlePlayers.Text = "Jogadores"
TitlePlayers.Font = Enum.Font.GothamBold
TitlePlayers.TextColor3 = Color3.fromRGB(255, 255, 255)
TitlePlayers.TextSize = 18

local function UpdatePlayerList()
    for _, child in pairs(PlayerFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local YPos = 35
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Parent = PlayerFrame
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Position = UDim2.new(0, 5, 0, YPos)
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 16
            btn.Text = plr.Name
            btn.AutoButtonColor = true

            btn.MouseButton1Click:Connect(function()
                SelectedPlayer = plr
                print("Selecionado:", plr.Name)
            end)
            YPos = YPos + 35
        end
    end
end

-- Criar botão Aimbot toggle dentro do painel
CreateToggleButton("Aimbot Legit", function(active)
    aimbotActive = active
    if active then
        PlayerFrame.Visible = true
        UpdatePlayerList()
        spawn(function()
            while aimbotActive do
                wait(0.01)
                -- Aqui você pode implementar a mira usando SelectedPlayer se quiser
            end
        end)
    else
        PlayerFrame.Visible = false
        SelectedPlayer = nil
    end
end)

-- ===== Minimizar/restaurar =====
local originalSize = MainFrame.Size
local minimizedSize = isMobile and UDim2.new(0, 250, 0, 50) or UDim2.new(0, 600, 0, 40)
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = minimizedSize
        for _, btn in pairs(ButtonContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.Visible = false
            end
        end
    else
        MainFrame.Size = originalSize
        for _, btn in pairs(ButtonContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.Visible = true
            end
        end
    end
end)

-- ===== Abrir/fechar painel =====
if isMobile then
    local MobileBtn = Instance.new("ImageButton")
    MobileBtn.Parent = ScreenGui
    MobileBtn.Size = UDim2.new(0, 60, 0, 60)
    MobileBtn.Position = UDim2.new(0, 20, 0, 20)
    MobileBtn.Image = "https://cdn.discordapp.com/avatars/1373759252417744897/348d8a4a11aca1304951f32cfd166026.png?size=2048"
    MobileBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MobileBtn.AutoButtonColor = true

    MobileBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
else
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.K then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
end
