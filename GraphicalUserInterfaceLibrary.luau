--// SIMPLE BLOCK-STYLE UI LIBRARY (0,5 corners)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Library = {}
local CORNER_RADIUS = UDim.new(0,5)

local function MakeCorner(x)
	local c = Instance.new("UICorner")
	c.CornerRadius = CORNER_RADIUS
	c.Parent = x
end

local function MakeDraggable(Handle, Frame)
	local Dragging, DragStart, StartPos

	Handle.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			DragStart = i.Position
			StartPos = Frame.Position
		end
	end)

	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if Dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local Delta = i.Position - DragStart
			Frame.Position = UDim2.fromOffset(
				StartPos.X.Offset + Delta.X,
				StartPos.Y.Offset + Delta.Y
			)
		end
	end)
end

local function Notify(Gui, Title, Text)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.fromOffset(270, 90)
	Frame.Position = UDim2.fromScale(0.5, 0.90)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(40, 30, 26)
	Frame.BorderSizePixel = 0
	Frame.BackgroundTransparency = 1
	Frame.Parent = Gui
	MakeCorner(Frame)

	local Head = Instance.new("TextLabel")
	Head.BackgroundTransparency = 1
	Head.Size = UDim2.fromScale(1, 0.35)
	Head.Text = Title
	Head.Font = Enum.Font.GothamMedium
	Head.TextSize = 16
	Head.TextColor3 = Color3.fromRGB(255,255,255)
	Head.Parent = Frame

	local Desc = Instance.new("TextLabel")
	Desc.BackgroundTransparency = 1
	Desc.Position = UDim2.fromScale(0,0.35)
	Desc.Size = UDim2.fromScale(1,0.65)
	Desc.Text = Text
	Desc.Font = Enum.Font.Gotham
	Desc.TextSize = 14
	Desc.TextWrapped = true
	Desc.TextColor3 = Color3.fromRGB(210,210,210)
	Desc.Parent = Frame

	TweenService:Create(Frame, TweenInfo.new(0.25), {
		BackgroundTransparency = 0
	}):Play()

	task.delay(3, function()
		TweenService:Create(Frame, TweenInfo.new(0.25), {
			BackgroundTransparency = 1
		}):Play()
		task.wait(0.3)
		Frame:Destroy()
	end)
end

function Library:CreateWindow(Title)
	local Gui = Instance.new("ScreenGui")
	Gui.ResetOnSpawn = false
	Gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	local Main = Instance.new("Frame")
	Main.Size = UDim2.fromOffset(480, 310)
	Main.Position = UDim2.fromScale(0.5,0.5)
	Main.AnchorPoint = Vector2.new(0.5,0.5)
	Main.BackgroundColor3 = Color3.fromRGB(36, 26, 22)
	Main.BorderSizePixel = 0
	Main.Parent = Gui
	MakeCorner(Main)

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(60,45,40)
	Stroke.Thickness = 1
	Stroke.Parent = Main

	local Top = Instance.new("Frame")
	Top.Size = UDim2.fromOffset(480, 38)
	Top.BackgroundColor3 = Color3.fromRGB(46, 34, 30)
	Top.BorderSizePixel = 0
	Top.Parent = Main
	MakeCorner(Top)

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.fromScale(1,1)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = Title
	TitleLabel.Font = Enum.Font.GothamMedium
	TitleLabel.TextSize = 18
	TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Position = UDim2.fromOffset(10,0)
	TitleLabel.Parent = Top

	MakeDraggable(Top, Main)

	local Tabs = Instance.new("Frame")
	Tabs.Position = UDim2.fromOffset(8,50)
	Tabs.Size = UDim2.fromOffset(110, 250)
	Tabs.BackgroundColor3 = Color3.fromRGB(46, 34, 30)
	Tabs.BorderSizePixel = 0
	Tabs.Parent = Main
	MakeCorner(Tabs)

	local TabList = Instance.new("UIListLayout")
	TabList.Parent = Tabs
	TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabList.Padding = UDim.new(0,6)

	local Pages = Instance.new("Frame")
	Pages.Position = UDim2.fromOffset(125,50)
	Pages.Size = UDim2.fromOffset(345,250)
	Pages.BackgroundTransparency = 0
	Pages.BackgroundColor3 = Color3.fromRGB(30, 22, 18)
	Pages.BorderSizePixel = 0
	Pages.Parent = Main
	MakeCorner(Pages)

	local Window = {}

	function Window:CreateTab(Name)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.fromOffset(100, 34)
		Btn.Text = Name
		Btn.Font = Enum.Font.Gotham
		Btn.TextSize = 14
		Btn.TextColor3 = Color3.fromRGB(225,225,225)
		Btn.BackgroundColor3 = Color3.fromRGB(56, 42, 36)
		Btn.BorderSizePixel = 0
		Btn.Parent = Tabs
		MakeCorner(Btn)

		Btn.MouseEnter:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.12), {
				BackgroundColor3 = Color3.fromRGB(66, 50, 42)
			}):Play()
		end)
		Btn.MouseLeave:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.12), {
				BackgroundColor3 = Color3.fromRGB(56, 42, 36)
			}):Play()
		end)

		local Page = Instance.new("Frame")
		Page.Size = UDim2.fromScale(1,1)
		Page.BackgroundTransparency = 1
		Page.Visible = false
		Page.Parent = Pages

		local Layout = Instance.new("UIListLayout")
		Layout.Parent = Page
		Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		Layout.Padding = UDim.new(0,10)

		Btn.MouseButton1Click:Connect(function()
			for _,v in pairs(Pages:GetChildren()) do
				if v:IsA("Frame") then v.Visible = false end
			end
			Page.Visible = true
		end)

		local Tab = {}

		function Tab:CreateButton(Text, Callback)
			local B = Instance.new("TextButton")
			B.Size = UDim2.fromOffset(300,34)
			B.Text = Text
			B.Font = Enum.Font.Gotham
			B.TextSize = 14
			B.TextColor3 = Color3.fromRGB(255,255,255)
			B.BackgroundColor3 = Color3.fromRGB(54, 40, 34)
			B.BorderSizePixel = 0
			B.Parent = Page
			MakeCorner(B)

			B.MouseEnter:Connect(function()
				TweenService:Create(B, TweenInfo.new(0.12), {
					BackgroundColor3 = Color3.fromRGB(66, 50, 44)
				}):Play()
			end)
			B.MouseLeave:Connect(function()
				TweenService:Create(B, TweenInfo.new(0.12), {
					BackgroundColor3 = Color3.fromRGB(54, 40, 34)
				}):Play()
			end)

			B.MouseButton1Click:Connect(function()
				if Callback then
					Callback(function(t,m)
						Notify(Gui,t,m)
					end)
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
