local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Library = {}
Library.__index = Library

function Library:CreateWindow(Title)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "SmoothUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local Main = Instance.new("Frame")
	Main.Size = UDim2.fromOffset(420, 300)
	Main.Position = UDim2.fromScale(0.5, 0.5)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Main.BorderSizePixel = 0
	Main.Parent = ScreenGui
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

	local Top = Instance.new("TextLabel")
	Top.Size = UDim2.fromOffset(420, 40)
	Top.BackgroundTransparency = 1
	Top.Text = Title
	Top.TextSize = 18
	Top.Font = Enum.Font.GothamMedium
	Top.TextColor3 = Color3.fromRGB(255, 255, 255)
	Top.Parent = Main

	local Tabs = Instance.new("Frame")
	Tabs.Position = UDim2.fromOffset(0, 40)
	Tabs.Size = UDim2.fromOffset(100, 260)
	Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Tabs.BorderSizePixel = 0
	Tabs.Parent = Main

	local Pages = Instance.new("Frame")
	Pages.Position = UDim2.fromOffset(100, 40)
	Pages.Size = UDim2.fromOffset(320, 260)
	Pages.BackgroundTransparency = 1
	Pages.Parent = Main

	local UIList = Instance.new("UIListLayout", Tabs)
	UIList.Padding = UDim.new(0, 6)

	local Window = {}
	Window.Pages = Pages

	function Window:CreateTab(Name)
		local Button = Instance.new("TextButton")
		Button.Size = UDim2.fromOffset(88, 36)
		Button.Text = Name
		Button.Font = Enum.Font.Gotham
		Button.TextSize = 14
		Button.TextColor3 = Color3.fromRGB(220, 220, 220)
		Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Button.BorderSizePixel = 0
		Button.Parent = Tabs
		Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

		local Page = Instance.new("Frame")
		Page.Size = UDim2.fromScale(1, 1)
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.Parent = Pages

		local Layout = Instance.new("UIListLayout", Page)
		Layout.Padding = UDim.new(0, 8)

		Button.MouseButton1Click:Connect(function()
			for _, v in pairs(Pages:GetChildren()) do
				if v:IsA("Frame") then
					v.Visible = false
				end
			end
			Page.Visible = true
		end)

		local Tab = {}

		function Tab:CreateButton(Text, Callback)
			local Btn = Instance.new("TextButton")
			Btn.Size = UDim2.fromOffset(280, 36)
			Btn.Text = Text
			Btn.Font = Enum.Font.Gotham
			Btn.TextSize = 14
			Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			Btn.BorderSizePixel = 0
			Btn.Parent = Page
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

			Btn.MouseEnter:Connect(function()
				TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(55,55,55)}):Play()
			end)
			Btn.MouseLeave:Connect(function()
				TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40,40,40)}):Play()
			end)

			Btn.MouseButton1Click:Connect(function()
				if Callback then
					Callback()
				end
			end)
		end

		if #Pages:GetChildren() == 1 then
			Page.Visible = true
		end

		return Tab
	end

	return Window
end

return Library
