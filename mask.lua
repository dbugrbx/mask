local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
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
    ConfigurationSaving = {Enabled = true, FolderName = nil, FileName = "Mask"},
    Discord = {Enabled = true, Invite = "https://discord.gg/xgkcgArxKT", RememberJoins = true},
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
local function ToJavaScriptObjectNotation(Table)
    local function Serialize(Value)
        local TypeOfValue = type(Value)
        if TypeOfValue == "number" or TypeOfValue == "boolean" then
            return tostring(Value)
        elseif TypeOfValue == "string" then
            return '"' .. string.gsub(string.gsub(Value, '\\', '\\\\'), '"', '\\"') .. '"'
        elseif TypeOfValue == "table" then
            local IsArray = true
            local Index = 1
            for Key in pairs(Value) do
                if Key ~= Index then
                    IsArray = false
                    break
                end
                Index = Index + 1
            end
            local Items = {}
            if IsArray then
                for Index = 1, #Value do
                    table.insert(Items, Serialize(Value[Index]))
                end
                return "[" .. table.concat(Items, ",") .. "]"
            else
                for Key, InnerValue in pairs(Value) do
                    if type(Key) ~= "number" then
                        table.insert(Items, Serialize(Key) .. ":" .. Serialize(InnerValue))
                    else
                        table.insert(Items, Serialize(tostring(Key)) .. ":" .. Serialize(InnerValue))
                    end
                end
                return "{" .. table.concat(Items, ",") .. "}"
            end
        else
            return "null"
        end
    end
    return Serialize(Table)
end
local RemoteListener = Window:CreateTab("Remote Listener", "server-cog")
local RemoteOptions = {}
local RemoteData = {}
local RemoteOption
local RemoteDropdown = RemoteListener:CreateDropdown({
    Name = "Remote Events",
    Options = RemoteOptions,
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "RemoteDropdown",
    Callback = function(Selected)
        RemoteOption = Selected[1]
    end,
})
local CopyRemote = RemoteListener:CreateButton({
    Name = "Copy Selected Remote",
    Callback = function()
        if RemoteOption and RemoteData[RemoteOption] then
            setclipboard(RemoteData[RemoteOption])
			Rayfield:Notify({
   				Title = "Copied",
   				Content = "Successfully Copied Remote Data",
   				Duration = 5,
   				Image = "clipboard",
			})
        end
    end,
})
for _, Remote in pairs(game:GetDescendants()) do
    if Remote:IsA("RemoteEvent") then
        Remote.OnClientEvent:Connect(function(...)
            local Arguments = {...}
            local Serialized = ToJavaScriptObjectNotation(Arguments)
            local Name = Remote.Name
            if not RemoteData[Name] then
                table.insert(RemoteOptions, Name)
                RemoteData[Name] = Serialized
                RemoteDropdown:Refresh(RemoteOptions)
            end
        end)
    end
end
Rayfield:LoadConfiguration()
