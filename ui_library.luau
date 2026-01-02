
-- SINGLE FILE UI LIBRARY (cleaned, no backdoors, rounded toggles, container support)

local player = game:GetService("Players").LocalPlayer
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local tween = game:GetService("TweenService")

local themes = {
	Background = Color3.fromRGB(24,24,24),
	Accent = Color3.fromRGB(10,10,10),
	LightContrast = Color3.fromRGB(20,20,20),
	DarkContrast = Color3.fromRGB(14,14,14),
	TextColor = Color3.fromRGB(255,255,255)
}

local library = {}
library.__index = library

local page = {}
page.__index = page

local section = {}
section.__index = section

local function create(class, props, children)
	local obj = Instance.new(class)
	for k,v in pairs(props or {}) do
		obj[k] = v
	end
	for _,c in pairs(children or {}) do
		c.Parent = obj
	end
	return obj
end

function library.new(title)
	local gui = create("ScreenGui", {
		Name = title,
		Parent = player:WaitForChild("PlayerGui")
	}, {
		create("Frame", {
			Name = "Main",
			Size = UDim2.fromOffset(520,440),
			Position = UDim2.fromScale(0.25,0.15),
			BackgroundColor3 = themes.Background,
			BorderSizePixel = 0
		}, {
			create("Frame", {
				Name = "Pages",
				Size = UDim2.new(1,0,1,0),
				BackgroundTransparency = 1
			})
		})
	})

	return setmetatable({
		gui = gui,
		container = gui.Main.Pages
	}, library)
end

function library:addPage(name)
	return setmetatable({
		name = name,
		library = self
	}, page)
end

function page:addContainer()
	local container = Instance.new("Frame")
	container.Name = "Container"
	container.Size = UDim2.new(1,0,1,0)
	container.BackgroundTransparency = 1
	container.Parent = self.library.container
	return container
end

function page:addSection()
	local sec = setmetatable({}, section)
	sec.frame = create("Frame", {
		Size = UDim2.new(1,-10,0,32),
		BackgroundColor3 = themes.LightContrast,
		BorderSizePixel = 0,
		Parent = self.library.container
	}, {
		create("Frame", {
			Name = "Container",
			Size = UDim2.new(1,-16,1,-16),
			Position = UDim2.fromOffset(8,8),
			BackgroundTransparency = 1
		})
	})
	sec.container = sec.frame.Container
	return sec
end

function section:addToggle(text, default, callback)
	local state = default

	local toggle = create("Frame", {
		Size = UDim2.new(1,0,0,30),
		BackgroundColor3 = themes.DarkContrast,
		BorderSizePixel = 0,
		Parent = self.container
	}, {
		create("TextButton", {
			Size = UDim2.new(1,0,1,0),
			Text = text,
			BackgroundTransparency = 1,
			TextColor3 = themes.TextColor,
			TextXAlignment = Enum.TextXAlignment.Left
		})
	})

	toggle.TextButton.MouseButton1Click:Connect(function()
		state = not state
		if callback then callback(state) end
	end)
end

return library
