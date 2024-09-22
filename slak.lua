local ArrayField = loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3AArrayfield%20Library"))()
local Window = ArrayField:CreateWindow({
   Name = "Eu quero testar este jogo [Beta]",
   LoadingTitle = "ArrayField Interface Suite",
   LoadingSubtitle = "by Arrays",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "ArrayField"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key", -- It is recommended to use something unique as other scripts using ArrayField may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
      Actions = {
            [1] = {
                Text = 'Click here to copy the key link <--',
                OnPress = function()
                    print('Pressed')
                end,
                }
            },
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Toggle = Tab:CreateToggle({
   Name = "Modo imortal
   CurrentValue = false,
   Flag = "Toggle1", -- Identificador exclusivo para o Toggle
   Callback = function(Value)
       if Value then
           -- Definir vida para 100% quando ativado
           local character = LocalPlayer.Character
           if character then
               local humanoid = character:FindFirstChildOfClass("Humanoid")
               if humanoid then
                   humanoid.Health = humanoid.MaxHealth
               end
           end
       end
   end,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Toggle = Tab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = "Toggle1", -- Identificador exclusivo para o Toggle
   Callback = function(Value)
       if Value then
           -- Criar o bloco
           local part = Instance.new("Part")
           part.Size = Vector3.new(5, 1, 5) -- Tamanho do bloco
           part.Anchored = false
           part.CanCollide = true
           part.Color = Color3.fromRGB(0, 255, 0) -- Cor verde neon
           part.Material = Enum.Material.Neon
           part.Parent = workspace

           -- Criar BodyPosition para seguir o jogador
           local bodyPosition = Instance.new("BodyPosition")
           bodyPosition.MaxForce = Vector3.new(100000, 100000, 100000) -- Força máxima
           bodyPosition.P = 1000
           bodyPosition.D = 100
           bodyPosition.Parent = part

           -- Conectar ao evento de movimentação
           local function updatePosition()
               local character = LocalPlayer.Character
               if character then
                   local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                   local humanoid = character:FindFirstChildOfClass("Humanoid")
                   if humanoidRootPart and humanoid then
                       -- Manter o bloco sempre embaixo do jogador, ajustando a altura quando ele pular
                       local heightOffset = humanoid.MoveDirection.Magnitude > 0 and -0.5 or -2
                       if humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                           heightOffset = 1 -- Sobe quando o jogador pula
                       end
                       bodyPosition.Position = humanoidRootPart.Position - Vector3.new(0, humanoid.HipHeight + part.Size.Y / 2 + heightOffset, 0)
                   end
               end
           end

           -- Atualiza a posição constantemente
           local connection
           connection = RunService.Stepped:Connect(function()
               if not part or not part.Parent then
                   connection:Disconnect()
               else
                   updatePosition()
               end
           end)
       end
   end,
})
