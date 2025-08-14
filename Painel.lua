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

-- Criar GUI atualizado
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = PANEL_NAME

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = isMobile and UDim2.new(0, 250, 0, 250) or UDim2.new(0, 600, 0, 200)
MainFrame.Position = isMobile and UDim2.new(0.5, -125, 0.5, -125) or UDim2.new(0.5, -300, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = not isMobile
MainFrame.Visible = false -- começa invisível
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

-- Container para botões
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

-- Função criar botão toggle
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
        if toggled then
            pcall(callback, true)
        else
            pcall(callback, false)
        end
    end)
end

-- Carregar botões direto de botao.lua
local success, err = pcall(function()
    if isfile("botao.lua") then
        loadfile("botao.lua")()
    else
        warn("Arquivo botao.lua não encontrado!")
    end
end)

if not success then
    warn("Erro ao carregar botao.lua:", err)
end

-- Tamanhos minimizar/restaurar
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

-- Controle abrir/fechar
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
    -- PC abre/fecha apenas com K
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.K then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
end
