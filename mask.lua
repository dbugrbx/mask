local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Mask",
    Icon = 0,
    LoadingTitle = "Mask",
    LoadingSubtitle = "Configuring Assets...",
    ShowText = "Mask",
    Theme = "Default",
    ToggleUIKeybind = "M",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Mask"
    },
    Discord = {
        Enabled = true,
        Invite = "https://discord.gg/vVJU3bxJdJ",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Mask Access Key",
        Subtitle = "Access Key is required to continue.",
        Note = "Join the Inverted HQ Discord Server for the Access Key.",
        FileName = "AccessKey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"januarysnow2026"}
    }
})
local RemoteListener = Window:CreateTab("Remote Listener", "server-cog")
local HttpService = game:GetService("HttpService")
for _, Remote in pairs(game:GetDescendants()) do
    if Remote:IsA("RemoteEvent") then
        Remote.OnClientEvent:Connect(function(...)
            local Arguments = {...}
            local Serialized = HttpService:JSONEncode(Arguments)
            local Button
            Button = RemoteListener:CreateButton({
                Name = Remote.Name,
                Callback = function()
                    local OriginalName = Button.Name
                    setclipboard(Serialized)
                    Button:Set("Copied")
                    task.wait(0.5)
                    Button:Set(OriginalName)
                end,
            })
        end)
    end
end
Rayfield:LoadConfiguration()
