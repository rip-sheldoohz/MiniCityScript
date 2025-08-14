-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "EcoHubMiniCityGUI"

-- Frame principal (quadrado largura fixa, altura ajustável)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 60) -- largura maior, altura inicial
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -30)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Cantos arredondados
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

-- Botão de minimizar
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

-- Função minimizar
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 500, 0, 40)
    else
        MainFrame.Size = UDim2.new(0, 500, 0, 60 + (#MainFrame:GetChildren() - 2) * 40)
    end
end)

-- Container para os botões
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Parent = MainFrame
ButtonContainer.Size = UDim2.new(1, -20, 1, -40)
ButtonContainer.Position = UDim2.new(0, 10, 0, 40)
ButtonContainer.BackgroundTransparency = 1

-- Função para criar botões toggle
local function CreateToggleButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ButtonContainer
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, (#ButtonContainer:GetChildren() * 40))
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

-- Função para verificar pasta "botao" e criar botões
local function LoadLuaButtons()
    local success, files = pcall(function()
        return listfiles("botao") -- Executor deve suportar listfiles
    end)
    if success and files then
        for _, file in pairs(files) do
            if file:match("%.lua$") then
                local name = file:match("[^/\\]+%.lua$") -- Pega só o nome do arquivo
                CreateToggleButton(name, function(active)
                    if active then
                        pcall(function()
                            loadfile(file)()
                        end)
                    end
                end)
            end
        end
    end
end

-- Carregar botões
LoadLuaButtons()
