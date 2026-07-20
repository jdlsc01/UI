local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local TweenInfo = TweenInfo.new
local Kavo = {}
local Utility = {}
local Objects = {}
function Kavo:DraggingEnabled(frame, parent)
	parent = parent or frame
	local Dragging = false
	local DragInput, MousePos, FramePos
	frame.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			MousePos = Input.Position
			FramePos = parent.Position
			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			DragInput = Input
		end
	end)
	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - MousePos
			parent.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
		end
	end)
end
function Utility:TweenObject(obj, properties, duration, ...)
	TweenService:Create(obj, TweenInfo(duration, ...), properties):Play()
end
local Themes = {
	SchemeColor = Color3.fromRGB(74, 99, 135),
	Background = Color3.fromRGB(36, 37, 43),
	Header = Color3.fromRGB(28, 29, 34),
	TextColor = Color3.fromRGB(255, 255, 255),
	ElementColor = Color3.fromRGB(32, 32, 38),
}
local ThemeStyles = {
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
local OldTheme = ''
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
		themeList = Themes
	end
	if themeList == "DarkTheme" then
		themeList = ThemeStyles.DarkTheme
	elseif themeList == "LightTheme" then
		themeList = ThemeStyles.LightTheme
	elseif themeList == "BloodTheme" then
		themeList = ThemeStyles.BloodTheme
	elseif themeList == "GrapeTheme" then
		themeList = ThemeStyles.GrapeTheme
	elseif themeList == "Grey" then
		themeList = ThemeStyles.Grey
	elseif themeList == "Red" then
		themeList = ThemeStyles.Red
	elseif themeList == "Green" then
		themeList = ThemeStyles.Green
	elseif themeList == "Blue" then
		themeList = ThemeStyles.Blue
	elseif themeList == "Yellow" then
		themeList = ThemeStyles.Yellow
	elseif themeList == "Orange" then
		themeList = ThemeStyles.Orange
	elseif themeList == "Pink" then
		themeList = ThemeStyles.Pink
	elseif themeList == "Purple" then
		themeList = ThemeStyles.Purple
	elseif themeList == "Serpent" then
		themeList = ThemeStyles.Serpent
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
	local SelectedTab
	kavName = kavName or "Library"
	table.insert(Kavo, kavName)
	for i, v in pairs(CoreGui:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == kavName then
			v:Destroy()
		end
	end
	local ScreenGui = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local MainHeader = Instance.new("Frame")
	local HeaderCover = Instance.new("UICorner")
	local CoverUp = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Close = Instance.new("ImageButton")
	local MainSide = Instance.new("Frame")
	local SideCorner = Instance.new("UICorner")
	local CoverUp2 = Instance.new("Frame")
	local TabFrames = Instance.new("Frame")
	local TabListing = Instance.new("UIListLayout")
	local PagesFrame = Instance.new("Frame")
	local Pages = Instance.new("Folder")
	local InfoContainer = Instance.new("Frame")
	local BlurFrame = Instance.new("Frame")
	Kavo:DraggingEnabled(MainHeader, Main)
	BlurFrame.Name = "BlurFrame"
	BlurFrame.Parent = PagesFrame
	BlurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	BlurFrame.BackgroundTransparency = 1
	BlurFrame.BorderSizePixel = 0
	BlurFrame.Position = UDim2.new(-2.00022222228, 0, -3.00071747203, 0)
	BlurFrame.Size = UDim2.new(0, 376, 0, 289)
	BlurFrame.ZIndex = 999
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
	HeaderCover.CornerRadius = UDim.new(0, 4)
	HeaderCover.Name = "HeaderCover"
	HeaderCover.Parent = MainHeader
	CoverUp.Name = "CoverUp"
	CoverUp.Parent = MainHeader
	CoverUp.BackgroundColor3 = themeList.Header
	Objects[CoverUp] = "BackgroundColor3"
	CoverUp.BorderSizePixel = 0
	CoverUp.Position = UDim2.new(0, 0, 0.758620679, 0)
	CoverUp.Size = UDim2.new(0, 525, 0, 7)
	Title.Name = "Title"
	Title.Parent = MainHeader
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
	Title.Size = UDim2.new(0, 204, 0, 8)
	Title.Font = Enum.Font.Gotham
	Title.RichText = true
	Title.Text = kavName
	Title.TextColor3 = Color3.fromRGB(245, 245, 245)
	Title.TextSize = 16
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Close.Name = "Close"
	Close.Parent = MainHeader
	Close.BackgroundTransparency = 1
	Close.Position = UDim2.new(0.949999988, 0, 0.137999997, 0)
	Close.Size = UDim2.new(0, 21, 0, 21)
	Close.ZIndex = 2
	Close.Image = "rbxassetid://3926305904"
	Close.ImageRectOffset = Vector2.new(284, 4)
	Close.ImageRectSize = Vector2.new(24, 24)
	Close.MouseButton1Click:Connect(function()
		TweenService:Create(Close, TweenInfo(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
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
	SideCorner.CornerRadius = UDim.new(0, 4)
	SideCorner.Name = "SideCorner"
	SideCorner.Parent = MainSide
	CoverUp2.Name = "CoverUp"
	CoverUp2.Parent = MainSide
	CoverUp2.BackgroundColor3 = themeList.Header
	Objects[CoverUp2] = "Header"
	CoverUp2.BorderSizePixel = 0
	CoverUp2.Position = UDim2.new(1, -7, 0, 0)
	CoverUp2.Size = UDim2.new(0, 7, 1, 0)
	TabFrames.Name = "TabFrames"
	TabFrames.Parent = MainSide
	TabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabFrames.BackgroundTransparency = 1
	TabFrames.Position = UDim2.new(0.0438990258, 0, -6.0006378375, 0)
	TabFrames.Size = UDim2.new(0, 135, 1, -5)
	TabListing.Name = "TabListing"
	TabListing.Parent = TabFrames
	TabListing.SortOrder = Enum.SortOrder.LayoutOrder
	PagesFrame.Name = "PagesFrame"
	PagesFrame.Parent = Main
	PagesFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PagesFrame.BackgroundTransparency = 1
	PagesFrame.BorderSizePixel = 0
	PagesFrame.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
	PagesFrame.Size = UDim2.new(0, 360, 0, 233)
	Pages.Name = "Pages"
	Pages.Parent = PagesFrame
	InfoContainer.Name = "InfoContainer"
	InfoContainer.Parent = Main
	InfoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InfoContainer.BackgroundTransparency = 1
	InfoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
	InfoContainer.ClipsDescendants = true
	InfoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
	InfoContainer.Size = UDim2.new(0, 368, 0, 33)
	coroutine.wrap(function()
		while wait() do
			Main.BackgroundColor3 = themeList.Background
			MainHeader.BackgroundColor3 = themeList.Header
			MainSide.BackgroundColor3 = themeList.Header
			CoverUp2.BackgroundColor3 = themeList.Header
			CoverUp.BackgroundColor3 = themeList.Header
		end
	end)()
	function Kavo:ChangeColor(prope, Color)
		if prope == "Background" then
			themeList.Background = Color
		elseif prope == "SchemeColor" then
			themeList.SchemeColor = Color
		elseif prope == "Header" then
			themeList.Header = Color
		elseif prope == "TextColor" then
			themeList.TextColor = Color
		elseif prope == "ElementColor" then
			themeList.ElementColor = Color
		end
	end
	local Tabs = {}
	local First = true
	function Tabs:NewTab(tabName)
		tabName = tabName or "Tab"
		local TabButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local Page = Instance.new("ScrollingFrame")
		local PageListing = Instance.new("UIListLayout")
		local function UpdateSize()
			local ContentSize = PageListing.AbsoluteContentSize
			TweenService:Create(Page, TweenInfo(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				CanvasSize = UDim2.new(0, ContentSize.X, 0, ContentSize.Y),
			}):Play()
		end
		Page.Name = "Page"
		Page.Parent = Pages
		Page.Active = true
		Page.BackgroundColor3 = themeList.Background
		Page.BorderSizePixel = 0
		Page.Position = UDim2.new(0, 0, -3.00071747208, 0)
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.ScrollBarThickness = 5
		Page.Visible = false
		Page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)
		PageListing.Name = "PageListing"
		PageListing.Parent = Page
		PageListing.SortOrder = Enum.SortOrder.LayoutOrder
		PageListing.Padding = UDim.new(0, 5)
		TabButton.Name = tabName .. "TabButton"
		TabButton.Parent = TabFrames
		TabButton.BackgroundColor3 = themeList.SchemeColor
		Objects[TabButton] = "SchemeColor"
		TabButton.Size = UDim2.new(0, 135, 0, 28)
		TabButton.AutoButtonColor = false
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = tabName
		TabButton.TextColor3 = themeList.TextColor
		Objects[TabButton] = "TextColor3"
		TabButton.TextSize = 14
		TabButton.BackgroundTransparency = 1
		if First then
			First = false
			Page.Visible = true
			TabButton.BackgroundTransparency = 0
			UpdateSize()
		else
			Page.Visible = false
			TabButton.BackgroundTransparency = 1
		end
		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = TabButton
		table.insert(Tabs, tabName)
		UpdateSize()
		Page.ChildAdded:Connect(UpdateSize)
		Page.ChildRemoved:Connect(UpdateSize)
		TabButton.MouseButton1Click:Connect(function()
			UpdateSize()
			for i, v in next, Pages:GetChildren() do
				v.Visible = false
			end
			Page.Visible = true
			for i, v in next, TabFrames:GetChildren() do
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
				Utility:TweenObject(TabButton, {
					TextColor3 = Color3.fromRGB(0, 0, 0),
				}, 0.2)
			end
			if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
				Utility:TweenObject(TabButton, {
					TextColor3 = Color3.fromRGB(255, 255, 255),
				}, 0.2)
			end
			Utility:TweenObject(TabButton, {
				BackgroundTransparency = 0
			}, 0.2)
		end)
		local Sections = {}
		local Focusing = false
		local ViewDetails = false
		coroutine.wrap(function()
			while wait() do
				Page.BackgroundColor3 = themeList.Background
				Page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)
				TabButton.TextColor3 = themeList.TextColor
				TabButton.BackgroundColor3 = themeList.SchemeColor
			end
		end)()
		function Sections:NewSection(secName, hidden)
			secName = secName or "Section"
			local SectionFunctions = {}
			local Modules = {}
			hidden = hidden or false
			local SectionFrame = Instance.new("Frame")
			local SectionListLayout = Instance.new("UIListLayout")
			local SectionHead = Instance.new("Frame")
			local SectionHeadCorner = Instance.new("UICorner")
			local SectionName = Instance.new("TextLabel")
			local SectionInners = Instance.new("Frame")
			local SectionElListing = Instance.new("UIListLayout")
			if hidden then
				SectionHead.Visible = false
			else
				SectionHead.Visible = true
			end
			SectionFrame.Name = "SectionFrame"
			SectionFrame.Parent = Page
			SectionFrame.BackgroundColor3 = themeList.Background
			SectionFrame.BorderSizePixel = 0
			SectionListLayout.Name = "SectionListLayout"
			SectionListLayout.Parent = SectionFrame
			SectionListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SectionListLayout.Padding = UDim.new(0, 5)
			for i, v in pairs(SectionInners:GetChildren()) do
				while wait() do
					if v:IsA("Frame") or v:IsA("TextButton") then
						function Size(pro)
							if pro == "Size" then
								UpdateSize()
								UpdateSectionFrame()
							end
						end
						v.Changed:Connect(Size)
					end
				end
			end
			SectionHead.Name = "SectionHead"
			SectionHead.Parent = SectionFrame
			SectionHead.BackgroundColor3 = themeList.SchemeColor
			Objects[SectionHead] = "BackgroundColor3"
			SectionHead.Size = UDim2.new(0, 352, 0, 33)
			SectionHeadCorner.CornerRadius = UDim.new(0, 4)
			SectionHeadCorner.Name = "SectionHeadCorner"
			SectionHeadCorner.Parent = SectionHead
			SectionName.Name = "SectionName"
			SectionName.Parent = SectionHead
			SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.BackgroundTransparency = 1
			SectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
			SectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
			SectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
			SectionName.Font = Enum.Font.Gotham
			SectionName.Text = secName
			SectionName.RichText = true
			SectionName.TextColor3 = themeList.TextColor
			Objects[SectionName] = "TextColor3"
			SectionName.TextSize = 14
			SectionName.TextXAlignment = Enum.TextXAlignment.Left
			if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
				Utility:TweenObject(SectionName, {
					TextColor3 = Color3.fromRGB(0, 0, 0),
				}, 0.2)
			end
			if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
				Utility:TweenObject(SectionName, {
					TextColor3 = Color3.fromRGB(255, 255, 255),
				}, 0.2)
			end
			SectionInners.Name = "SectionInners"
			SectionInners.Parent = SectionFrame
			SectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionInners.BackgroundTransparency = 1
			SectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)
			SectionElListing.Name = "SectionElListing"
			SectionElListing.Parent = SectionInners
			SectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
			SectionElListing.Padding = UDim.new(0, 3)
			coroutine.wrap(function()
				while wait() do
					SectionFrame.BackgroundColor3 = themeList.Background
					SectionHead.BackgroundColor3 = themeList.SchemeColor
					TabButton.TextColor3 = themeList.TextColor
					TabButton.BackgroundColor3 = themeList.SchemeColor
					SectionName.TextColor3 = themeList.TextColor
				end
			end)()
			local function UpdateSectionFrame()
				local InnerContentSize = SectionElListing.AbsoluteContentSize
				SectionInners.Size = UDim2.new(1, 0, 0, InnerContentSize.Y)
				local FrameContentSize = SectionListLayout.AbsoluteContentSize
				SectionFrame.Size = UDim2.new(0, 352, 0, FrameContentSize.Y)
			end
			UpdateSectionFrame()
			UpdateSize()
			local Elements = {}
			function Elements:NewButton(bname, tipINf, callback)
				showLogo = showLogo or true
				local ButtonFunction = {}
				tipINf = tipINf or "Tip: Clicking this nothing will happen!"
				bname = bname or "Click Me!"
				callback = callback or function()
				end
				local ButtonElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ButtonInfo = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local Touch = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")
				table.insert(Modules, bname)
				ButtonElement.Name = bname
				ButtonElement.Parent = SectionInners
				ButtonElement.BackgroundColor3 = themeList.ElementColor
				ButtonElement.ClipsDescendants = true
				ButtonElement.Size = UDim2.new(0, 352, 0, 33)
				ButtonElement.AutoButtonColor = false
				ButtonElement.Font = Enum.Font.SourceSans
				ButtonElement.Text = ''
				ButtonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				ButtonElement.TextSize = 14
				Objects[ButtonElement] = "BackgroundColor3"
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = ButtonElement
				ViewInfo.Name = "ViewInfo"
				ViewInfo.Parent = ButtonElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = themeList.SchemeColor
				Objects[ViewInfo] = "ImageColor3"
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				Sample.Name = "Sample"
				Sample.Parent = ButtonElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Objects[Sample] = "ImageColor3"
				Sample.ImageTransparency = 0.6
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. tipINf
				MoreInfo.RichText = true
				MoreInfo.TextColor3 = themeList.TextColor
				Objects[MoreInfo] = "TextColor3"
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				Objects[MoreInfo] = "BackgroundColor3"
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				Touch.Name = "Touch"
				Touch.Parent = ButtonElement
				Touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Touch.BackgroundTransparency = 1
				Touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				Touch.Size = UDim2.new(0, 21, 0, 21)
				Touch.Image = "rbxassetid://3926305904"
				Touch.ImageColor3 = themeList.SchemeColor
				Objects[Touch] = "SchemeColor"
				Touch.ImageRectOffset = Vector2.new(84, 204)
				Touch.ImageRectSize = Vector2.new(36, 36)
				Touch.ImageTransparency = 0
				ButtonInfo.Name = "ButtonInfo"
				ButtonInfo.Parent = ButtonElement
				ButtonInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonInfo.BackgroundTransparency = 1
				ButtonInfo.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				ButtonInfo.Size = UDim2.new(0, 314, 0, 14)
				ButtonInfo.Font = Enum.Font.GothamSemibold
				ButtonInfo.Text = bname
				ButtonInfo.RichText = true
				ButtonInfo.TextColor3 = themeList.TextColor
				Objects[ButtonInfo] = "TextColor3"
				ButtonInfo.TextSize = 14
				ButtonInfo.TextXAlignment = Enum.TextXAlignment.Left
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UpdateSectionFrame()
				UpdateSize()
				local Button = ButtonElement
				Button.MouseButton1Click:Connect(function()
					if not Focusing then
						callback()
						local c = Sample:Clone()
						c.Parent = Button
						local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
						c.Position = UDim2.new(0, x, 0, y)
						local Duration, Size = 0.35, nil
						if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
							Size = (Button.AbsoluteSize.X * 1.5)
						else
							Size = (Button.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(Duration / 12)
						end
						c:Destroy()
					else
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				local Hovering = false
				Button.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				ViewInfo.MouseButton1Click:Connect(function()
					if not ViewDetails then
						ViewDetails = true
						Focusing = true
						for i, v in next, InfoContainer:GetChildren() do
							if v ~= MoreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(Button, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						Focusing = false
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						ViewDetails = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							ButtonElement.BackgroundColor3 = themeList.ElementColor
						end
						ViewInfo.ImageColor3 = themeList.SchemeColor
						Sample.ImageColor3 = themeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = themeList.TextColor
						Touch.ImageColor3 = themeList.SchemeColor
						ButtonInfo.TextColor3 = themeList.TextColor
					end
				end)()
				function ButtonFunction:UpdateButton(newTitle)
					ButtonInfo.Text = newTitle
				end
				return ButtonFunction
			end
			function Elements:NewTextBox(tname, tTip, callback)
				tname = tname or "Textbox"
				tTip = tTip or "Gets a value of Textbox"
				callback = callback or function()
				end
				local TextBoxElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ViewInfo = Instance.new("ImageButton")
				local WriteIcon = Instance.new("ImageLabel")
				local TextBox = Instance.new("TextBox")
				local UICorner_2 = Instance.new("UICorner")
				local ToggleName = Instance.new("TextLabel")
				TextBoxElement.Name = "TextBoxElement"
				TextBoxElement.Parent = SectionInners
				TextBoxElement.BackgroundColor3 = themeList.ElementColor
				TextBoxElement.ClipsDescendants = true
				TextBoxElement.Size = UDim2.new(0, 352, 0, 33)
				TextBoxElement.AutoButtonColor = false
				TextBoxElement.Font = Enum.Font.SourceSans
				TextBoxElement.Text = ''
				TextBoxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextBoxElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = TextBoxElement
				ViewInfo.Name = "ViewInfo"
				ViewInfo.Parent = TextBoxElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = themeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				WriteIcon.Name = "WriteIcon"
				WriteIcon.Parent = TextBoxElement
				WriteIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				WriteIcon.BackgroundTransparency = 1
				WriteIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				WriteIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				WriteIcon.Size = UDim2.new(0, 21, 0, 21)
				WriteIcon.Image = "rbxassetid://3926305904"
				WriteIcon.ImageColor3 = themeList.SchemeColor
				WriteIcon.ImageRectOffset = Vector2.new(324, 604)
				WriteIcon.ImageRectSize = Vector2.new(36, 36)
				TextBox.Parent = TextBoxElement
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
				ToggleName.Name = "ToggleName"
				ToggleName.Parent = TextBoxElement
				ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleName.BackgroundTransparency = 1
				ToggleName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				ToggleName.Size = UDim2.new(0, 138, 0, 14)
				ToggleName.Font = Enum.Font.GothamSemibold
				ToggleName.Text = tname
				ToggleName.RichText = true
				ToggleName.TextColor3 = themeList.TextColor
				ToggleName.TextSize = 14
				ToggleName.TextXAlignment = Enum.TextXAlignment.Left
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.RichText = true
				MoreInfo.Text = "  " .. tTip
				MoreInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				UpdateSectionFrame()
				UpdateSize()
				local Button = TextBoxElement
				local InfoButton = ViewInfo
				Button.MouseButton1Click:Connect(function()
					if Focusing then
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				local Hovering = false
				Button.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				TextBox.FocusLost:Connect(function(EnterPressed)
					if Focusing then
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
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
				ViewInfo.MouseButton1Click:Connect(function()
					if not ViewDetails then
						ViewDetails = true
						Focusing = true
						for i, v in next, InfoContainer:GetChildren() do
							if v ~= MoreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(Button, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						Focusing = false
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						ViewDetails = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							TextBoxElement.BackgroundColor3 = themeList.ElementColor
						end
						TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
						ViewInfo.ImageColor3 = themeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = themeList.TextColor
						WriteIcon.ImageColor3 = themeList.SchemeColor
						ToggleName.TextColor3 = themeList.TextColor
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
				local Toggled = false
				table.insert(SettingsT, tname)
				local ToggleElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ToggleDisabled = Instance.new("ImageLabel")
				local ToggleEnabled = Instance.new("ImageLabel")
				local ToggleName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local Sample = Instance.new("ImageLabel")
				ToggleElement.Name = "ToggleElement"
				ToggleElement.Parent = SectionInners
				ToggleElement.BackgroundColor3 = themeList.ElementColor
				ToggleElement.ClipsDescendants = true
				ToggleElement.Size = UDim2.new(0, 352, 0, 33)
				ToggleElement.AutoButtonColor = false
				ToggleElement.Font = Enum.Font.SourceSans
				ToggleElement.Text = ''
				ToggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = ToggleElement
				ToggleDisabled.Name = "ToggleDisabled"
				ToggleDisabled.Parent = ToggleElement
				ToggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleDisabled.BackgroundTransparency = 1
				ToggleDisabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				ToggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleDisabled.Image = "rbxassetid://3926309567"
				ToggleDisabled.ImageColor3 = themeList.SchemeColor
				ToggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				ToggleDisabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.Name = "ToggleEnabled"
				ToggleEnabled.Parent = ToggleElement
				ToggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleEnabled.BackgroundTransparency = 1
				ToggleEnabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				ToggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleEnabled.Image = "rbxassetid://3926309567"
				ToggleEnabled.ImageColor3 = themeList.SchemeColor
				ToggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				ToggleEnabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.ImageTransparency = 1
				ToggleName.Name = "ToggleName"
				ToggleName.Parent = ToggleElement
				ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleName.BackgroundTransparency = 1
				ToggleName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				ToggleName.Size = UDim2.new(0, 288, 0, 14)
				ToggleName.Font = Enum.Font.GothamSemibold
				ToggleName.Text = tname
				ToggleName.RichText = true
				ToggleName.TextColor3 = themeList.TextColor
				ToggleName.TextSize = 14
				ToggleName.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "ViewInfo"
				ViewInfo.Parent = ToggleElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = themeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				Sample.Name = "Sample"
				Sample.Parent = ToggleElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.6
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.RichText = true
				MoreInfo.Text = "  " .. nTip
				MoreInfo.TextColor3 = themeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				local Button = ToggleElement
				local InfoButton = ViewInfo
				UpdateSectionFrame()
				UpdateSize()
				Button.MouseButton1Click:Connect(function()
					if not Focusing then
						if Toggled == false then
							TweenService:Create(ToggleEnabled, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								ImageTransparency = 0
							}):Play()
							local c = Sample:Clone()
							c.Parent = Button
							local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local Duration, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(Duration / 12)
							end
							c:Destroy()
						else
							TweenService:Create(ToggleEnabled, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								ImageTransparency = 1
							}):Play()
							local c = Sample:Clone()
							c.Parent = Button
							local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local Duration, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(Duration / 12)
							end
							c:Destroy()
						end
						Toggled = not Toggled
						pcall(callback, Toggled)
					else
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				local Hovering = false
				Button.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							ToggleElement.BackgroundColor3 = themeList.ElementColor
						end
						ToggleDisabled.ImageColor3 = themeList.SchemeColor
						ToggleEnabled.ImageColor3 = themeList.SchemeColor
						ToggleName.TextColor3 = themeList.TextColor
						ViewInfo.ImageColor3 = themeList.SchemeColor
						Sample.ImageColor3 = themeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = themeList.TextColor
					end
				end)()
				ViewInfo.MouseButton1Click:Connect(function()
					if not ViewDetails then
						ViewDetails = true
						Focusing = true
						for i, v in next, InfoContainer:GetChildren() do
							if v ~= MoreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(Button, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						Focusing = false
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						ViewDetails = false
					end
				end)
				function TogFunction:UpdateToggle(newText, isTogOn)
					isTogOn = isTogOn or toggle
					if newText ~= nil then
						ToggleName.Text = newText
					end
					if isTogOn then
						Toggled = true
						TweenService:Create(ToggleEnabled, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							ImageTransparency = 0
						}):Play()
						pcall(callback, Toggled)
					else
						Toggled = false
						TweenService:Create(ToggleEnabled, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							ImageTransparency = 1
						}):Play()
						pcall(callback, Toggled)
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
				local SliderElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ToggleName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local SliderButton = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local SliderDrag = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local WriteIcon = Instance.new("ImageLabel")
				local ValueLabel = Instance.new("TextLabel")
				SliderElement.Name = "SliderElement"
				SliderElement.Parent = SectionInners
				SliderElement.BackgroundColor3 = themeList.ElementColor
				SliderElement.ClipsDescendants = true
				SliderElement.Size = UDim2.new(0, 352, 0, 33)
				SliderElement.AutoButtonColor = false
				SliderElement.Font = Enum.Font.SourceSans
				SliderElement.Text = ''
				SliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				SliderElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = SliderElement
				ToggleName.Name = "ToggleName"
				ToggleName.Parent = SliderElement
				ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleName.BackgroundTransparency = 1
				ToggleName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				ToggleName.Size = UDim2.new(0, 138, 0, 14)
				ToggleName.Font = Enum.Font.GothamSemibold
				ToggleName.Text = slidInf
				ToggleName.RichText = true
				ToggleName.TextColor3 = themeList.TextColor
				ToggleName.TextSize = 14
				ToggleName.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "ViewInfo"
				ViewInfo.Parent = SliderElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = themeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				SliderButton.Name = "SliderButton"
				SliderButton.Parent = SliderElement
				SliderButton.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255 + 5)
				SliderButton.BorderSizePixel = 0
				SliderButton.Position = UDim2.new(0.488749951, 0, 0.393939406, 0)
				SliderButton.Size = UDim2.new(0, 149, 0, 6)
				SliderButton.AutoButtonColor = false
				SliderButton.Font = Enum.Font.SourceSans
				SliderButton.Text = ''
				SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				SliderButton.TextSize = 14
				UICorner_2.Parent = SliderButton
				UIListLayout.Parent = SliderButton
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				SliderDrag.Name = "SliderDrag"
				SliderDrag.Parent = SliderButton
				SliderDrag.BackgroundColor3 = themeList.SchemeColor
				SliderDrag.BorderColor3 = Color3.fromRGB(74, 99, 135)
				SliderDrag.BorderSizePixel = 0
				SliderDrag.Size = UDim2.new(-0.671140969, 100, 1, 0)
				UICorner_3.Parent = SliderDrag
				WriteIcon.Name = "WriteIcon"
				WriteIcon.Parent = SliderElement
				WriteIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				WriteIcon.BackgroundTransparency = 1
				WriteIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				WriteIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				WriteIcon.Size = UDim2.new(0, 21, 0, 21)
				WriteIcon.Image = "rbxassetid://3926307971"
				WriteIcon.ImageColor3 = themeList.SchemeColor
				WriteIcon.ImageRectOffset = Vector2.new(404, 164)
				WriteIcon.ImageRectSize = Vector2.new(36, 36)
				ValueLabel.Name = "ValueLabel"
				ValueLabel.Parent = SliderElement
				ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ValueLabel.BackgroundTransparency = 1
				ValueLabel.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
				ValueLabel.Size = UDim2.new(0, 41, 0, 14)
				ValueLabel.Font = Enum.Font.GothamSemibold
				ValueLabel.Text = minvalue
				ValueLabel.TextColor3 = themeList.TextColor
				ValueLabel.TextSize = 14
				ValueLabel.TextTransparency = 1
				ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. slidTip
				MoreInfo.TextColor3 = themeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.RichText = true
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UpdateSectionFrame()
				UpdateSize()
				local Button = SliderElement
				local InfoButton = ViewInfo
				local Hovering = false
				Button.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							SliderElement.BackgroundColor3 = themeList.ElementColor
						end
						MoreInfo.TextColor3 = themeList.TextColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						ValueLabel.TextColor3 = themeList.TextColor
						WriteIcon.ImageColor3 = themeList.SchemeColor
						ToggleName.TextColor3 = themeList.TextColor
						ViewInfo.ImageColor3 = themeList.SchemeColor
						SliderButton.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255 + 5)
						SliderDrag.BackgroundColor3 = themeList.SchemeColor
					end
				end)()
				local Value
				SliderButton.MouseButton1Down:Connect(function()
					if not Focusing then
						TweenService:Create(ValueLabel, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							TextTransparency = 0
						}):Play()
						Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * SliderDrag.AbsoluteSize.X) + tonumber(minvalue)) or 0
						pcall(function()
							callback(Value)
						end)
						SliderDrag:TweenSize(UDim2.new(0, math.clamp(Mouse.X - SliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						moveconnection = Mouse.Move:Connect(function()
							ValueLabel.Text = Value
							Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * SliderDrag.AbsoluteSize.X) + tonumber(minvalue))
							pcall(function()
								callback(Value)
							end)
							SliderDrag:TweenSize(UDim2.new(0, math.clamp(Mouse.X - SliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						end)
						releaseconnection = UserInputService.InputEnded:Connect(function(Mouse)
							if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch then
								Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * SliderDrag.AbsoluteSize.X) + tonumber(minvalue))
								pcall(function()
									callback(Value)
								end)
								ValueLabel.Text = Value
								TweenService:Create(ValueLabel, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									TextTransparency = 1
								}):Play()
								SliderDrag:TweenSize(UDim2.new(0, math.clamp(Mouse.X - SliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
								moveconnection:Disconnect()
								releaseconnection:Disconnect()
							end
						end)
					else
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				ViewInfo.MouseButton1Click:Connect(function()
					if not ViewDetails then
						ViewDetails = true
						Focusing = true
						for i, v in next, InfoContainer:GetChildren() do
							if v ~= MoreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(Button, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						Focusing = false
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						ViewDetails = false
					end
				end)
			end
			function Elements:NewDropdown(dropname, dropinf, list, callback)
				local DropFunction = {}
				dropname = dropname or "Dropdown"
				list = list or {}
				dropinf = dropinf or "Dropdown info"
				callback = callback or function()
				end
				local Opened = false
				local DropYSize = 33
				local DropFrame = Instance.new("Frame")
				local DropOpen = Instance.new("TextButton")
				local ListImage = Instance.new("ImageLabel")
				local ItemTextBox = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local UICorner = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local Sample = Instance.new("ImageLabel")
				Sample.Name = "Sample"
				Sample.Parent = DropOpen
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.6
				DropFrame.Name = "DropFrame"
				DropFrame.Parent = SectionInners
				DropFrame.BackgroundColor3 = themeList.Background
				DropFrame.BorderSizePixel = 0
				DropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
				DropFrame.Size = UDim2.new(0, 352, 0, 33)
				DropFrame.ClipsDescendants = true
				local Button = DropOpen
				DropOpen.Name = "DropOpen"
				DropOpen.Parent = DropFrame
				DropOpen.BackgroundColor3 = themeList.ElementColor
				DropOpen.Size = UDim2.new(0, 352, 0, 33)
				DropOpen.AutoButtonColor = false
				DropOpen.Font = Enum.Font.SourceSans
				DropOpen.Text = ''
				DropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
				DropOpen.TextSize = 14
				DropOpen.ClipsDescendants = true
				DropOpen.MouseButton1Click:Connect(function()
					if not Focusing then
						if Opened then
							Opened = false
							DropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local c = Sample:Clone()
							c.Parent = Button
							local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local Duration, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(Duration / 12)
							end
							c:Destroy()
						else
							Opened = true
							DropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local c = Sample:Clone()
							c.Parent = Button
							local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local Duration, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(Duration / 12)
							end
							c:Destroy()
						end
					else
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				ListImage.Name = "ListImage"
				ListImage.Parent = DropOpen
				ListImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListImage.BackgroundTransparency = 1
				ListImage.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ListImage.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				ListImage.Size = UDim2.new(0, 21, 0, 21)
				ListImage.Image = "rbxassetid://3926305904"
				ListImage.ImageColor3 = themeList.SchemeColor
				ListImage.ImageRectOffset = Vector2.new(644, 364)
				ListImage.ImageRectSize = Vector2.new(36, 36)
				ItemTextBox.Name = "ItemTextBox"
				ItemTextBox.Parent = DropOpen
				ItemTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ItemTextBox.BackgroundTransparency = 1
				ItemTextBox.Position = UDim2.new(0.0970000029, 0, 0.273000002, 0)
				ItemTextBox.Size = UDim2.new(0, 138, 0, 14)
				ItemTextBox.Font = Enum.Font.GothamSemibold
				ItemTextBox.Text = dropname
				ItemTextBox.RichText = true
				ItemTextBox.TextColor3 = themeList.TextColor
				ItemTextBox.TextSize = 14
				ItemTextBox.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "ViewInfo"
				ViewInfo.Parent = DropOpen
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = themeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = DropOpen
				local Sample = Instance.new("ImageLabel")
				Sample.Name = "Sample"
				Sample.Parent = DropOpen
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.6
				UIListLayout.Parent = DropFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)
				UpdateSectionFrame()
				UpdateSize()
				local InfoButton = ViewInfo
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.RichText = true
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. dropinf
				MoreInfo.TextColor3 = themeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				local Hovering = false
				Button.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							DropOpen.BackgroundColor3 = themeList.ElementColor
						end
						Sample.ImageColor3 = themeList.SchemeColor
						DropFrame.BackgroundColor3 = themeList.Background
						ListImage.ImageColor3 = themeList.SchemeColor
						ItemTextBox.TextColor3 = themeList.TextColor
						ViewInfo.ImageColor3 = themeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = themeList.TextColor
					end
				end)()
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				ViewInfo.MouseButton1Click:Connect(function()
					if not ViewDetails then
						ViewDetails = true
						Focusing = true
						for i, v in next, InfoContainer:GetChildren() do
							if v ~= MoreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(Button, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						Focusing = false
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						ViewDetails = false
					end
				end)
				for i, v in next, list do
					local OptionSelect = Instance.new("TextButton")
					local UICorner_2 = Instance.new("UICorner")
					local Sample1 = Instance.new("ImageLabel")
					Sample1.Name = "Sample1"
					Sample1.Parent = OptionSelect
					Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Sample1.BackgroundTransparency = 1
					Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
					Sample1.ImageColor3 = themeList.SchemeColor
					Sample1.ImageTransparency = 0.6
					DropYSize = DropYSize + 33
					OptionSelect.Name = "OptionSelect"
					OptionSelect.Parent = DropFrame
					OptionSelect.BackgroundColor3 = themeList.ElementColor
					OptionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
					OptionSelect.Size = UDim2.new(0, 352, 0, 33)
					OptionSelect.AutoButtonColor = false
					OptionSelect.Font = Enum.Font.GothamSemibold
					OptionSelect.Text = "  " .. v
					OptionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
					OptionSelect.TextSize = 14
					OptionSelect.TextXAlignment = Enum.TextXAlignment.Left
					OptionSelect.ClipsDescendants = true
					OptionSelect.MouseButton1Click:Connect(function()
						if not Focusing then
							Opened = false
							callback(v)
							ItemTextBox.Text = v
							DropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local c = Sample1:Clone()
							c.Parent = OptionSelect
							local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local Duration, Size = 0.35, nil
							if OptionSelect.AbsoluteSize.X >= OptionSelect.AbsoluteSize.Y then
								Size = (OptionSelect.AbsoluteSize.X * 1.5)
							else
								Size = (OptionSelect.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(Duration / 12)
							end
							c:Destroy()
						else
							for i, v in next, InfoContainer:GetChildren() do
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
								Focusing = false
							end
							Utility:TweenObject(BlurFrame, {
								BackgroundTransparency = 1
							}, 0.2)
						end
					end)
					UICorner_2.CornerRadius = UDim.new(0, 4)
					UICorner_2.Parent = OptionSelect
					local OriginalHover = false
					OptionSelect.MouseEnter:Connect(function()
						if not Focusing then
							TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
							}):Play()
							OriginalHover = true
						end
					end)
					OptionSelect.MouseLeave:Connect(function()
						if not Focusing then
							TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								BackgroundColor3 = themeList.ElementColor,
							}):Play()
							OriginalHover = false
						end
					end)
					coroutine.wrap(function()
						while wait() do
							if not OriginalHover then
								OptionSelect.BackgroundColor3 = themeList.ElementColor
							end
							OptionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
							Sample1.ImageColor3 = themeList.SchemeColor
						end
					end)()
				end
				function DropFunction:Refresh(newList)
					newList = newList or {}
					for i, v in next, DropFrame:GetChildren() do
						if v.Name == "OptionSelect" then
							v:Destroy()
						end
					end
					for i, v in next, newList do
						local OptionSelect = Instance.new("TextButton")
						local UICorner_2 = Instance.new("UICorner")
						local Sample11 = Instance.new("ImageLabel")
						Sample11.Name = "Sample11"
						Sample11.Parent = OptionSelect
						Sample11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Sample11.BackgroundTransparency = 1
						Sample11.Image = "http://www.roblox.com/asset/?id=4560909609"
						Sample11.ImageColor3 = themeList.SchemeColor
						Sample11.ImageTransparency = 0.6
						DropYSize = DropYSize + 33
						OptionSelect.Name = "OptionSelect"
						OptionSelect.Parent = DropFrame
						OptionSelect.BackgroundColor3 = themeList.ElementColor
						OptionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
						OptionSelect.Size = UDim2.new(0, 352, 0, 33)
						OptionSelect.AutoButtonColor = false
						OptionSelect.Font = Enum.Font.GothamSemibold
						OptionSelect.Text = "  " .. v
						OptionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
						OptionSelect.TextSize = 14
						OptionSelect.TextXAlignment = Enum.TextXAlignment.Left
						OptionSelect.ClipsDescendants = true
						UICorner_2.CornerRadius = UDim.new(0, 4)
						UICorner_2.Parent = OptionSelect
						OptionSelect.MouseButton1Click:Connect(function()
							if not Focusing then
								Opened = false
								callback(v)
								ItemTextBox.Text = v
								DropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
								wait(0.1)
								UpdateSectionFrame()
								UpdateSize()
								local c = Sample11:Clone()
								c.Parent = OptionSelect
								local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
								c.Position = UDim2.new(0, x, 0, y)
								local Duration, Size = 0.35, nil
								if OptionSelect.AbsoluteSize.X >= OptionSelect.AbsoluteSize.Y then
									Size = (OptionSelect.AbsoluteSize.X * 1.5)
								else
									Size = (OptionSelect.AbsoluteSize.Y * 1.5)
								end
								c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
								for i = 1, 10 do
									c.ImageTransparency = c.ImageTransparency + 0.05
									wait(Duration / 12)
								end
								c:Destroy()
							else
								for i, v in next, InfoContainer:GetChildren() do
									Utility:TweenObject(v, {
										Position = UDim2.new(0, 0, 2, 0),
									}, 0.2)
									Focusing = false
								end
								Utility:TweenObject(BlurFrame, {
									BackgroundTransparency = 1
								}, 0.2)
							end
						end)
						UpdateSectionFrame()
						UpdateSize()
						local Hover = false
						OptionSelect.MouseEnter:Connect(function()
							if not Focusing then
								TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
								}):Play()
								Hover = true
							end
						end)
						OptionSelect.MouseLeave:Connect(function()
							if not Focusing then
								TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = themeList.ElementColor,
								}):Play()
								Hover = false
							end
						end)
						coroutine.wrap(function()
							while wait() do
								if not OriginalHover then
									OptionSelect.BackgroundColor3 = themeList.ElementColor
								end
								OptionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
								Sample11.ImageColor3 = themeList.SchemeColor
							end
						end)()
					end
					if Opened then
						DropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
						wait(0.1)
						UpdateSectionFrame()
						UpdateSize()
					else
						DropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
						wait(0.1)
						UpdateSectionFrame()
						UpdateSize()
					end
				end
				return DropFunction
			end
			function Elements:NewKeybind(keytext, keyinf, First, callback)
				keytext = keytext or "KeybindText"
				keyinf = keyinf or "KebindInfo"
				callback = callback or function()
				end
				local OldKey = First.Name
				local KeybindElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ToggleName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local Touch = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")
				local ToggleName2 = Instance.new("TextLabel")
				local InfoButton = ViewInfo
				local MoreInfo = Instance.new("TextLabel")
				local UICorner1 = Instance.new("UICorner")
				KeybindElement.Name = "KeybindElement"
				KeybindElement.Parent = SectionInners
				KeybindElement.BackgroundColor3 = themeList.ElementColor
				KeybindElement.ClipsDescendants = true
				KeybindElement.Size = UDim2.new(0, 352, 0, 33)
				KeybindElement.AutoButtonColor = false
				KeybindElement.Font = Enum.Font.SourceSans
				KeybindElement.Text = ''
				KeybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				KeybindElement.TextSize = 14
				KeybindElement.MouseButton1Click:connect(function(e)
					if not Focusing then
						ToggleName2.Text = ". . ."
						local a, b = UserInputService.InputBegan:wait()
						if a.KeyCode.Name ~= "Unknown" then
							ToggleName2.Text = a.KeyCode.Name
							OldKey = a.KeyCode.Name
						end
						local c = Sample:Clone()
						c.Parent = KeybindElement
						local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
						c.Position = UDim2.new(0, x, 0, y)
						local Duration, Size = 0.35, nil
						if KeybindElement.AbsoluteSize.X >= KeybindElement.AbsoluteSize.Y then
							Size = (KeybindElement.AbsoluteSize.X * 1.5)
						else
							Size = (KeybindElement.AbsoluteSize.Y * 1.5)
						end
						c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
						for i = 1, 10 do
							c.ImageTransparency = c.ImageTransparency + 0.05
							wait(Duration / 12)
						end
					else
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				UserInputService.InputBegan:connect(function(InputObject, GameProcessedEvent)
					if not GameProcessedEvent then
						if InputObject.KeyCode.Name == OldKey then
							callback()
						end
					end
				end)
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.RichText = true
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. keyinf
				MoreInfo.TextColor3 = themeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				Sample.Name = "Sample"
				Sample.Parent = KeybindElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.6
				ToggleName.Name = "ToggleName"
				ToggleName.Parent = KeybindElement
				ToggleName.BackgroundColor3 = themeList.TextColor
				ToggleName.BackgroundTransparency = 1
				ToggleName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				ToggleName.Size = UDim2.new(0, 222, 0, 14)
				ToggleName.Font = Enum.Font.GothamSemibold
				ToggleName.Text = keytext
				ToggleName.RichText = true
				ToggleName.TextColor3 = themeList.TextColor
				ToggleName.TextSize = 14
				ToggleName.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "ViewInfo"
				ViewInfo.Parent = KeybindElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = themeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				ViewInfo.MouseButton1Click:Connect(function()
					if not ViewDetails then
						ViewDetails = true
						Focusing = true
						for i, v in next, InfoContainer:GetChildren() do
							if v ~= MoreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(KeybindElement, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						Focusing = false
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						ViewDetails = false
					end
				end)
				UpdateSectionFrame()
				UpdateSize()
				local OriginalHover = false
				KeybindElement.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(KeybindElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						OriginalHover = true
					end
				end)
				KeybindElement.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(KeybindElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						OriginalHover = false
					end
				end)
				UICorner1.CornerRadius = UDim.new(0, 4)
				UICorner1.Parent = MoreInfo
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = KeybindElement
				Touch.Name = "Touch"
				Touch.Parent = KeybindElement
				Touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Touch.BackgroundTransparency = 1
				Touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				Touch.Size = UDim2.new(0, 21, 0, 21)
				Touch.Image = "rbxassetid://3926305904"
				Touch.ImageColor3 = themeList.SchemeColor
				Touch.ImageRectOffset = Vector2.new(364, 284)
				Touch.ImageRectSize = Vector2.new(36, 36)
				ToggleName2.Name = "ToggleName"
				ToggleName2.Parent = KeybindElement
				ToggleName2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleName2.BackgroundTransparency = 1
				ToggleName2.Position = UDim2.new(0.727386296, 0, 0.272727281, 0)
				ToggleName2.Size = UDim2.new(0, 70, 0, 14)
				ToggleName2.Font = Enum.Font.GothamSemibold
				ToggleName2.Text = OldKey
				ToggleName2.TextColor3 = themeList.SchemeColor
				ToggleName2.TextSize = 14
				ToggleName2.TextXAlignment = Enum.TextXAlignment.Right
				coroutine.wrap(function()
					while wait() do
						if not OriginalHover then
							KeybindElement.BackgroundColor3 = themeList.ElementColor
						end
						ToggleName2.TextColor3 = themeList.SchemeColor
						Touch.ImageColor3 = themeList.SchemeColor
						ViewInfo.ImageColor3 = themeList.SchemeColor
						ToggleName.BackgroundColor3 = themeList.TextColor
						ToggleName.TextColor3 = themeList.TextColor
						Sample.ImageColor3 = themeList.SchemeColor
						MoreInfo.TextColor3 = themeList.TextColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
					end
				end)()
			end
			function Elements:NewColorPicker(colText, colInf, defcolor, callback)
				colText = colText or "ColorPicker"
				callback = callback or function()
				end
				defcolor = defcolor or Color3.fromRGB(1, 1, 1)
				local h, s, v = Color3.toHSV(defcolor)
				local ColorOpened = false
				local ColorElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ColorHeader = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Touch = Instance.new("ImageLabel")
				local ToggleName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local ColorCurrent = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local ColorInners = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local Rgb = Instance.new("ImageButton")
				local UICorner_5 = Instance.new("UICorner")
				local RgbCircle = Instance.new("ImageLabel")
				local Darkness = Instance.new("ImageButton")
				local UICorner_6 = Instance.new("UICorner")
				local DarkCircle = Instance.new("ImageLabel")
				local ToggleDisabled = Instance.new("ImageLabel")
				local ToggleEnabled = Instance.new("ImageLabel")
				local OnRainbow = Instance.new("TextButton")
				local ToggleName2 = Instance.new("TextLabel")
				local Sample = Instance.new("ImageLabel")
				Sample.Name = "Sample"
				Sample.Parent = ColorHeader
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Sample.ImageTransparency = 0.6
				local Button = ColorHeader
				ColorElement.Name = "ColorElement"
				ColorElement.Parent = SectionInners
				ColorElement.BackgroundColor3 = themeList.ElementColor
				ColorElement.BackgroundTransparency = 1
				ColorElement.ClipsDescendants = true
				ColorElement.Position = UDim2.new(0, 0, 0.566834569, 0)
				ColorElement.Size = UDim2.new(0, 352, 0, 33)
				ColorElement.AutoButtonColor = false
				ColorElement.Font = Enum.Font.SourceSans
				ColorElement.Text = ''
				ColorElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				ColorElement.TextSize = 14
				ColorElement.MouseButton1Click:Connect(function()
					if not Focusing then
						if ColorOpened then
							ColorOpened = false
							ColorElement:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local c = Sample:Clone()
							c.Parent = Button
							local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local Duration, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(Duration / 12)
							end
							c:Destroy()
						else
							ColorOpened = true
							ColorElement:TweenSize(UDim2.new(0, 352, 0, 141), "InOut", "Linear", 0.08, true)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local c = Sample:Clone()
							c.Parent = Button
							local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
							c.Position = UDim2.new(0, x, 0, y)
							local Duration, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Duration, true, nil)
							for i = 1, 10 do
								c.ImageTransparency = c.ImageTransparency + 0.05
								wait(Duration / 12)
							end
							c:Destroy()
						end
					else
						for i, v in next, InfoContainer:GetChildren() do
							Utility:TweenObject(v, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = ColorElement
				ColorHeader.Name = "ColorHeader"
				ColorHeader.Parent = ColorElement
				ColorHeader.BackgroundColor3 = themeList.ElementColor
				ColorHeader.Size = UDim2.new(0, 352, 0, 33)
				ColorHeader.ClipsDescendants = true
				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = ColorHeader
				Touch.Name = "Touch"
				Touch.Parent = ColorHeader
				Touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Touch.BackgroundTransparency = 1
				Touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				Touch.Size = UDim2.new(0, 21, 0, 21)
				Touch.Image = "rbxassetid://3926305904"
				Touch.ImageColor3 = themeList.SchemeColor
				Touch.ImageRectOffset = Vector2.new(44, 964)
				Touch.ImageRectSize = Vector2.new(36, 36)
				ToggleName.Name = "ToggleName"
				ToggleName.Parent = ColorHeader
				ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleName.BackgroundTransparency = 1
				ToggleName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				ToggleName.Size = UDim2.new(0, 288, 0, 14)
				ToggleName.Font = Enum.Font.GothamSemibold
				ToggleName.Text = colText
				ToggleName.TextColor3 = themeList.TextColor
				ToggleName.TextSize = 14
				ToggleName.RichText = true
				ToggleName.TextXAlignment = Enum.TextXAlignment.Left
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. colInf
				MoreInfo.TextColor3 = themeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.RichText = true
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				ViewInfo.Name = "ViewInfo"
				ViewInfo.Parent = ColorHeader
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = themeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				ViewInfo.MouseButton1Click:Connect(function()
					if not ViewDetails then
						ViewDetails = true
						Focusing = true
						for i, v in next, InfoContainer:GetChildren() do
							if v ~= MoreInfo then
								Utility:TweenObject(v, {
									Position = UDim2.new(0, 0, 2, 0),
								}, 0.2)
							end
						end
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 0, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 0.5
						}, 0.2)
						Utility:TweenObject(ColorElement, {
							BackgroundColor3 = themeList.ElementColor,
						}, 0.2)
						wait(1.5)
						Focusing = false
						Utility:TweenObject(MoreInfo, {
							Position = UDim2.new(0, 0, 2, 0),
						}, 0.2)
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
						wait(0)
						ViewDetails = false
					end
				end)
				ColorCurrent.Name = "ColorCurrent"
				ColorCurrent.Parent = ColorHeader
				ColorCurrent.BackgroundColor3 = defcolor
				ColorCurrent.Position = UDim2.new(0.792613626, 0, 0.212121218, 0)
				ColorCurrent.Size = UDim2.new(0, 42, 0, 18)
				UICorner_3.CornerRadius = UDim.new(0, 4)
				UICorner_3.Parent = ColorCurrent
				UIListLayout.Parent = ColorElement
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)
				ColorInners.Name = "ColorInners"
				ColorInners.Parent = ColorElement
				ColorInners.BackgroundColor3 = themeList.ElementColor
				ColorInners.Position = UDim2.new(0, 0, 0.255319148, 0)
				ColorInners.Size = UDim2.new(0, 352, 0, 105)
				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = ColorInners
				Rgb.Name = "Rgb"
				Rgb.Parent = ColorInners
				Rgb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Rgb.BackgroundTransparency = 1
				Rgb.Position = UDim2.new(0.0198863633, 0, 0.0476190485, 0)
				Rgb.Size = UDim2.new(0, 211, 0, 93)
				Rgb.Image = "http://www.roblox.com/asset/?id=6523286724"
				UICorner_5.CornerRadius = UDim.new(0, 4)
				UICorner_5.Parent = Rgb
				RgbCircle.Name = "RgbCircle"
				RgbCircle.Parent = Rgb
				RgbCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RgbCircle.BackgroundTransparency = 1
				RgbCircle.Size = UDim2.new(0, 14, 0, 14)
				RgbCircle.Image = "rbxassetid://3926309567"
				RgbCircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
				RgbCircle.ImageRectOffset = Vector2.new(628, 420)
				RgbCircle.ImageRectSize = Vector2.new(48, 48)
				Darkness.Name = "Darkness"
				Darkness.Parent = ColorInners
				Darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Darkness.BackgroundTransparency = 1
				Darkness.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
				Darkness.Size = UDim2.new(0, 18, 0, 93)
				Darkness.Image = "http://www.roblox.com/asset/?id=6523291212"
				UICorner_6.CornerRadius = UDim.new(0, 4)
				UICorner_6.Parent = Darkness
				DarkCircle.Name = "DarkCircle"
				DarkCircle.Parent = Darkness
				DarkCircle.AnchorPoint = Vector2.new(0.5, 0)
				DarkCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DarkCircle.BackgroundTransparency = 1
				DarkCircle.Size = UDim2.new(0, 14, 0, 14)
				DarkCircle.Image = "rbxassetid://3926309567"
				DarkCircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
				DarkCircle.ImageRectOffset = Vector2.new(628, 420)
				DarkCircle.ImageRectSize = Vector2.new(48, 48)
				ToggleDisabled.Name = "ToggleDisabled"
				ToggleDisabled.Parent = ColorInners
				ToggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleDisabled.BackgroundTransparency = 1
				ToggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
				ToggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleDisabled.Image = "rbxassetid://3926309567"
				ToggleDisabled.ImageColor3 = themeList.SchemeColor
				ToggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				ToggleDisabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.Name = "ToggleEnabled"
				ToggleEnabled.Parent = ColorInners
				ToggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleEnabled.BackgroundTransparency = 1
				ToggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
				ToggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleEnabled.Image = "rbxassetid://3926309567"
				ToggleEnabled.ImageColor3 = themeList.SchemeColor
				ToggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				ToggleEnabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.ImageTransparency = 1
				OnRainbow.Name = "OnRainbow"
				OnRainbow.Parent = ToggleEnabled
				OnRainbow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				OnRainbow.BackgroundTransparency = 1
				OnRainbow.Position = UDim2.new(2.90643607e-6, 0, 0, 0)
				OnRainbow.Size = UDim2.new(1, 0, 1, 0)
				OnRainbow.Font = Enum.Font.SourceSans
				OnRainbow.Text = ''
				OnRainbow.TextColor3 = Color3.fromRGB(0, 0, 0)
				OnRainbow.TextSize = 14
				ToggleName2.Name = "ToggleName"
				ToggleName2.Parent = ColorInners
				ToggleName2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleName2.BackgroundTransparency = 1
				ToggleName2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
				ToggleName2.Size = UDim2.new(0, 278, 0, 14)
				ToggleName2.Font = Enum.Font.GothamSemibold
				ToggleName2.Text = "Rainbow"
				ToggleName2.TextColor3 = themeList.TextColor
				ToggleName2.TextSize = 14
				ToggleName2.TextXAlignment = Enum.TextXAlignment.Left
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				local Hovering = false
				ColorElement.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(ColorElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				ColorElement.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(ColorElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = themeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							ColorElement.BackgroundColor3 = themeList.ElementColor
						end
						Touch.ImageColor3 = themeList.SchemeColor
						ColorHeader.BackgroundColor3 = themeList.ElementColor
						ToggleName.TextColor3 = themeList.TextColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = themeList.TextColor
						ViewInfo.ImageColor3 = themeList.SchemeColor
						ColorInners.BackgroundColor3 = themeList.ElementColor
						ToggleDisabled.ImageColor3 = themeList.SchemeColor
						ToggleEnabled.ImageColor3 = themeList.SchemeColor
						ToggleName2.TextColor3 = themeList.TextColor
						Sample.ImageColor3 = themeList.SchemeColor
					end
				end)()
				UpdateSectionFrame()
				UpdateSize()
				local ColorPicker = false
				local DarknessActive = false
				local Dark = Darkness
				local Cursor = RgbCircle
				local Cursor2 = DarkCircle
				local Color = {
					1,
					1,
					1
				}
				local Rainbow = false
				local RainbowConnection
				local Counter = 0
				local function Zigzag(X)
					return math.acos(math.cos(X * math.pi)) / math.pi
				end
				Counter = 0
				local function MouseLocation()
					return LocalPlayer:GetMouse()
				end
				local function UpdateColorPicker()
					if ColorPicker then
						local MousePosition = MouseLocation()
						local x, y = MousePosition.X - Rgb.AbsolutePosition.X, MousePosition.Y - Rgb.AbsolutePosition.Y
						local MaxX, MaxY = Rgb.AbsoluteSize.X, Rgb.AbsoluteSize.Y
						if x < 0 then
							x = 0
						end
						if x > MaxX then
							x = MaxX
						end
						if y < 0 then
							y = 0
						end
						if y > MaxY then
							y = MaxY
						end
						x = x / MaxX
						y = y / MaxY
						local CursorHalfX = Cursor.AbsoluteSize.X / 2
						local CursorHalfY = Cursor.AbsoluteSize.Y / 2
						Cursor.Position = UDim2.new(x, - CursorHalfX, y, - CursorHalfY)
						Color = {
							1 - x,
							1 - y,
							Color[3],
						}
						local RealColor = Color3.fromHSV(Color[1], Color[2], Color[3])
						ColorCurrent.BackgroundColor3 = RealColor
						callback(RealColor)
					end
					if DarknessActive then
						local MousePosition = MouseLocation()
						local y = MousePosition.Y - Dark.AbsolutePosition.Y
						local MaxY = Dark.AbsoluteSize.Y
						if y < 0 then
							y = 0
						end
						if y > MaxY then
							y = MaxY
						end
						y = y / MaxY
						local CursorHalfY = Cursor2.AbsoluteSize.Y / 2
						Cursor2.Position = UDim2.new(0.5, 0, y, - CursorHalfY)
						Cursor2.ImageColor3 = Color3.fromHSV(0, 0, y)
						Color = {
							Color[1],
							Color[2],
							1 - y,
						}
						local RealColor = Color3.fromHSV(Color[1], Color[2], Color[3])
						ColorCurrent.BackgroundColor3 = RealColor
						callback(RealColor)
					end
				end
				local function SetColor(tbl)
					local CursorHalfX = Cursor.AbsoluteSize.X / 2
					local CursorHalfY = Cursor.AbsoluteSize.Y / 2
					Color = {
						tbl[1],
						tbl[2],
						tbl[3],
					}
					Cursor.Position = UDim2.new(Color[1], - CursorHalfX, Color[2] - 1, - CursorHalfY)
					Cursor2.Position = UDim2.new(0.5, 0, Color[3] - 1, - CursorHalfY)
					local RealColor = Color3.fromHSV(Color[1], Color[2], Color[3])
					ColorCurrent.BackgroundColor3 = RealColor
				end
				local function SetRgbColor(tbl)
					local CursorHalfX = Cursor.AbsoluteSize.X / 2
					local CursorHalfY = Cursor.AbsoluteSize.Y / 2
					Color = {
						tbl[1],
						tbl[2],
						Color[3],
					}
					Cursor.Position = UDim2.new(Color[1], - CursorHalfX, Color[2] - 1, - CursorHalfY)
					local RealColor = Color3.fromHSV(Color[1], Color[2], Color[3])
					ColorCurrent.BackgroundColor3 = RealColor
					callback(RealColor)
				end
				local function ToggleRainbow()
					if Rainbow then
						TweenService:Create(ToggleEnabled, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							ImageTransparency = 1
						}):Play()
						Rainbow = false
						RainbowConnection:Disconnect()
					else
						TweenService:Create(ToggleEnabled, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							ImageTransparency = 0
						}):Play()
						Rainbow = true
						RainbowConnection = RunService.RenderStepped:Connect(function()
							SetRgbColor({
								Zigzag(Counter),
								1,
								1,
							})
							Counter = Counter + 0.01
						end)
					end
				end
				OnRainbow.MouseButton1Click:Connect(ToggleRainbow)
				Mouse.Move:connect(UpdateColorPicker)
				Rgb.MouseButton1Down:connect(function()
					ColorPicker = true
				end)
				Dark.MouseButton1Down:connect(function()
					DarknessActive = true
				end)
				UserInputService.InputEnded:Connect(function(Input)
					if Input.UserInputType.Name == "MouseButton1" then
						if DarknessActive then
							DarknessActive = false
						end
						if ColorPicker then
							ColorPicker = false
						end
					end
				end)
				SetColor({
					h,
					s,
					v
				})
			end
			function Elements:NewLabel(Title)
				local LabelFunctions = {}
				local Label = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				Label.Name = "Label"
				Label.Parent = SectionInners
				Label.BackgroundColor3 = themeList.SchemeColor
				Label.BorderSizePixel = 0
				Label.ClipsDescendants = true
				Label.Text = Title
				Label.Size = UDim2.new(0, 352, 0, 33)
				Label.Font = Enum.Font.Gotham
				Label.Text = "  " .. Title
				Label.RichText = true
				Label.TextColor3 = themeList.TextColor
				Objects[Label] = "TextColor3"
				Label.TextSize = 14
				Label.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Label
				if themeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(Label, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if themeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(Label, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				coroutine.wrap(function()
					while wait() do
						Label.BackgroundColor3 = themeList.SchemeColor
						Label.TextColor3 = themeList.TextColor
					end
				end)()
				UpdateSectionFrame()
				UpdateSize()
				function LabelFunctions:UpdateLabel(newText)
					if Label.Text ~= "  " .. newText then
						Label.Text = "  " .. newText
					end
				end
				return LabelFunctions
			end
			return Elements
		end
		return Sections
	end
	return Tabs
end
return Kavo
