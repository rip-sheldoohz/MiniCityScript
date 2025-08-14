-- Exemplo de botao.lua

-- Função toggle do Aimbot Legit
local aimbotActive = false

CreateToggleButton("Aimbot Legit", function(active)
    aimbotActive = active
    
    if active then
        -- Exibir descrição quando ativado
        print("Aimbot Legit ativado: Mira irá grudrar na cabeça do jogador")
        
        -- Exemplo básico de Aimbot (para fins de toggle)
        -- Esse loop só funciona enquanto aimbotActive for true
        spawn(function()
            while aimbotActive do
                wait(0.01)
                -- Código para buscar jogadores e mirar na cabeça
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                        local headPos = plr.Character.Head.Position
                        -- Aqui você aplicaria a movimentação da mira para headPos
                        -- Exemplo: CFrame da câmera
                        -- game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, headPos)
                    end
                end
            end
        end)
    else
        -- Quando desativar, o loop acima para automaticamente
        print("Aimbot Legit desativado")
    end
end)

-- Adicionar descrição
-- Caso queira exibir no painel, você poderia criar uma Label ao lado do botão
