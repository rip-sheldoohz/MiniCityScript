-- botao.lua

-- Categoria Main
local CategoryName = "Main"

-- Variáveis do Aimbot
local aimbotActive = false
local SelectedPlayer = nil

-- Criar Frame lateral para jogadores
local PlayerFrame = Instance.new("Frame")
PlayerFrame.Size = UDim2.new(0, 150, 0, 300)
PlayerFrame.Position = UDim2.new(1, 10, 0, 50) -- ao lado do painel
PlayerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerFrame.BorderSizePixel = 0
PlayerFrame.Visible = false
PlayerFrame.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 5)
Corner.Parent = PlayerFrame

local Title = Instance.new("TextLabel")
Title.Parent = PlayerFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Jogadores"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Função para atualizar lista de jogadores
local function UpdatePlayerList()
    for _, child in pairs(PlayerFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local YPos = 35
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
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
                print("Jogador selecionado:", plr.Name)
                -- Não foca automaticamente, apenas seleciona
            end)
            YPos = YPos + 35
        end
    end
end

-- Criar botão Aimbot toggle
CreateToggleButton("Aimbot Legit", function(active)
    aimbotActive = active
    if active then
        PlayerFrame.Visible = true
        UpdatePlayerList()
        print("Aimbot ativado")
        -- Aqui você pode adicionar código que usa SelectedPlayer para mira, mas só quando quiser
        spawn(function()
            while aimbotActive do
                wait(0.01)
                if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("Head") then
                    -- Código para aimbot só quando você quiser
                    -- Exemplo: apenas print da posição da cabeça
                    local headPos = SelectedPlayer.Character.Head.Position
                    -- print("Head position:", headPos)
                end
            end
        end)
    else
        PlayerFrame.Visible = false
        SelectedPlayer = nil
        print("Aimbot desativado")
    end
end)
