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
      	Invite = "https://discord.gg/xgkcgArxKT",
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
Rayfield:LoadConfiguration()
