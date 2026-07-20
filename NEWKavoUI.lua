local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local TweenInfo = TweenInfo.new

local Kavo = {}
local Utility = {}
local Objects = {}

function Kavo:DraggingEnabled(frame, parent)
	parent = parent or frame
	local dragging = false
	local dragInput, mousePos, framePos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			mousePos = input.Position
			framePos = parent.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - mousePos
			parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
		end
	end)
end

function Utility:TweenObject(obj, properties, duration, ...)
	TweenService:Create(obj, TweenInfo(duration, ...), properties):Play()
end

local themes = {
	SchemeColor = Color3.fromRGB(74, 99, 135),
	Background = Color3.fromRGB(36, 37, 43),
	Header = Color3.fromRGB(28, 29, 34),
	TextColor = Color3.fromRGB(255, 255, 255),
	ElementColor = Color3.fromRGB(32, 32, 38),
}

local themeStyles = {
	DarkTheme = {
		SchemeColor = Color3.fromRGB(64, 64, 64),
		Background = Color3.fromRGB(0, 0, 0),
		Header = Color3.fromRGB(0, 0, 0),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(20, 20, 20),
	},
	LightTheme = {
		SchemeColor = Color3.fromRGB(150, 150, 150),
		Background = Color3.fromRGB(255, 255, 255),
		Header = Color3.fromRGB(200, 200, 200),
		TextColor = Color3.fromRGB(0, 0, 0),
		ElementColor = Color3.fromRGB(224, 224, 224),
	},
	BloodTheme = {
		SchemeColor = Color3.fromRGB(0, 0, 153),
		Background = Color3.fromRGB(10, 10, 10),
		Header = Color3.fromRGB(5, 5, 5),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(20, 20, 20),
	},
	GrapeTheme = {
		SchemeColor = Color3.fromRGB(166, 71, 214),
		Background = Color3.fromRGB(64, 50, 71),
		Header = Color3.fromRGB(36, 28, 41),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(74, 58, 84),
	},
	Grey = {
		SchemeColor = Color3.fromRGB(168, 167, 167),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Red = {
		SchemeColor = Color3.fromRGB(255, 77, 77),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Green = {
		SchemeColor = Color3.fromRGB(77, 255, 95),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Blue = {
		SchemeColor = Color3.fromRGB(77, 83, 255),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Yellow = {
		SchemeColor = Color3.fromRGB(255, 237, 77),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Orange = {
		SchemeColor = Color3.fromRGB(255, 169, 77),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Pink = {
		SchemeColor = Color3.fromRGB(255, 77, 243),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Purple = {
		SchemeColor = Color3.fromRGB(136, 77, 255),
		Background = Color3.fromRGB(32, 32, 32),
		Header = Color3.fromRGB(24, 24, 24),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(24, 24, 24),
	},
	Serpent = {
		SchemeColor = Color3.fromRGB(0, 166, 58),
		Background = Color3.fromRGB(31, 41, 43),
		Header = Color3.fromRGB(22, 29, 31),
		TextColor = Color3.fromRGB(255, 255, 255),
		ElementColor = Color3.fromRGB(22, 29, 31),
	},
}

local oldTheme = ''

local SettingsT = {}

local Name = "KavoConfig.JSON"

if not isfile("KavoConfig.JSON") then
	writefile(Name, "{}")
end

pcall(function()
	if not pcall(function()
		readfile(Name)
	end) then
		writefile(Name, HttpService:JSONEncode(SettingsT))
	end
	Settings = HttpService:JSONEncode(readfile(Name))
end)

local LibName = tostring(math.random(1, 100)) .. tostring(math.random(1, 50)) .. tostring(math.random(1, 100))

function Kavo:ToggleUI()
	if CoreGui[LibName].Enabled then
		CoreGui[LibName].Enabled = false
	else
		CoreGui[LibName].Enabled = true
	end
end

function Kavo.CreateLib(kavName, themeList)
	if not themeList then
		themeList = themes
	end
	if themeList == "DarkTheme" then
		themeList = themeStyles.DarkTheme
	elseif themeList == "LightTheme" then
		themeList = themeStyles.LightTheme
	elseif themeList == "BloodTheme" then
		themeList = themeStyles.BloodTheme
	elseif themeList == "GrapeTheme" then
		themeList = themeStyles.GrapeTheme
	elseif themeList == "Grey" then
		themeList = themeStyles.Grey
	elseif themeList == "Red" then
		themeList = themeStyles.Red
	elseif themeList == "Green" then
		themeList = themeStyles.Green
	elseif themeList == "Blue" then
		themeList = themeStyles.Blue
	elseif themeList == "Yellow" then
		themeList = themeStyles.Yellow
	elseif themeList == "Orange" then
		themeList = themeStyles.Orange
	elseif themeList == "Pink" then
		themeList = themeStyles.Pink
	elseif themeList == "Purple" then
		themeList = themeStyles.Purple
	elseif themeList == "Serpent" then
		themeList = themeStyles.Serpent
	else
		if themeList.SchemeColor == nil then
			themeList.SchemeColor = Color3.fromRGB(74, 99, 135)
		elseif themeList.Background == nil then
			themeList.Background = Color3.fromRGB(36, 37, 43)
		elseif themeList.Header == nil then
			themeList.Header = Color3.fromRGB(28, 29, 34)
		elseif themeList.TextColor == nil then
			themeList.TextColor = Color3.fromRGB(255, 255, 255)
		elseif themeList.ElementColor == nil then
			themeList.ElementColor = Color3.fromRGB(32, 32, 38)
		end
	end
	themeList = themeList or {}
	local selectedTab
	kavName = kavName or "Library"
	table.insert(Kavo, kavName)
	for _, v in pairs(CoreGui:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == kavName then
			v:Destroy()
		end
	end
	local ScreenGui = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local MainHeader = Instance.new("Frame")
	local headerCover = Instance.new("UICorner")
	local coverup = Instance.new("Frame")
	local title = Instance.new("TextLabel")
	local close = Instance.new("ImageButton")
	local MainSide = Instance.new("Frame")
	local sideCorner = Instance.new("UICorner")
	local coverup_2 = Instance.new("Frame")
	local tabFrames = Instance.new("Frame")
	local tabListing = Instance.new("UIListLayout")
	local pages = Instance.new("Frame")
	local Pages = Instance.new("Folder")
	local infoContainer = Instance.new("Frame")
	local blurFrame = Instance.new("Frame")
	Kavo:DraggingEnabled(MainHeader, Main)
	blurFrame.Name = "blurFrame"
	blurFrame.Parent = pages
	blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	blurFrame.BackgroundTransparency = 1
	blurFrame.BorderSizePixel = 0
	blurFrame.Position = UDim2.new(-2.00022222228, 0, -3.00071747203, 0)
	blurFrame.Size = UDim2.new(0, 376, 0, 289)
	blurFrame.ZIndex = 999
	ScreenGui.Parent = CoreGui
	ScreenGui.Name = LibName
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	Main.Name = "Main"
	Main.Active = true
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = themeList.Background
	Main.ClipsDescendants = true
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Position = UDim2.new(0.5, 0, 0.45, 0)
	Main.Size = UDim2.new(0, 525, 0, 260)
	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = Main
	MainHeader.Name = "MainHeader"
	MainHeader.Parent = Main
	MainHeader.BackgroundColor3 = themeList.Header
	Objects[MainHeader] = "BackgroundColor3"
	MainHeader.Size = UDim2.new(0, 525, 0, 27)
	headerCover.CornerRadius = UDim.new(0, 4)
	headerCover.Name = "headerCover"
	headerCover.Parent = MainHeader
	coverup.Name = "coverup"
	coverup.Parent = MainHeader
	coverup.BackgroundColor3 = themeList.Header
	Objects[coverup] = "BackgroundColor3"
	coverup.BorderSizePixel = 0
	coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
	coverup.Size = UDim2.new(0, 525, 0, 7)
	title.Name = "title"
	title.Parent = MainHeader
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
	title.Size = UDim2.new(0, 204, 0, 8)
	title.Font = Enum.Font.Gotham
	title.RichText = true
	title.Text = kavName
	title.TextColor3 = Color3.fromRGB(245, 245, 245)
	title.TextSize = 16
	title.TextXAlignment = Enum.TextXAlignment.Left
	close.Name = "close"
	close.Parent = MainHeader
	close.BackgroundTransparency = 1
	close.Position = UDim2.new(0.949999988, 0, 0.137999997, 0)
	close.Size = UDim2.new(0, 21, 0, 21)
	close.ZIndex = 2
	close.Image = "rbxassetid://3926305904"
	close.ImageRectOffset = Vector2.new(284, 4)
	close.ImageRectSize = Vector2.new(24, 24)
	close.MouseButton1Click:Connect(function()
		TweenService:Create(close, TweenInfo(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			ImageTransparency = 1
		}):Play()
		wait()
		TweenService:Create(Main, TweenInfo(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0, Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2), 0, Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2)),
		}):Play()
		wait(1)
		ScreenGui:Destroy()
	end)
	MainSide.Name = "MainSide"
	MainSide.Parent = Main
	MainSide.BackgroundColor3 = themeList.Header
	Objects[MainSide] = "Header"
	MainSide.Position = UDim2.new(0, 0, 0, 27)
	MainSide.Size = UDim2.new(0, 149, 1, -27)
	sideCorner.CornerRadius = UDim.new(0, 4)
	sideCorner.Name = "sideCorner"
	sideCorner.Parent = MainSide
	coverup_2.Name = "coverup"
	coverup_2.Parent = MainSide
	coverup_2.BackgroundColor3 = themeList.Header
	Objects[coverup_2] = "Header"
	coverup_2.BorderSizePixel = 0
	coverup_2.Position = UDim2.new(1, -7, 0, 0)
	coverup_2.Size = UDim2.new(0, 7, 1, 0)
	tabFrames.Name = "tabFrames"
	tabFrames.Parent = MainSide
	tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabFrames.BackgroundTransparency = 1
	tabFrames.Position = UDim2.new(0.0438990258, 0, -6.0006378375, 0)
	tabFrames.Size = UDim2.new(0, 135, 1, -5)
	tabListing.Name = "tabListing"
	tabListing.Parent = tabFrames
	tabListing.SortOrder = Enum.SortOrder.LayoutOrder
	pages.Name = "pages"
	pages.Parent = Main
	pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	pages.BackgroundTransparency = 1
	pages.BorderSizePixel = 0
	pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
	pages.Size = UDim2.new(0, 360, 0, 233)
	Pages.Name = "Pages"
	Pages.Parent = pages
	infoContainer.Name = "infoContainer"
	infoContainer.Parent = Main
	infoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	infoContainer.BackgroundTransparency = 1
	infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
	infoContainer.ClipsDescendants = true
	infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
	infoContainer.Size = UDim2.new(0, 368, 0, 33)
	coroutine.wrap(function()
		while wait() do
			Main.BackgroundColor3 = themeList.Background
			MainHeader.BackgroundColor3 = themeList.Header
			MainSide.BackgroundColor3 = themeList.Header
			coverup_2.BackgroundColor3 = themeList.Header
			coverup.BackgroundColor3 = themeList.Header
		end
	end)()
	function Kavo:ChangeColor(prope, color)
		if prope == "Background" then
			themeList.Background = color
		elseif prope == "SchemeColor" then
			themeList.SchemeColor = color
		elseif prope == "Header" then
			themeList.Header = color
		elseif prope == "TextColor" then
			themeList.TextColor = color
		elseif prope == "ElementColor" then
			themeList.ElementColor = color
		end
	end
	local Tabs = {}
	local first = true
	function Tabs:NewTab(tabName)
		tabName = tabName or "Tab"
		local tabButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local page = Instance.new("ScrollingFrame")
		local pageListing = Instance.new("UIListLayout")
		local function UpdateSize()
			local cS = pageListing.AbsoluteContentSize
			TweenService:Create(page, TweenInfo(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				CanvasSize = UDim2.new(0, cS.X, 0, cS.Y),
			}):Play()
		end
		page.Name = "Page"
		page.Parent = Pages
		page.Active = true
		page.BackgroundColor3 = themeList.Background
		page.BorderSizePixel = 0
		page.Position = UDim2.new(0, 0, -3.00071747208, 0)
		page.Size = UDim2.new(1, 0, 1, 0)
		page.ScrollBarThickness = 5
		page.Visible = false
		page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)
		pageListing.Name = "pageListing"
		pageListing.Parent = page
		pageListing.SortOrder = Enum.SortOrder.LayoutOrder
		pageListing.Padding = UDim.new(0, 5)
		tabButton.Name = tabName .. "TabButton"
		tabButton.Parent = tabFrames
		tabButton.BackgroundColor3 = themeList.SchemeColor
		Objects[tabButton] = "SchemeColor"
		tabButton.Size = UDim2.new(0, 135, 0, 28)
		tabButton.AutoButtonColor = false
		tabButton.Font = Enum.Font.Gotham
		tabButton.Text = tabName
		tabButton.TextColor3 = themeList.TextColor
		Objects[tabButton] = "TextColor3"
		tabButton.TextSize = 14
		tabButton.BackgroundTransparency = 1
		if first then
			first = false
			page.Visible = true
			tabButton.BackgroundTransparency = 0
			UpdateSize()
		else
			page.Visible = false
			tabButton.BackgroundTransparency = 1
		end
		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = tabButton
		table.insert(Tabs, tabName)
		UpdateSize()
		page.ChildAdded:Connect(UpdateSize)
		page.ChildRemoved:Connect(UpdateSize)
		tabButton.MouseButton1Click:Connect(function()
			UpdateSize()
			for i, v in next, Pages:GetChildren() do
				v.Visible = false
			end
			page.Visible = true
			for i, v in next, tabFrames:GetChildren() do
				if v:IsA("TextButton") then
					if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
						Utility:TweenObject(v, {
							TextColor3 = Color3.fromRGB(255, 255, 255),
						}, 0.2)
					end
					if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
						Utility:TweenObject(v, {
							TextColor3 = Color3.fromRGB(0, 0, 0),
						}, 0.2)
					end
					Utility:TweenObject(v, {
						BackgroundTransparency = 1
					}, 0.2)
				end
			end
			if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
				Utility:TweenObject(tabButton, {
					TextColor3 = Color3.fromRGB(0, 0, 0),
				}, 0.2)
			end
			if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
				Utility:TweenObject(tabButton, {
					TextColor3 = Color3.fromRGB(255, 255, 255),
				}, 0.2)
			end
			Utility:TweenObject(tabButton, {
				BackgroundTransparency = 0
			}, 0.2)
		end)
		local Sections = {}
		local focusing = false
		local viewDe = false
		coroutine.wrap(function()
			while wait() do
				page.BackgroundColor3 = themeList.Background
				page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)
				tabButton.TextColor3 = themeList.TextColor
				tabButton.BackgroundColor3 = themeList.SchemeColor
			end
		end)()
		function Sections:NewSection(secName, hidden)
			secName = secName or "Section"
			local sectionFunctions = {}
			local modules = {}
			hidden = hidden or false
			local sectionFrame = Instance.new("Frame")
			local sectionlistoknvm = Instance.new("UIListLayout")
			local sectionHead = Instance.new("Frame")
			local sHeadCorner = Instance.new("UICorner")
			local sectionName = Instance.new("TextLabel")
			local sectionInners = Instance.new("Frame")
			local sectionElListing = Instance.new("UIListLayout")
			if hidden then
				sectionHead.Visible = false
			else
				sectionHead.Visible = true
			end
			sectionFrame.Name = "sectionFrame"
			sectionFrame.Parent = page
			sectionFrame.BackgroundColor3 = themeList.Background
			sectionFrame.BorderSizePixel = 0
			sectionlistoknvm.Name = "sectionlistoknvm"
			sectionlistoknvm.Parent = sectionFrame
			sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
			sectionlistoknvm.Padding = UDim.new(0, 5)
			for i, v in pairs(sectionInners:GetChildren()) do
				while wait() do
					if v:IsA("Frame") or v:IsA("TextButton") then
						function size(pro)
							if pro == "Size" then
								UpdateSize()
								updateSectionFrame()
							end
						end
						v.Changed:Connect(size)
					end
				end
			end
			sectionHead.Name = "sectionHead"
			sectionHead.Parent = sectionFrame
			sectionHead.BackgroundColor3 = themeList.SchemeColor
			Objects[sectionHead] = "BackgroundColor3"
			sectionHead.Size = UDim2.new(0, 352, 0, 33)
			sHeadCorner.CornerRadius = UDim.new(0, 4)
			sHeadCorner.Name = "sHeadCorner"
			sHeadCorner.Parent = sectionHead
			sectionName.Name = "sectionName"
			sectionName.Parent = sectionHead
			sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sectionName.BackgroundTransparency = 1
			sectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
			sectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
			sectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
			sectionName.Font = Enum.Font.Gotham
			sectionName.Text = secName
			sectionName.RichText = true
			sectionName.TextColor3 = themeList.TextColor
			Objects[sectionName] = "TextColor3"
			sectionName.TextSize = 14
			sectionName.TextXAlignment = Enum.TextXAlignment.Left
			if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
				Utility:TweenObject(sectionName, {
					TextColor3 = Color3.fromRGB(0, 0, 0),
				}, 0.2)
			end
			if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
				Utility:TweenObject(sectionName, {
					TextColor3 = Color3.fromRGB(255, 255, 255),
				}, 0.2)
			end
			sectionInners.Name = "sectionInners"
			sectionInners.Parent = sectionFrame
			sectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sectionInners.BackgroundTransparency = 1
			sectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)
			sectionElListing.Name = "sectionElListing"
			sectionElListing.Parent = sectionInners
			sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
			sectionElListing.Padding = UDim.new(0, 3)
			coroutine.wrap(function()
				while wait() do
					sectionFrame.BackgroundColor3 = themeList.Background
					sectionHead.BackgroundColor3 = themeList.SchemeColor
					tabButton.TextColor3 = themeList.TextColor
					tabButton.BackgroundColor3 = themeList.SchemeColor
					sectionName.TextColor3 = themeList.TextColor
				end
			end)()
			local function updateSectionFrame()
				local innerSc = sectionElListing.AbsoluteContentSize
				sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
				local frameSc = sectionlistoknvm.AbsoluteContentSize
				sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
			end
			updateSectionFrame()
			UpdateSize()
			local Elements = {}
			function Elements:NewButton(bname, tipINf, callback)
				showLogo = showLogo or true
				local ButtonFunction = {}
				tipINf = tipINf or "Tip: Clicking this nothing will happen!"
				bname = bname or "Click Me!"
				callback = callback or function()
				end
				local buttonElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local btnInfo = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local touch = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")
				table.insert(modules, bname)
				buttonElement.Name = bname
				buttonElement.Parent = sectionInners
				buttonElement.BackgroundColor3 = themeList.ElementColor
				buttonElement.ClipsDescendants = true
				buttonElement.Size = UDim2.new(0, 352, 0, 33)
				buttonElement.AutoButtonColor = false
				buttonElement.Font = Enum.Font.SourceSans
				buttonElement.Text = ''
				buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				buttonElement.TextSize = 14
				Objects[buttonElement] = "BackgroundColor3"
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = buttonElement
				viewInfo.Name = "viewInfo"
				viewInfo.Parent = buttonElement
				viewInfo.BackgroundTransparency = 1
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				Objects[viewInfo] = "ImageColor3"
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)
				Sample.Name = "Sample"
				Sample.Parent = buttonElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Objects[Sample] = "ImageColor3"
				Sample.ImageTransparency = 0.6
				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.Text = "  " .. tipINf
				moreInfo.RichText = true
				moreInfo.TextColor3 = themeList.TextColor
				Objects[moreInfo] = "TextColor3"
				moreInfo.TextSize = 14
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left
				Objects[moreInfo] = "BackgroundColor3"
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo
				touch.Name = "touch"
				touch.Parent = buttonElement
				touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				touch.BackgroundTransparency = 1
				touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
				touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				touch.Size = UDim2.new(0, 21, 0, 21)
				touch.Image = "rbxassetid://3926305904"
				touch.ImageColor3 = themeList.SchemeColor
				Objects[touch] = "SchemeColor"
				touch.ImageRectOffset = Vector2.new(84, 204)
				touch.ImageRectSize = Vector2.new(36, 36)
				touch.ImageTransparency = 0
				btnInfo.Name = "btnInfo"
				btnInfo.Parent = buttonElement
				btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				btnInfo.BackgroundTransparency = 1
				btnInfo.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				btnInfo.Size = UDim2.new(0, 314, 0, 14)
				btnInfo.Font = Enum.Font.GothamSemibold
				btnInfo.Text = bname
				btnInfo.RichText = true
				btnInfo.TextColor3 = themeList.TextColor
				Objects[btnInfo] = "TextColor3"
				btnInfo.TextSize = 14
				btnInfo.TextXAlignment = Enum.TextXAlignment.Left
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				updateSectionFrame()
				UpdateSize()
				local ms = Players.LocalPlayer:GetMouse()
				local btn = buttonElement
				local sample = Sample
				btn.MouseButton1Click:Connect(function()
					if not focusing then
						callback()
						local c = sample:Clone()
						c.Parent = btn
						local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
						c.Position = UDim2.new(0, x, 0, y)
						local len, size = 0.35, nil
						if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
							size = (btn.AbsoluteSize.X * 1.5)
						else
							size = (btn.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (- size / 2), 0.5, (- size / 2)), "Out", "Quad", len, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(len / 12)
						end
						c:Destroy()
					else
						for i, v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						hovering = false
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i, v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(btn, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							buttonElement.BackgroundColor3 = themeList.ElementColor
						end
						viewInfo.ImageColor3 = themeList.SchemeColor
						Sample.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
						touch.ImageColor3 = themeList.SchemeColor
						btnInfo.TextColor3 = themeList.TextColor
					end
				end)()
				function ButtonFunction:UpdateButton(newTitle)
					btnInfo.Text = newTitle
				end
				return ButtonFunction
			end
			function Elements:NewTextBox(tname, tTip, callback)
				tname = tname or "Textbox"
				tTip = tTip or "Gets a value of Textbox"
				callback = callback or function()
				end
				local textboxElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local viewInfo = Instance.new("ImageButton")
				local write = Instance.new("ImageLabel")
				local TextBox = Instance.new("TextBox")
				local UICorner_2 = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")
				textboxElement.Name = "textboxElement"
				textboxElement.Parent = sectionInners
				textboxElement.BackgroundColor3 = themeList.ElementColor
				textboxElement.ClipsDescendants = true
				textboxElement.Size = UDim2.new(0, 352, 0, 33)
				textboxElement.AutoButtonColor = false
				textboxElement.Font = Enum.Font.SourceSans
				textboxElement.Text = ''
				textboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				textboxElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = textboxElement
				viewInfo.Name = "viewInfo"
				viewInfo.Parent = textboxElement
				viewInfo.BackgroundTransparency = 1
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)
				write.Name = "write"
				write.Parent = textboxElement
				write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				write.BackgroundTransparency = 1
				write.BorderColor3 = Color3.fromRGB(27, 42, 53)
				write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				write.Size = UDim2.new(0, 21, 0, 21)
				write.Image = "rbxassetid://3926305904"
				write.ImageColor3 = themeList.SchemeColor
				write.ImageRectOffset = Vector2.new(324, 604)
				write.ImageRectSize = Vector2.new(36, 36)
				TextBox.Parent = textboxElement
				TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
				TextBox.BorderSizePixel = 0
				TextBox.ClipsDescendants = true
				TextBox.Position = UDim2.new(0.488749921, 0, 0.212121218, 0)
				TextBox.Size = UDim2.new(0, 150, 0, 18)
				TextBox.ZIndex = 99
				TextBox.ClearTextOnFocus = false
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
				TextBox.PlaceholderText = "Type here!"
				TextBox.Text = ''
				TextBox.TextColor3 = themeList.SchemeColor
				TextBox.TextSize = 12
				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = TextBox
				togName.Name = "togName"
				togName.Parent = textboxElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 138, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = tname
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14
				togName.TextXAlignment = Enum.TextXAlignment.Left
				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.RichText = true
				moreInfo.Text = "  " .. tTip
				moreInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
				moreInfo.TextSize = 14
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo
				updateSectionFrame()
				UpdateSize()
				local btn = textboxElement
				local infBtn = viewInfo
				btn.MouseButton1Click:Connect(function()
					if focusing then
						for i, v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						hovering = false
					end
				end)
				TextBox.FocusLost:Connect(function(EnterPressed)
					if focusing then
						for i, v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
					if not EnterPressed then
						return
					else
						callback(TextBox.Text)
						wait(0.18)
						TextBox.Text = ''
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i, v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(btn, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							textboxElement.BackgroundColor3 = themeList.ElementColor
						end
						TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
						viewInfo.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
						write.ImageColor3 = themeList.SchemeColor
						togName.TextColor3 = themeList.TextColor
						TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
						TextBox.TextColor3 = themeList.SchemeColor
					end
				end)()
			end
			function Elements:NewToggle(tname, nTip, callback)
				local TogFunction = {}
				tname = tname or "Toggle"
				nTip = nTip or "Prints Current Toggle State"
				callback = callback or function()
				end
				local toggled = false
				table.insert(SettingsT, tname)
				local toggleElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local toggleDisabled = Instance.new("ImageLabel")
				local toggleEnabled = Instance.new("ImageLabel")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local Sample = Instance.new("ImageLabel")
				toggleElement.Name = "toggleElement"
				toggleElement.Parent = sectionInners
				toggleElement.BackgroundColor3 = themeList.ElementColor
				toggleElement.ClipsDescendants = true
				toggleElement.Size = UDim2.new(0, 352, 0, 33)
				toggleElement.AutoButtonColor = false
				toggleElement.Font = Enum.Font.SourceSans
				toggleElement.Text = ''
				toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				toggleElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = toggleElement
				toggleDisabled.Name = "toggleDisabled"
				toggleDisabled.Parent = toggleElement
				toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleDisabled.BackgroundTransparency = 1
				toggleDisabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				toggleDisabled.Image = "rbxassetid://3926309567"
				toggleDisabled.ImageColor3 = themeList.SchemeColor
				toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				toggleDisabled.ImageRectSize = Vector2.new(48, 48)
				toggleEnabled.Name = "toggleEnabled"
				toggleEnabled.Parent = toggleElement
				toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleEnabled.BackgroundTransparency = 1
				toggleEnabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				toggleEnabled.Image = "rbxassetid://3926309567"
				toggleEnabled.ImageColor3 = themeList.SchemeColor
				toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				toggleEnabled.ImageRectSize = Vector2.new(48, 48)
				toggleEnabled.ImageTransparency = 1
				togName.Name = "togName"
				togName.Parent = toggleElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 288, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = tname
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14
				togName.TextXAlignment = Enum.TextXAlignment.Left
				viewInfo.Name = "viewInfo"
				viewInfo.Parent = toggleElement
				viewInfo.BackgroundTransparency = 1
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)
				Sample.Name = "Sample"
				Sample.Parent = toggleElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.6
				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.RichText = true
				moreInfo.Text = "  " .. nTip
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo
				local ms = Players.LocalPlayer:GetMouse()
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				local btn = toggleElement
				local sample = Sample
				local img = toggleEnabled
				local infBtn = viewInfo
				updateSectionFrame()
				UpdateSize()
				btn.MouseButton1Click:Connect(function()
					if not focusing then
						if toggled == false then
							TweenService:Create(img, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								ImageTransparency = 0
							}):Play()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (- size / 2), 0.5, (- size / 2)), "Out", "Quad", len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						else
							TweenService:Create(img, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								ImageTransparency = 1
							}):Play()
							local c = sample:Clone()
							c.Parent = btn
							local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (- size / 2), 0.5, (- size / 2)), "Out", "Quad", len, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(len / 12)
							end
							c:Destroy()
						end
						toggled = not toggled
						pcall(callback, toggled)
					else
						for i, v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						hovering = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							toggleElement.BackgroundColor3 = themeList.ElementColor
						end
						toggleDisabled.ImageColor3 = themeList.SchemeColor
						toggleEnabled.ImageColor3 = themeList.SchemeColor
						togName.TextColor3 = themeList.TextColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						Sample.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
					end
				end)()
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i, v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(btn, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				function TogFunction:UpdateToggle(newText, isTogOn)
					isTogOn = isTogOn or toggle
					if newText ~= nil then
						togName.Text = newText
					end
					if isTogOn then
						toggled = true
						TweenService:Create(img, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							ImageTransparency = 0
						}):Play()
						pcall(callback, toggled)
					else
						toggled = false
						TweenService:Create(img, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							ImageTransparency = 1
						}):Play()
						pcall(callback, toggled)
					end
				end
				return TogFunction
			end
			function Elements:NewSlider(slidInf, slidTip, maxvalue, minvalue, callback)
				slidInf = slidInf or "Slider"
				slidTip = slidTip or "Slider tip here"
				maxvalue = maxvalue or 500
				minvalue = minvalue or 16
				startVal = startVal or 0
				callback = callback or function()
				end
				local sliderElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local sliderBtn = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local sliderDrag = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local write = Instance.new("ImageLabel")
				local val = Instance.new("TextLabel")
				sliderElement.Name = "sliderElement"
				sliderElement.Parent = sectionInners
				sliderElement.BackgroundColor3 = themeList.ElementColor
				sliderElement.ClipsDescendants = true
				sliderElement.Size = UDim2.new(0, 352, 0, 33)
				sliderElement.AutoButtonColor = false
				sliderElement.Font = Enum.Font.SourceSans
				sliderElement.Text = ''
				sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				sliderElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = sliderElement
				togName.Name = "togName"
				togName.Parent = sliderElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1
				togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 138, 0, 14)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = slidInf
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14
				togName.TextXAlignment = Enum.TextXAlignment.Left
				viewInfo.Name = "viewInfo"
				viewInfo.Parent = sliderElement
				viewInfo.BackgroundTransparency = 1
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)
				sliderBtn.Name = "sliderBtn"
				sliderBtn.Parent = sliderElement
				sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255 + 5)
				sliderBtn.BorderSizePixel = 0
				sliderBtn.Position = UDim2.new(0.488749951, 0, 0.393939406, 0)
				sliderBtn.Size = UDim2.new(0, 149, 0, 6)
				sliderBtn.AutoButtonColor = false
				sliderBtn.Font = Enum.Font.SourceSans
				sliderBtn.Text = ''
				sliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
				sliderBtn.TextSize = 14
				UICorner_2.Parent = sliderBtn
				UIListLayout.Parent = sliderBtn
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				sliderDrag.Name = "sliderDrag"
				sliderDrag.Parent = sliderBtn
				sliderDrag.BackgroundColor3 = themeList.SchemeColor
				sliderDrag.BorderColor3 = Color3.fromRGB(74, 99, 135)
				sliderDrag.BorderSizePixel = 0
				sliderDrag.Size = UDim2.new(-0.671140969, 100, 1, 0)
				UICorner_3.Parent = sliderDrag
				write.Name = "write"
				write.Parent = sliderElement
				write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				write.BackgroundTransparency = 1
				write.BorderColor3 = Color3.fromRGB(27, 42, 53)
				write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				write.Size = UDim2.new(0, 21, 0, 21)
				write.Image = "rbxassetid://3926307971"
				write.ImageColor3 = themeList.SchemeColor
				write.ImageRectOffset = Vector2.new(404, 164)
				write.ImageRectSize = Vector2.new(36, 36)
				val.Name = "val"
				val.Parent = sliderElement
				val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				val.BackgroundTransparency = 1
				val.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
				val.Size = UDim2.new(0, 41, 0, 14)
				val.Font = Enum.Font.GothamSemibold
				val.Text = minvalue
				val.TextColor3 = themeList.TextColor
				val.TextSize = 14
				val.TextTransparency = 1
				val.TextXAlignment = Enum.TextXAlignment.Right
				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.RichText = true
				moreInfo.Text = "  " .. slidTip
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo
				updateSectionFrame()
				UpdateSize()
				local btn = sliderElement
				local infBtn = viewInfo
				btn.MouseButton1Click:Connect(function()
					if focusing then
						for i, v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						hovering = false
					end
				end)
				local ms = Players.LocalPlayer:GetMouse()
				local uis = UserInputService
				local mouse = Players.LocalPlayer:GetMouse()
				local val = val
				local sliderBtn = sliderBtn
				local sliderDrag = sliderDrag
				local Value
				sliderBtn.MouseButton1Down:Connect(function()
					if not focusing then
						TweenService:Create(val, TweenInfo(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
							TextTransparency = 0
						}):Play()
						Value = math.floor((((tostring(mouse.X - sliderBtn.AbsolutePosition.X) / sliderBtn.AbsoluteSize.X) * (maxvalue - minvalue)) + minvalue) + 0.5)
						if Value < minvalue then
							Value = minvalue
						elseif Value > maxvalue then
							Value = maxvalue
						end
						val.Text = tostring(Value)
						pcall(callback, Value)
						sliderDrag.Size = UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, sliderBtn.AbsoluteSize.X), 1, 0)
						moveconnection = mouse.Move:Connect(function()
							Value = math.floor((((tostring(mouse.X - sliderBtn.AbsolutePosition.X) / sliderBtn.AbsoluteSize.X) * (maxvalue - minvalue)) + minvalue) + 0.5)
							if Value < minvalue then
								Value = minvalue
							elseif Value > maxvalue then
								Value = maxvalue
							end
							val.Text = tostring(Value)
							pcall(callback, Value)
							sliderDrag.Size = UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, sliderBtn.AbsoluteSize.X), 1, 0)
						end)
						releaseconnection = uis.InputEnded:Connect(function(Mouse)
							if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
								Value = math.floor((((tostring(mouse.X - sliderBtn.AbsolutePosition.X) / sliderBtn.AbsoluteSize.X) * (maxvalue - minvalue)) + minvalue) + 0.5)
								if Value < minvalue then
									Value = minvalue
								elseif Value > maxvalue then
									Value = maxvalue
								end
								val.Text = tostring(Value)
								pcall(callback, Value)
								sliderDrag.Size = UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, sliderBtn.AbsoluteSize.X), 1, 0)
								moveconnection:Disconnect()
								releaseconnection:Disconnect()
								TweenService:Create(val, TweenInfo(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
									TextTransparency = 1
								}):Play()
							end
						end)
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i, v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(btn, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							sliderElement.BackgroundColor3 = themeList.ElementColor
						end
						togName.TextColor3 = themeList.TextColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255 + 5)
						sliderDrag.BackgroundColor3 = themeList.SchemeColor
						write.ImageColor3 = themeList.SchemeColor
						val.TextColor3 = themeList.TextColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
					end
				end)()
			end
			function Elements:NewDropdown(dName, dTip, list, callback)
				dName = dName or "Dropdown"
				dTip = dTip or "Dropdown tip text here"
				list = list or {}
				callback = callback or function()
				end
				local opened = false
				local dropdownElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local write = Instance.new("ImageLabel")
				local DropFolder = Instance.new("ScrollingFrame")
				local listLayout = Instance.new("UIListLayout")
				dropdownElement.Name = "dropdownElement"
				dropdownElement.Parent = sectionInners
				dropdownElement.BackgroundColor3 = themeList.ElementColor
				dropdownElement.ClipsDescendants = true
				dropdownElement.Size = UDim2.new(0, 352, 0, 33)
				dropdownElement.AutoButtonColor = false
				dropdownElement.Font = Enum.Font.SourceSans
				dropdownElement.Text = ''
				dropdownElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				dropdownElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = dropdownElement
				togName.Name = "togName"
				togName.Parent = dropdownElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1
				togName.Position = UDim2.new(0.096704483, 0, 0.080000001, 0)
				togName.Size = UDim2.new(0, 138, 0, 27)
				togName.Font = Enum.Font.GothamSemibold
				togName.Text = dName
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 14
				togName.TextXAlignment = Enum.TextXAlignment.Left
				viewInfo.Name = "viewInfo"
				viewInfo.Parent = dropdownElement
				viewInfo.BackgroundTransparency = 1
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 23, 0, 23)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://3926305904"
				viewInfo.ImageColor3 = themeList.SchemeColor
				viewInfo.ImageRectOffset = Vector2.new(764, 764)
				viewInfo.ImageRectSize = Vector2.new(36, 36)
				write.Name = "write"
				write.Parent = dropdownElement
				write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				write.BackgroundTransparency = 1
				write.BorderColor3 = Color3.fromRGB(27, 42, 53)
				write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				write.Size = UDim2.new(0, 21, 0, 21)
				write.Image = "rbxassetid://3926305904"
				write.ImageColor3 = themeList.SchemeColor
				write.ImageRectOffset = Vector2.new(564, 284)
				write.ImageRectSize = Vector2.new(36, 36)
				DropFolder.Name = "DropFolder"
				DropFolder.Parent = dropdownElement
				DropFolder.Active = true
				DropFolder.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 5, themeList.ElementColor.g * 255 - 5, themeList.ElementColor.b * 255 - 5)
				DropFolder.BorderSizePixel = 0
				DropFolder.Position = UDim2.new(0.0227272715, 0, 0, 35)
				DropFolder.Size = UDim2.new(0, 335, 0, 0)
				DropFolder.ScrollBarThickness = 5
				DropFolder.Visible = false
				listLayout.Parent = DropFolder
				listLayout.SortOrder = Enum.SortOrder.LayoutOrder
				listLayout.Padding = UDim.new(0, 3)
				local moreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				moreInfo.Name = "TipMore"
				moreInfo.Parent = infoContainer
				moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				moreInfo.Position = UDim2.new(0, 0, 2, 0)
				moreInfo.Size = UDim2.new(0, 353, 0, 33)
				moreInfo.ZIndex = 9
				moreInfo.Font = Enum.Font.GothamSemibold
				moreInfo.RichText = true
				moreInfo.Text = "  " .. dTip
				moreInfo.TextColor3 = themeList.TextColor
				moreInfo.TextSize = 14
				moreInfo.TextXAlignment = Enum.TextXAlignment.Left
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(moreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = moreInfo
				updateSectionFrame()
				UpdateSize()
				local btn = dropdownElement
				local folder = DropFolder
				local infBtn = viewInfo
				local function refreshFolder()
					local cS = listLayout.AbsoluteContentSize
					if cS.Y < 80 then
						folder.Size = UDim2.new(0, 335, 0, cS.Y + 5)
					else
						folder.Size = UDim2.new(0, 335, 0, 80)
					end
					folder.CanvasSize = UDim2.new(0, cS.X, 0, cS.Y + 5)
				end
				btn.MouseButton1Click:Connect(function()
					if not focusing then
						if opened == false then
							opened = true
							folder.Visible = true
							refreshFolder()
							TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								Size = UDim2.new(0, 352, 0, folder.Size.Y.Offset + 40),
							}):Play()
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
						else
							opened = false
							TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								Size = UDim2.new(0, 352, 0, 33),
							}):Play()
							wait(0.1)
							folder.Visible = false
							updateSectionFrame()
							UpdateSize()
						end
					else
						for i, v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				for i, v in pairs(list) do
					local item = Instance.new("TextButton")
					local UICorner = Instance.new("UICorner")
					item.Name = "item"
					item.Parent = folder
					item.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 7, themeList.ElementColor.g * 255 + 7, themeList.ElementColor.b * 255 + 7)
					item.Size = UDim2.new(0, 325, 0, 22)
					item.Font = Enum.Font.GothamSemibold
					item.Text = "  " .. v
					item.TextColor3 = themeList.TextColor
					item.TextSize = 12
					item.TextXAlignment = Enum.TextXAlignment.Left
					UICorner.CornerRadius = UDim.new(0, 4)
					UICorner.Parent = item
					item.MouseButton1Click:Connect(function()
						opened = false
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							Size = UDim2.new(0, 352, 0, 33),
						}):Play()
						wait(0.1)
						folder.Visible = false
						updateSectionFrame()
						UpdateSize()
						callback(v)
						togName.Text = dName .. " - " .. v
					end)
				end
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						TweenService:Create(btn, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						hovering = false
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						for i, v in next, infoContainer:GetChildren() do
							if v ~= moreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(btn, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(moreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(blurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not hovering then
							dropdownElement.BackgroundColor3 = themeList.ElementColor
						end
						DropFolder.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 5, themeList.ElementColor.g * 255 - 5, themeList.ElementColor.b * 255 - 5)
						togName.TextColor3 = themeList.TextColor
						viewInfo.ImageColor3 = themeList.SchemeColor
						write.ImageColor3 = themeList.SchemeColor
						moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						moreInfo.TextColor3 = themeList.TextColor
					end
				end)()
				function Elements:NewLabel(title)
                local labelFunctions = {}
                local label = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")
                label.Name = "label"
                label.Parent = sectionInners
                label.BackgroundColor3 = themeList.SchemeColor
                label.BorderSizePixel = 0
                label.ClipsDescendants = true
                label.Text = title
                label.Size = UDim2.new(0, 352, 0, 33)
                label.Font = Enum.Font.Gotham
                label.Text = "  " .. title
                label.RichText = true
                label.TextColor3 = themeList.TextColor
                Objects[label] = "TextColor3"
                label.TextSize = 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = label
                if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
                    Utility:TweenObject(label, {
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                    }, 0.2)
                end
                if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
                    Utility:TweenObject(label, {
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                    }, 0.2)
                end
                coroutine.wrap(function()
                    while wait() do
                        label.BackgroundColor3 = themeList.SchemeColor
                        label.TextColor3 = themeList.TextColor
                    end
                end)()
                updateSectionFrame()
                UpdateSize()
                function labelFunctions:UpdateLabel(newText)
                    if label.Text ~= "  " .. newText then
                        label.Text = "  " .. newText
                    end
                end
                return labelFunctions
			end
			return Elements
		end
		return Sections
	end
	return Tabs
end

return Kavo
