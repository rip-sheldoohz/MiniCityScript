local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local PANEL_NAME = "EcoHubMiniCityGUI"
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Remover painel antigo
if PlayerGui:FindFirstChild(PANEL_NAME) then
    PlayerGui[PANEL_NAME]:Destroy()
end

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = PANEL_NAME

-- Painel principal (mesmo tamanho PC e Mobile)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 300)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- arrastável
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Bordas arredondadas
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

local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0, 600, 0, 40)
local minimized = false

MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and minimizedSize or originalSize
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
    MinimizeBtn.Text = minimized and "+" or "-"
end)

-- Função unificada para abrir/fechar painel
local function TogglePanel()
    MainFrame.Visible = not MainFrame.Visible
end

-- Botão Mobile flutuante
if isMobile then
    local MobileBtn = Instance.new("ImageButton")
    MobileBtn.Parent = ScreenGui
    MobileBtn.Size = UDim2.new(0, 70, 0, 70)
    MobileBtn.Position = UDim2.new(0, 20, 0, 20)
    MobileBtn.Image = "https://cdn.discordapp.com/avatars/1373759252417744897/348d8a4a11aca1304951f32cfd166026.png?size=2048"
    MobileBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MobileBtn.AutoButtonColor = true
    MobileBtn.ZIndex = 2

    local CornerBtn = Instance.new("UICorner")
    CornerBtn.CornerRadius = UDim.new(0, 35)
    CornerBtn.Parent = MobileBtn

    -- Tween de hover/toque
    MobileBtn.MouseEnter:Connect(function()
        TweenService:Create(MobileBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 80, 0, 80)}):Play()
    end)
    MobileBtn.MouseLeave:Connect(function()
        TweenService:Create(MobileBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 70)}):Play()
    end)

    -- Arrastável
    local dragging = false
    local dragInput, touchStartPos, startPos

    MobileBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            touchStartPos = input.Position
            startPos = MobileBtn.Position
        end
    end)

    MobileBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - touchStartPos
            MobileBtn.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
        end
    end)

    MobileBtn.InputEnded:Connect(function(input)
        if input == dragInput then
            dragging = false
        end
    end)

    MobileBtn.MouseButton1Click:Connect(TogglePanel)
end

-- PC: abrir/fechar com tecla K
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        TogglePanel()
    end
end)
