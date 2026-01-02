local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Library = {}

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
	Frame.Size = UDim2.fromOffset(260, 80)
	Frame.Position = UDim2.fromScale(0.5, 0.85)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	Frame.BorderSizePixel = 0
	Frame.Parent = Gui
	Frame.BackgroundTransparency = 1
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,10)

	local T = Instance.new("TextLabel")
	T.Size = UDim2.fromScale(1,0.4)
	T.BackgroundTransparency = 1
	T.Text = Title
	T.Font = Enum.Font.GothamMedium
	T.TextSize = 16
	T.TextColor3 = Color3.fromRGB(255,255,255)
	T.Parent = Frame

	local D = Instance.new("TextLabel")
	D.Position = UDim2.fromScale(0,0.4)
	D.Size = UDim2.fromScale(1,0.6)
	D.BackgroundTransparency = 1
	D.Text = Text
	D.Font = Enum.Font.Gotham
	D.TextSize = 14
	D.TextWrapped = true
	D.TextColor3 = Color3.fromRGB(200,200,200)
	D.Parent = Frame

	TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()

	task.delay(3, function()
		TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		task.wait(0.25)
		Frame:Destroy()
	end)
end

function Library:CreateWindow(Title)
	local Gui = Instance.new("ScreenGui")
	Gui.ResetOnSpawn = false
	Gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	local Main = Instance.new("Frame")
	Main.Size = UDim2.fromOffset(420, 280)
	Main.Position = UDim2.fromScale(0.5,0.5)
	Main.AnchorPoint = Vector2.new(0.5,0.5)
	Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Main.BorderSizePixel = 0
	Main.Parent = Gui
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

	local Top = Instance.new("TextLabel")
	Top.Size = UDim2.fromOffset(420,40)
	Top.BackgroundTransparency = 1
	Top.Text = Title
	Top.Font = Enum.Font.GothamMedium
	Top.TextSize = 18
	Top.TextColor3 = Color3.fromRGB(255,255,255)
	Top.Parent = Main

	MakeDraggable(Top, Main)

	local Tabs = Instance.new("Frame")
	Tabs.Position = UDim2.fromOffset(10,50)
	Tabs.Size = UDim2.fromOffset(100,220)
	Tabs.BackgroundColor3 = Color3.fromRGB(26,26,26)
	Tabs.BorderSizePixel = 0
	Tabs.Parent = Main
	Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0,10)

	local Pages = Instance.new("Frame")
	Pages.Position = UDim2.fromOffset(120,50)
	Pages.Size = UDim2.fromOffset(290,220)
	Pages.BackgroundTransparency = 1
	Pages.Parent = Main

	local TabLayout = Instance.new("UIListLayout", Tabs)
	TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabLayout.Padding = UDim.new(0,6)

	local Window = {}

	function Window:CreateTab(Name)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.fromOffset(90,34)
		Btn.Text = Name
		Btn.Font = Enum.Font.Gotham
		Btn.TextSize = 14
		Btn.TextColor3 = Color3.fromRGB(220,220,220)
		Btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
		Btn.BorderSizePixel = 0
		Btn.Parent = Tabs
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

		local Page = Instance.new("Frame")
		Page.Size = UDim2.fromScale(1,1)
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.Parent = Pages

		local Layout = Instance.new("UIListLayout", Page)
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
			B.Size = UDim2.fromOffset(260,36)
			B.Text = Text
			B.Font = Enum.Font.Gotham
			B.TextSize = 14
			B.TextColor3 = Color3.fromRGB(255,255,255)
			B.BackgroundColor3 = Color3.fromRGB(40,40,40)
			B.BorderSizePixel = 0
			B.Parent = Page
			Instance.new("UICorner", B).CornerRadius = UDim.new(0,8)

			B.MouseEnter:Connect(function()
				TweenService:Create(B, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(55,55,55)}):Play()
			end)
			B.MouseLeave:Connect(function()
				TweenService:Create(B, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40,40,40)}):Play()
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
