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

function Kavo:DraggingEnabled(Frame, Parent)
	Parent = Parent or Frame
	local Dragging = false
	local DragInput, MousePos, FramePos
	Frame.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			MousePos = Input.Position
			FramePos = Parent.Position
			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	Frame.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			DragInput = Input
		end
	end)
	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - MousePos
			Parent.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
		end
	end)
end

function Utility:TweenObject(Object, Properties, Duration, ...)
	TweenService:Create(Object, TweenInfo(Duration, ...), Properties):Play()
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

function Kavo.CreateLib(KavName, ThemeList)
	if not ThemeList then
		ThemeList = Themes
	end
	if ThemeList == "DarkTheme" then
		ThemeList = ThemeStyles.DarkTheme
	elseif ThemeList == "LightTheme" then
		ThemeList = ThemeStyles.LightTheme
	elseif ThemeList == "BloodTheme" then
		ThemeList = ThemeStyles.BloodTheme
	elseif ThemeList == "GrapeTheme" then
		ThemeList = ThemeStyles.GrapeTheme
	elseif ThemeList == "Grey" then
		ThemeList = ThemeStyles.Grey
	elseif ThemeList == "Red" then
		ThemeList = ThemeStyles.Red
	elseif ThemeList == "Green" then
		ThemeList = ThemeStyles.Green
	elseif ThemeList == "Blue" then
		ThemeList = ThemeStyles.Blue
	elseif ThemeList == "Yellow" then
		ThemeList = ThemeStyles.Yellow
	elseif ThemeList == "Orange" then
		ThemeList = ThemeStyles.Orange
	elseif ThemeList == "Pink" then
		ThemeList = ThemeStyles.Pink
	elseif ThemeList == "Purple" then
		ThemeList = ThemeStyles.Purple
	elseif ThemeList == "Serpent" then
		ThemeList = ThemeStyles.Serpent
	else
		if ThemeList.SchemeColor == nil then
			ThemeList.SchemeColor = Color3.fromRGB(74, 99, 135)
		elseif ThemeList.Background == nil then
			ThemeList.Background = Color3.fromRGB(36, 37, 43)
		elseif ThemeList.Header == nil then
			ThemeList.Header = Color3.fromRGB(28, 29, 34)
		elseif ThemeList.TextColor == nil then
			ThemeList.TextColor = Color3.fromRGB(255, 255, 255)
		elseif ThemeList.ElementColor == nil then
			ThemeList.ElementColor = Color3.fromRGB(32, 32, 38)
		end
	end
	ThemeList = ThemeList or {}
	local SelectedTab
	KavName = KavName or "Library"
	table.insert(Kavo, KavName)
	for _, Child in pairs(CoreGui:GetChildren()) do
		if Child:IsA("ScreenGui") and Child.Name == KavName then
			Child:Destroy()
		end
	end
	local ScreenGui = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local MainHeader = Instance.new("Frame")
	local HeaderCover = Instance.new("UICorner")
	local HeaderCoverup = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Close = Instance.new("ImageButton")
	local MainSide = Instance.new("Frame")
	local SideCorner = Instance.new("UICorner")
	local SideCoverup = Instance.new("Frame")
	local TabFrames = Instance.new("Frame")
	local TabListing = Instance.new("UIListLayout")
	local PagesFrame = Instance.new("Frame")
	local Pages = Instance.new("Folder")
	local InfoContainer = Instance.new("Frame")
	local BlurFrame = Instance.new("Frame")
	Kavo:DraggingEnabled(MainHeader, Main)
	BlurFrame.Name = "blurFrame"
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
	Main.BackgroundColor3 = ThemeList.Background
	Main.ClipsDescendants = true
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Position = UDim2.new(0.5, 0, 0.45, 0)
	Main.Size = UDim2.new(0, 525, 0, 260)
	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = Main
	MainHeader.Name = "MainHeader"
	MainHeader.Parent = Main
	MainHeader.BackgroundColor3 = ThemeList.Header
	Objects[MainHeader] = "BackgroundColor3"
	MainHeader.Size = UDim2.new(0, 525, 0, 27)
	HeaderCover.CornerRadius = UDim.new(0, 4)
	HeaderCover.Name = "headerCover"
	HeaderCover.Parent = MainHeader
	HeaderCoverup.Name = "coverup"
	HeaderCoverup.Parent = MainHeader
	HeaderCoverup.BackgroundColor3 = ThemeList.Header
	Objects[HeaderCoverup] = "BackgroundColor3"
	HeaderCoverup.BorderSizePixel = 0
	HeaderCoverup.Position = UDim2.new(0, 0, 0.758620679, 0)
	HeaderCoverup.Size = UDim2.new(0, 525, 0, 7)
	Title.Name = "title"
	Title.Parent = MainHeader
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
	Title.Size = UDim2.new(0, 204, 0, 8)
	Title.Font = Enum.Font.Gotham
	Title.RichText = true
	Title.Text = KavName
	Title.TextColor3 = Color3.fromRGB(245, 245, 245)
	Title.TextSize = 16
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Close.Name = "close"
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
	MainSide.BackgroundColor3 = ThemeList.Header
	Objects[MainSide] = "Header"
	MainSide.Position = UDim2.new(0, 0, 0, 27)
	MainSide.Size = UDim2.new(0, 149, 1, -27)
	SideCorner.CornerRadius = UDim.new(0, 4)
	SideCorner.Name = "sideCorner"
	SideCorner.Parent = MainSide
	SideCoverup.Name = "coverup"
	SideCoverup.Parent = MainSide
	SideCoverup.BackgroundColor3 = ThemeList.Header
	Objects[SideCoverup] = "Header"
	SideCoverup.BorderSizePixel = 0
	SideCoverup.Position = UDim2.new(1, -7, 0, 0)
	SideCoverup.Size = UDim2.new(0, 7, 1, 0)
	TabFrames.Name = "tabFrames"
	TabFrames.Parent = MainSide
	TabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabFrames.BackgroundTransparency = 1
	TabFrames.Position = UDim2.new(0.0438990258, 0, -6.0006378375, 0)
	TabFrames.Size = UDim2.new(0, 135, 1, -5)
	TabListing.Name = "tabListing"
	TabListing.Parent = TabFrames
	TabListing.SortOrder = Enum.SortOrder.LayoutOrder
	PagesFrame.Name = "pages"
	PagesFrame.Parent = Main
	PagesFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PagesFrame.BackgroundTransparency = 1
	PagesFrame.BorderSizePixel = 0
	PagesFrame.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
	PagesFrame.Size = UDim2.new(0, 360, 0, 233)
	Pages.Name = "Pages"
	Pages.Parent = PagesFrame
	InfoContainer.Name = "infoContainer"
	InfoContainer.Parent = Main
	InfoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InfoContainer.BackgroundTransparency = 1
	InfoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
	InfoContainer.ClipsDescendants = true
	InfoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
	InfoContainer.Size = UDim2.new(0, 368, 0, 33)
	coroutine.wrap(function()
		while wait() do
			Main.BackgroundColor3 = ThemeList.Background
			MainHeader.BackgroundColor3 = ThemeList.Header
			MainSide.BackgroundColor3 = ThemeList.Header
			SideCoverup.BackgroundColor3 = ThemeList.Header
			HeaderCoverup.BackgroundColor3 = ThemeList.Header
		end
	end)()
	function Kavo:ChangeColor(PropertyName, Color)
		if PropertyName == "Background" then
			ThemeList.Background = Color
		elseif PropertyName == "SchemeColor" then
			ThemeList.SchemeColor = Color
		elseif PropertyName == "Header" then
			ThemeList.Header = Color
		elseif PropertyName == "TextColor" then
			ThemeList.TextColor = Color
		elseif PropertyName == "ElementColor" then
			ThemeList.ElementColor = Color
		end
	end
	local Tabs = {}
	local First = true
	function Tabs:NewTab(TabName)
		TabName = TabName or "Tab"
		local TabButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local Page = Instance.new("ScrollingFrame")
		local PageListing = Instance.new("UIListLayout")
		local function UpdateSize()
			local TabContentSize = PageListing.AbsoluteContentSize
			TweenService:Create(Page, TweenInfo(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				CanvasSize = UDim2.new(0, TabContentSize.X, 0, TabContentSize.Y),
			}):Play()
		end
		Page.Name = "Page"
		Page.Parent = Pages
		Page.Active = true
		Page.BackgroundColor3 = ThemeList.Background
		Page.BorderSizePixel = 0
		Page.Position = UDim2.new(0, 0, -3.00071747208, 0)
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.ScrollBarThickness = 5
		Page.Visible = false
		Page.ScrollBarImageColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 16, ThemeList.SchemeColor.g * 255 - 15, ThemeList.SchemeColor.b * 255 - 28)
		PageListing.Name = "pageListing"
		PageListing.Parent = Page
		PageListing.SortOrder = Enum.SortOrder.LayoutOrder
		PageListing.Padding = UDim.new(0, 5)
		TabButton.Name = TabName .. "TabButton"
		TabButton.Parent = TabFrames
		TabButton.BackgroundColor3 = ThemeList.SchemeColor
		Objects[TabButton] = "SchemeColor"
		TabButton.Size = UDim2.new(0, 135, 0, 28)
		TabButton.AutoButtonColor = false
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = TabName
		TabButton.TextColor3 = ThemeList.TextColor
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
		table.insert(Tabs, TabName)
		UpdateSize()
		Page.ChildAdded:Connect(UpdateSize)
		Page.ChildRemoved:Connect(UpdateSize)
		TabButton.MouseButton1Click:Connect(function()
			UpdateSize()
			for _, Child in next, Pages:GetChildren() do
				Child.Visible = false
			end
			Page.Visible = true
			for _, Child in next, TabFrames:GetChildren() do
				if Child:IsA("TextButton") then
					if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
						Utility:TweenObject(Child, {
							TextColor3 = Color3.fromRGB(255, 255, 255),
						}, 0.2)
					end
					if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
						Utility:TweenObject(Child, {
							TextColor3 = Color3.fromRGB(0, 0, 0),
						}, 0.2)
					end
					Utility:TweenObject(Child, {
						BackgroundTransparency = 1
					}, 0.2)
				end
			end
			if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
				Utility:TweenObject(TabButton, {
					TextColor3 = Color3.fromRGB(0, 0, 0),
				}, 0.2)
			end
			if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
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
		local InfoOpen = false
		coroutine.wrap(function()
			while wait() do
				Page.BackgroundColor3 = ThemeList.Background
				Page.ScrollBarImageColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 16, ThemeList.SchemeColor.g * 255 - 15, ThemeList.SchemeColor.b * 255 - 28)
				TabButton.TextColor3 = ThemeList.TextColor
				TabButton.BackgroundColor3 = ThemeList.SchemeColor
			end
		end)()
		function Sections:NewSection(SectionTitle, Hidden)
			SectionTitle = SectionTitle or "Section"
			local SectionFunctions = {}
			local Modules = {}
			Hidden = Hidden or false
			local SectionFrame = Instance.new("Frame")
			local Sectionlistoknvm = Instance.new("UIListLayout")
			local SectionHead = Instance.new("Frame")
			local SectionHeadCorner = Instance.new("UICorner")
			local SectionName = Instance.new("TextLabel")
			local SectionInners = Instance.new("Frame")
			local SectionElListing = Instance.new("UIListLayout")
			if Hidden then
				SectionHead.Visible = false
			else
				SectionHead.Visible = true
			end
			SectionFrame.Name = "sectionFrame"
			SectionFrame.Parent = Page
			SectionFrame.BackgroundColor3 = ThemeList.Background
			SectionFrame.BorderSizePixel = 0
			Sectionlistoknvm.Name = "sectionlistoknvm"
			Sectionlistoknvm.Parent = SectionFrame
			Sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
			Sectionlistoknvm.Padding = UDim.new(0, 5)
			for _, Child in pairs(SectionInners:GetChildren()) do
				while wait() do
					if Child:IsA("Frame") or Child:IsA("TextButton") then
						function OnPropertyChanged(ChangedProperty)
							if ChangedProperty == "Size" then
								UpdateSize()
								UpdateSectionFrame()
							end
						end
						Child.Changed:Connect(OnPropertyChanged)
					end
				end
			end
			SectionHead.Name = "sectionHead"
			SectionHead.Parent = SectionFrame
			SectionHead.BackgroundColor3 = ThemeList.SchemeColor
			Objects[SectionHead] = "BackgroundColor3"
			SectionHead.Size = UDim2.new(0, 352, 0, 33)
			SectionHeadCorner.CornerRadius = UDim.new(0, 4)
			SectionHeadCorner.Name = "sHeadCorner"
			SectionHeadCorner.Parent = SectionHead
			SectionName.Name = "sectionName"
			SectionName.Parent = SectionHead
			SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.BackgroundTransparency = 1
			SectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
			SectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
			SectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
			SectionName.Font = Enum.Font.Gotham
			SectionName.Text = SectionTitle
			SectionName.RichText = true
			SectionName.TextColor3 = ThemeList.TextColor
			Objects[SectionName] = "TextColor3"
			SectionName.TextSize = 14
			SectionName.TextXAlignment = Enum.TextXAlignment.Left
			if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
				Utility:TweenObject(SectionName, {
					TextColor3 = Color3.fromRGB(0, 0, 0),
				}, 0.2)
			end
			if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
				Utility:TweenObject(SectionName, {
					TextColor3 = Color3.fromRGB(255, 255, 255),
				}, 0.2)
			end
			SectionInners.Name = "sectionInners"
			SectionInners.Parent = SectionFrame
			SectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionInners.BackgroundTransparency = 1
			SectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)
			SectionElListing.Name = "sectionElListing"
			SectionElListing.Parent = SectionInners
			SectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
			SectionElListing.Padding = UDim.new(0, 3)
			coroutine.wrap(function()
				while wait() do
					SectionFrame.BackgroundColor3 = ThemeList.Background
					SectionHead.BackgroundColor3 = ThemeList.SchemeColor
					TabButton.TextColor3 = ThemeList.TextColor
					TabButton.BackgroundColor3 = ThemeList.SchemeColor
					SectionName.TextColor3 = ThemeList.TextColor
				end
			end)()
			local function UpdateSectionFrame()
				local SectionInnerContentSize = SectionElListing.AbsoluteContentSize
				SectionInners.Size = UDim2.new(1, 0, 0, SectionInnerContentSize.Y)
				local SectionFrameContentSize = Sectionlistoknvm.AbsoluteContentSize
				SectionFrame.Size = UDim2.new(0, 352, 0, SectionFrameContentSize.Y)
			end
			UpdateSectionFrame()
			UpdateSize()
			local Elements = {}
			function Elements:NewButton(ButtonTitle, TipInfo, Callback)
				showLogo = showLogo or true
				local ButtonFunction = {}
				TipInfo = TipInfo or "Tip: Clicking this nothing will happen!"
				ButtonTitle = ButtonTitle or "Click Me!"
				Callback = Callback or function()
				end
				local ButtonElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local BtnInfo = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local TouchIcon = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")
				table.insert(Modules, ButtonTitle)
				ButtonElement.Name = ButtonTitle
				ButtonElement.Parent = SectionInners
				ButtonElement.BackgroundColor3 = ThemeList.ElementColor
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
				ViewInfo.Name = "viewInfo"
				ViewInfo.Parent = ButtonElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = ThemeList.SchemeColor
				Objects[ViewInfo] = "ImageColor3"
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				Sample.Name = "Sample"
				Sample.Parent = ButtonElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = ThemeList.SchemeColor
				Objects[Sample] = "ImageColor3"
				Sample.ImageTransparency = 0.6
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. TipInfo
				MoreInfo.RichText = true
				MoreInfo.TextColor3 = ThemeList.TextColor
				Objects[MoreInfo] = "TextColor3"
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				Objects[MoreInfo] = "BackgroundColor3"
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				TouchIcon.Name = "touch"
				TouchIcon.Parent = ButtonElement
				TouchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TouchIcon.BackgroundTransparency = 1
				TouchIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				TouchIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				TouchIcon.Size = UDim2.new(0, 21, 0, 21)
				TouchIcon.Image = "rbxassetid://3926305904"
				TouchIcon.ImageColor3 = ThemeList.SchemeColor
				Objects[TouchIcon] = "SchemeColor"
				TouchIcon.ImageRectOffset = Vector2.new(84, 204)
				TouchIcon.ImageRectSize = Vector2.new(36, 36)
				TouchIcon.ImageTransparency = 0
				BtnInfo.Name = "btnInfo"
				BtnInfo.Parent = ButtonElement
				BtnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BtnInfo.BackgroundTransparency = 1
				BtnInfo.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				BtnInfo.Size = UDim2.new(0, 314, 0, 14)
				BtnInfo.Font = Enum.Font.GothamSemibold
				BtnInfo.Text = ButtonTitle
				BtnInfo.RichText = true
				BtnInfo.TextColor3 = ThemeList.TextColor
				Objects[BtnInfo] = "TextColor3"
				BtnInfo.TextSize = 14
				BtnInfo.TextXAlignment = Enum.TextXAlignment.Left
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UpdateSectionFrame()
				UpdateSize()
				local Button = ButtonElement
				local Sample = Sample
				Button.MouseButton1Click:Connect(function()
					if not Focusing then
						Callback()
						local Ripple = Sample:Clone()
						Ripple.Parent = Button
						local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
						Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
						local Len, Size = 0.35, nil
						if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
							Size = (Button.AbsoluteSize.X * 1.5)
						else
							Size = (Button.AbsoluteSize.Y * 1.5)
						end
						Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
						for Step = 1, 10 do
							Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
							wait(Len / 12)
						end
						Ripple:Destroy()
					else
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
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
							BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = ThemeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				ViewInfo.MouseButton1Click:Connect(function()
					if not InfoOpen then
						InfoOpen = true
						Focusing = true
						for _, Child in next, InfoContainer:GetChildren() do
							if Child ~= MoreInfo then
								Utility:TweenObject(Child, {
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
							BackgroundColor3 = ThemeList.ElementColor,
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
						InfoOpen = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							ButtonElement.BackgroundColor3 = ThemeList.ElementColor
						end
						ViewInfo.ImageColor3 = ThemeList.SchemeColor
						Sample.ImageColor3 = ThemeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = ThemeList.TextColor
						TouchIcon.ImageColor3 = ThemeList.SchemeColor
						BtnInfo.TextColor3 = ThemeList.TextColor
					end
				end)()
				function ButtonFunction:UpdateButton(NewTitle)
					BtnInfo.Text = NewTitle
				end
				return ButtonFunction
			end
			function Elements:NewTextBox(ElementTitle, TextboxTip, Callback)
				ElementTitle = ElementTitle or "Textbox"
				TextboxTip = TextboxTip or "Gets a value of Textbox"
				Callback = Callback or function()
				end
				local TextboxElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ViewInfo = Instance.new("ImageButton")
				local WriteIcon = Instance.new("ImageLabel")
				local TextBox = Instance.new("TextBox")
				local UICorner_2 = Instance.new("UICorner")
				local TogName = Instance.new("TextLabel")
				TextboxElement.Name = "textboxElement"
				TextboxElement.Parent = SectionInners
				TextboxElement.BackgroundColor3 = ThemeList.ElementColor
				TextboxElement.ClipsDescendants = true
				TextboxElement.Size = UDim2.new(0, 352, 0, 33)
				TextboxElement.AutoButtonColor = false
				TextboxElement.Font = Enum.Font.SourceSans
				TextboxElement.Text = ''
				TextboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextboxElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = TextboxElement
				ViewInfo.Name = "viewInfo"
				ViewInfo.Parent = TextboxElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = ThemeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				WriteIcon.Name = "write"
				WriteIcon.Parent = TextboxElement
				WriteIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				WriteIcon.BackgroundTransparency = 1
				WriteIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				WriteIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				WriteIcon.Size = UDim2.new(0, 21, 0, 21)
				WriteIcon.Image = "rbxassetid://3926305904"
				WriteIcon.ImageColor3 = ThemeList.SchemeColor
				WriteIcon.ImageRectOffset = Vector2.new(324, 604)
				WriteIcon.ImageRectSize = Vector2.new(36, 36)
				TextBox.Parent = TextboxElement
				TextBox.BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 - 6, ThemeList.ElementColor.g * 255 - 6, ThemeList.ElementColor.b * 255 - 7)
				TextBox.BorderSizePixel = 0
				TextBox.ClipsDescendants = true
				TextBox.Position = UDim2.new(0.488749921, 0, 0.212121218, 0)
				TextBox.Size = UDim2.new(0, 150, 0, 18)
				TextBox.ZIndex = 99
				TextBox.ClearTextOnFocus = false
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 19, ThemeList.SchemeColor.g * 255 - 26, ThemeList.SchemeColor.b * 255 - 35)
				TextBox.PlaceholderText = "Type here!"
				TextBox.Text = ''
				TextBox.TextColor3 = ThemeList.SchemeColor
				TextBox.TextSize = 12
				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = TextBox
				TogName.Name = "togName"
				TogName.Parent = TextboxElement
				TogName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TogName.BackgroundTransparency = 1
				TogName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				TogName.Size = UDim2.new(0, 138, 0, 14)
				TogName.Font = Enum.Font.GothamSemibold
				TogName.Text = ElementTitle
				TogName.RichText = true
				TogName.TextColor3 = ThemeList.TextColor
				TogName.TextSize = 14
				TogName.TextXAlignment = Enum.TextXAlignment.Left
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.RichText = true
				MoreInfo.Text = "  " .. TextboxTip
				MoreInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				UpdateSectionFrame()
				UpdateSize()
				local Button = TextboxElement
				local InfoButton = ViewInfo
				Button.MouseButton1Click:Connect(function()
					if Focusing then
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
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
							BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = ThemeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				TextBox.FocusLost:Connect(function(EnterPressed)
					if Focusing then
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
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
						Callback(TextBox.Text)
						wait(0.18)
						TextBox.Text = ''
					end
				end)
				ViewInfo.MouseButton1Click:Connect(function()
					if not InfoOpen then
						InfoOpen = true
						Focusing = true
						for _, Child in next, InfoContainer:GetChildren() do
							if Child ~= MoreInfo then
								Utility:TweenObject(Child, {
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
							BackgroundColor3 = ThemeList.ElementColor,
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
						InfoOpen = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							TextboxElement.BackgroundColor3 = ThemeList.ElementColor
						end
						TextBox.BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 - 6, ThemeList.ElementColor.g * 255 - 6, ThemeList.ElementColor.b * 255 - 7)
						ViewInfo.ImageColor3 = ThemeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = ThemeList.TextColor
						WriteIcon.ImageColor3 = ThemeList.SchemeColor
						TogName.TextColor3 = ThemeList.TextColor
						TextBox.PlaceholderColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 19, ThemeList.SchemeColor.g * 255 - 26, ThemeList.SchemeColor.b * 255 - 35)
						TextBox.TextColor3 = ThemeList.SchemeColor
					end
				end)()
			end
			function Elements:NewToggle(ElementTitle, ToggleTip, Callback)
				local TogFunction = {}
				ElementTitle = ElementTitle or "Toggle"
				ToggleTip = ToggleTip or "Prints Current Toggle State"
				Callback = Callback or function()
				end
				local Toggled = false
				table.insert(SettingsT, ElementTitle)
				local ToggleElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ToggleDisabled = Instance.new("ImageLabel")
				local ToggleEnabled = Instance.new("ImageLabel")
				local TogName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local Sample = Instance.new("ImageLabel")
				ToggleElement.Name = "toggleElement"
				ToggleElement.Parent = SectionInners
				ToggleElement.BackgroundColor3 = ThemeList.ElementColor
				ToggleElement.ClipsDescendants = true
				ToggleElement.Size = UDim2.new(0, 352, 0, 33)
				ToggleElement.AutoButtonColor = false
				ToggleElement.Font = Enum.Font.SourceSans
				ToggleElement.Text = ''
				ToggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = ToggleElement
				ToggleDisabled.Name = "toggleDisabled"
				ToggleDisabled.Parent = ToggleElement
				ToggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleDisabled.BackgroundTransparency = 1
				ToggleDisabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				ToggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleDisabled.Image = "rbxassetid://3926309567"
				ToggleDisabled.ImageColor3 = ThemeList.SchemeColor
				ToggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				ToggleDisabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.Name = "toggleEnabled"
				ToggleEnabled.Parent = ToggleElement
				ToggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleEnabled.BackgroundTransparency = 1
				ToggleEnabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				ToggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleEnabled.Image = "rbxassetid://3926309567"
				ToggleEnabled.ImageColor3 = ThemeList.SchemeColor
				ToggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				ToggleEnabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.ImageTransparency = 1
				TogName.Name = "togName"
				TogName.Parent = ToggleElement
				TogName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TogName.BackgroundTransparency = 1
				TogName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				TogName.Size = UDim2.new(0, 288, 0, 14)
				TogName.Font = Enum.Font.GothamSemibold
				TogName.Text = ElementTitle
				TogName.RichText = true
				TogName.TextColor3 = ThemeList.TextColor
				TogName.TextSize = 14
				TogName.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "viewInfo"
				ViewInfo.Parent = ToggleElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = ThemeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				Sample.Name = "Sample"
				Sample.Parent = ToggleElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = ThemeList.SchemeColor
				Sample.ImageTransparency = 0.6
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.RichText = true
				MoreInfo.Text = "  " .. ToggleTip
				MoreInfo.TextColor3 = ThemeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				local Button = ToggleElement
				local Sample = Sample
				local ToggleIcon = ToggleEnabled
				local InfoButton = ViewInfo
				UpdateSectionFrame()
				UpdateSize()
				Button.MouseButton1Click:Connect(function()
					if not Focusing then
						if Toggled == false then
							TweenService:Create(ToggleIcon, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								ImageTransparency = 0
							}):Play()
							local Ripple = Sample:Clone()
							Ripple.Parent = Button
							local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
							Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
							local Len, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
							for Step = 1, 10 do
								Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
								wait(Len / 12)
							end
							Ripple:Destroy()
						else
							TweenService:Create(ToggleIcon, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								ImageTransparency = 1
							}):Play()
							local Ripple = Sample:Clone()
							Ripple.Parent = Button
							local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
							Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
							local Len, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
							for Step = 1, 10 do
								Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
								wait(Len / 12)
							end
							Ripple:Destroy()
						end
						Toggled = not Toggled
						pcall(Callback, Toggled)
					else
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
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
							BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = ThemeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							ToggleElement.BackgroundColor3 = ThemeList.ElementColor
						end
						ToggleDisabled.ImageColor3 = ThemeList.SchemeColor
						ToggleEnabled.ImageColor3 = ThemeList.SchemeColor
						TogName.TextColor3 = ThemeList.TextColor
						ViewInfo.ImageColor3 = ThemeList.SchemeColor
						Sample.ImageColor3 = ThemeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = ThemeList.TextColor
					end
				end)()
				ViewInfo.MouseButton1Click:Connect(function()
					if not InfoOpen then
						InfoOpen = true
						Focusing = true
						for _, Child in next, InfoContainer:GetChildren() do
							if Child ~= MoreInfo then
								Utility:TweenObject(Child, {
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
							BackgroundColor3 = ThemeList.ElementColor,
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
						InfoOpen = false
					end
				end)
				function TogFunction:UpdateToggle(NewText, IsToggleOn)
					IsToggleOn = IsToggleOn or toggle
					if NewText ~= nil then
						TogName.Text = NewText
					end
					if IsToggleOn then
						Toggled = true
						TweenService:Create(ToggleIcon, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							ImageTransparency = 0
						}):Play()
						pcall(Callback, Toggled)
					else
						Toggled = false
						TweenService:Create(ToggleIcon, TweenInfo(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							ImageTransparency = 1
						}):Play()
						pcall(Callback, Toggled)
					end
				end
				return TogFunction
			end
			function Elements:NewSlider(SliderTitle, SliderTip, Maxvalue, Minvalue, Callback)
				SliderTitle = SliderTitle or "Slider"
				SliderTip = SliderTip or "Slider tip here"
				Maxvalue = Maxvalue or 500
				Minvalue = Minvalue or 16
				startVal = startVal or 0
				Callback = Callback or function()
				end
				local SliderElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local TogName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local SliderBtn = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local SliderDrag = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local WriteIcon = Instance.new("ImageLabel")
				local ValueLabel = Instance.new("TextLabel")
				SliderElement.Name = "sliderElement"
				SliderElement.Parent = SectionInners
				SliderElement.BackgroundColor3 = ThemeList.ElementColor
				SliderElement.ClipsDescendants = true
				SliderElement.Size = UDim2.new(0, 352, 0, 33)
				SliderElement.AutoButtonColor = false
				SliderElement.Font = Enum.Font.SourceSans
				SliderElement.Text = ''
				SliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				SliderElement.TextSize = 14
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = SliderElement
				TogName.Name = "togName"
				TogName.Parent = SliderElement
				TogName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TogName.BackgroundTransparency = 1
				TogName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				TogName.Size = UDim2.new(0, 138, 0, 14)
				TogName.Font = Enum.Font.GothamSemibold
				TogName.Text = SliderTitle
				TogName.RichText = true
				TogName.TextColor3 = ThemeList.TextColor
				TogName.TextSize = 14
				TogName.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "viewInfo"
				ViewInfo.Parent = SliderElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = ThemeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				SliderBtn.Name = "sliderBtn"
				SliderBtn.Parent = SliderElement
				SliderBtn.BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 5, ThemeList.ElementColor.g * 255 + 5, ThemeList.ElementColor.b * 255 + 5)
				SliderBtn.BorderSizePixel = 0
				SliderBtn.Position = UDim2.new(0.488749951, 0, 0.393939406, 0)
				SliderBtn.Size = UDim2.new(0, 149, 0, 6)
				SliderBtn.AutoButtonColor = false
				SliderBtn.Font = Enum.Font.SourceSans
				SliderBtn.Text = ''
				SliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
				SliderBtn.TextSize = 14
				UICorner_2.Parent = SliderBtn
				UIListLayout.Parent = SliderBtn
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				SliderDrag.Name = "sliderDrag"
				SliderDrag.Parent = SliderBtn
				SliderDrag.BackgroundColor3 = ThemeList.SchemeColor
				SliderDrag.BorderColor3 = Color3.fromRGB(74, 99, 135)
				SliderDrag.BorderSizePixel = 0
				SliderDrag.Size = UDim2.new(-0.671140969, 100, 1, 0)
				UICorner_3.Parent = SliderDrag
				WriteIcon.Name = "write"
				WriteIcon.Parent = SliderElement
				WriteIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				WriteIcon.BackgroundTransparency = 1
				WriteIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				WriteIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				WriteIcon.Size = UDim2.new(0, 21, 0, 21)
				WriteIcon.Image = "rbxassetid://3926307971"
				WriteIcon.ImageColor3 = ThemeList.SchemeColor
				WriteIcon.ImageRectOffset = Vector2.new(404, 164)
				WriteIcon.ImageRectSize = Vector2.new(36, 36)
				ValueLabel.Name = "val"
				ValueLabel.Parent = SliderElement
				ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ValueLabel.BackgroundTransparency = 1
				ValueLabel.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
				ValueLabel.Size = UDim2.new(0, 41, 0, 14)
				ValueLabel.Font = Enum.Font.GothamSemibold
				ValueLabel.Text = Minvalue
				ValueLabel.TextColor3 = ThemeList.TextColor
				ValueLabel.TextSize = 14
				ValueLabel.TextTransparency = 1
				ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. SliderTip
				MoreInfo.TextColor3 = ThemeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.RichText = true
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
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
							BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = ThemeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							SliderElement.BackgroundColor3 = ThemeList.ElementColor
						end
						MoreInfo.TextColor3 = ThemeList.TextColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
						ValueLabel.TextColor3 = ThemeList.TextColor
						WriteIcon.ImageColor3 = ThemeList.SchemeColor
						TogName.TextColor3 = ThemeList.TextColor
						ViewInfo.ImageColor3 = ThemeList.SchemeColor
						SliderBtn.BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 5, ThemeList.ElementColor.g * 255 + 5, ThemeList.ElementColor.b * 255 + 5)
						SliderDrag.BackgroundColor3 = ThemeList.SchemeColor
					end
				end)()
				local Value
				SliderBtn.MouseButton1Down:Connect(function()
					if not Focusing then
						TweenService:Create(ValueLabel, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							TextTransparency = 0
						}):Play()
						Value = math.floor((((tonumber(Maxvalue) - tonumber(Minvalue)) / 149) * SliderDrag.AbsoluteSize.X) + tonumber(Minvalue)) or 0
						pcall(function()
							Callback(Value)
						end)
						SliderDrag:TweenSize(UDim2.new(0, math.clamp(Mouse.X - SliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						moveconnection = Mouse.Move:Connect(function()
							ValueLabel.Text = Value
							Value = math.floor((((tonumber(Maxvalue) - tonumber(Minvalue)) / 149) * SliderDrag.AbsoluteSize.X) + tonumber(Minvalue))
							pcall(function()
								Callback(Value)
							end)
							SliderDrag:TweenSize(UDim2.new(0, math.clamp(Mouse.X - SliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						end)
						releaseconnection = UserInputService.InputEnded:Connect(function(Mouse)
							if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch then
								Value = math.floor((((tonumber(Maxvalue) - tonumber(Minvalue)) / 149) * SliderDrag.AbsoluteSize.X) + tonumber(Minvalue))
								pcall(function()
									Callback(Value)
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
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
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
					if not InfoOpen then
						InfoOpen = true
						Focusing = true
						for _, Child in next, InfoContainer:GetChildren() do
							if Child ~= MoreInfo then
								Utility:TweenObject(Child, {
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
							BackgroundColor3 = ThemeList.ElementColor,
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
						InfoOpen = false
					end
				end)
			end
			function Elements:NewDropdown(DropdownTitle, DropdownInfo, OptionList, Callback)
				local DropFunction = {}
				DropdownTitle = DropdownTitle or "Dropdown"
				OptionList = OptionList or {}
				DropdownInfo = DropdownInfo or "Dropdown info"
				Callback = Callback or function()
				end
				local Opened = false
				local DropYSize = 33
				local DropFrame = Instance.new("Frame")
				local DropdownButton = Instance.new("TextButton")
				local DropdownArrowIcon = Instance.new("ImageLabel")
				local ItemTextbox = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local UICorner = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local Sample = Instance.new("ImageLabel")
				Sample.Name = "Sample"
				Sample.Parent = DropdownButton
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = ThemeList.SchemeColor
				Sample.ImageTransparency = 0.6
				DropFrame.Name = "dropFrame"
				DropFrame.Parent = SectionInners
				DropFrame.BackgroundColor3 = ThemeList.Background
				DropFrame.BorderSizePixel = 0
				DropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
				DropFrame.Size = UDim2.new(0, 352, 0, 33)
				DropFrame.ClipsDescendants = true
				local Sample = Sample
				local Button = DropdownButton
				DropdownButton.Name = "dropOpen"
				DropdownButton.Parent = DropFrame
				DropdownButton.BackgroundColor3 = ThemeList.ElementColor
				DropdownButton.Size = UDim2.new(0, 352, 0, 33)
				DropdownButton.AutoButtonColor = false
				DropdownButton.Font = Enum.Font.SourceSans
				DropdownButton.Text = ''
				DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				DropdownButton.TextSize = 14
				DropdownButton.ClipsDescendants = true
				DropdownButton.MouseButton1Click:Connect(function()
					if not Focusing then
						if Opened then
							Opened = false
							DropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local Ripple = Sample:Clone()
							Ripple.Parent = Button
							local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
							Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
							local Len, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
							for Step = 1, 10 do
								Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
								wait(Len / 12)
							end
							Ripple:Destroy()
						else
							Opened = true
							DropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local Ripple = Sample:Clone()
							Ripple.Parent = Button
							local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
							Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
							local Len, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
							for Step = 1, 10 do
								Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
								wait(Len / 12)
							end
							Ripple:Destroy()
						end
					else
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				DropdownArrowIcon.Name = "listImg"
				DropdownArrowIcon.Parent = DropdownButton
				DropdownArrowIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownArrowIcon.BackgroundTransparency = 1
				DropdownArrowIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				DropdownArrowIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				DropdownArrowIcon.Size = UDim2.new(0, 21, 0, 21)
				DropdownArrowIcon.Image = "rbxassetid://3926305904"
				DropdownArrowIcon.ImageColor3 = ThemeList.SchemeColor
				DropdownArrowIcon.ImageRectOffset = Vector2.new(644, 364)
				DropdownArrowIcon.ImageRectSize = Vector2.new(36, 36)
				ItemTextbox.Name = "itemTextbox"
				ItemTextbox.Parent = DropdownButton
				ItemTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ItemTextbox.BackgroundTransparency = 1
				ItemTextbox.Position = UDim2.new(0.0970000029, 0, 0.273000002, 0)
				ItemTextbox.Size = UDim2.new(0, 138, 0, 14)
				ItemTextbox.Font = Enum.Font.GothamSemibold
				ItemTextbox.Text = DropdownTitle
				ItemTextbox.RichText = true
				ItemTextbox.TextColor3 = ThemeList.TextColor
				ItemTextbox.TextSize = 14
				ItemTextbox.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "viewInfo"
				ViewInfo.Parent = DropdownButton
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = ThemeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = DropdownButton
				local Sample = Instance.new("ImageLabel")
				Sample.Name = "Sample"
				Sample.Parent = DropdownButton
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = ThemeList.SchemeColor
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
				MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.RichText = true
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. DropdownInfo
				MoreInfo.TextColor3 = ThemeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				local Hovering = false
				Button.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				Button.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(Button, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = ThemeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							DropdownButton.BackgroundColor3 = ThemeList.ElementColor
						end
						Sample.ImageColor3 = ThemeList.SchemeColor
						DropFrame.BackgroundColor3 = ThemeList.Background
						DropdownArrowIcon.ImageColor3 = ThemeList.SchemeColor
						ItemTextbox.TextColor3 = ThemeList.TextColor
						ViewInfo.ImageColor3 = ThemeList.SchemeColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = ThemeList.TextColor
					end
				end)()
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				ViewInfo.MouseButton1Click:Connect(function()
					if not InfoOpen then
						InfoOpen = true
						Focusing = true
						for _, Child in next, InfoContainer:GetChildren() do
							if Child ~= MoreInfo then
								Utility:TweenObject(Child, {
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
							BackgroundColor3 = ThemeList.ElementColor,
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
						InfoOpen = false
					end
				end)
				for _, Child in next, OptionList do
					local OptionSelect = Instance.new("TextButton")
					local UICorner_2 = Instance.new("UICorner")
					local Sample1 = Instance.new("ImageLabel")
					Sample1.Name = "Sample1"
					Sample1.Parent = OptionSelect
					Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Sample1.BackgroundTransparency = 1
					Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
					Sample1.ImageColor3 = ThemeList.SchemeColor
					Sample1.ImageTransparency = 0.6
					local Sample1 = Sample1
					DropYSize = DropYSize + 33
					OptionSelect.Name = "optionSelect"
					OptionSelect.Parent = DropFrame
					OptionSelect.BackgroundColor3 = ThemeList.ElementColor
					OptionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
					OptionSelect.Size = UDim2.new(0, 352, 0, 33)
					OptionSelect.AutoButtonColor = false
					OptionSelect.Font = Enum.Font.GothamSemibold
					OptionSelect.Text = "  " .. Child
					OptionSelect.TextColor3 = Color3.fromRGB(ThemeList.TextColor.r * 255 - 6, ThemeList.TextColor.g * 255 - 6, ThemeList.TextColor.b * 255 - 6)
					OptionSelect.TextSize = 14
					OptionSelect.TextXAlignment = Enum.TextXAlignment.Left
					OptionSelect.ClipsDescendants = true
					OptionSelect.MouseButton1Click:Connect(function()
						if not Focusing then
							Opened = false
							Callback(Child)
							ItemTextbox.Text = Child
							DropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local Ripple = Sample1:Clone()
							Ripple.Parent = OptionSelect
							local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
							Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
							local Len, Size = 0.35, nil
							if OptionSelect.AbsoluteSize.X >= OptionSelect.AbsoluteSize.Y then
								Size = (OptionSelect.AbsoluteSize.X * 1.5)
							else
								Size = (OptionSelect.AbsoluteSize.Y * 1.5)
							end
							Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
							for Step = 1, 10 do
								Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
								wait(Len / 12)
							end
							Ripple:Destroy()
						else
							for _, Child in next, InfoContainer:GetChildren() do
								Utility:TweenObject(Child, {
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
					local OptionHover = false
					OptionSelect.MouseEnter:Connect(function()
						if not Focusing then
							TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
							}):Play()
							OptionHover = true
						end
					end)
					OptionSelect.MouseLeave:Connect(function()
						if not Focusing then
							TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								BackgroundColor3 = ThemeList.ElementColor,
							}):Play()
							OptionHover = false
						end
					end)
					coroutine.wrap(function()
						while wait() do
							if not OptionHover then
								OptionSelect.BackgroundColor3 = ThemeList.ElementColor
							end
							OptionSelect.TextColor3 = Color3.fromRGB(ThemeList.TextColor.r * 255 - 6, ThemeList.TextColor.g * 255 - 6, ThemeList.TextColor.b * 255 - 6)
							Sample1.ImageColor3 = ThemeList.SchemeColor
						end
					end)()
				end
				function DropFunction:Refresh(NewOptions)
					NewOptions = NewOptions or {}
					for _, Child in next, DropFrame:GetChildren() do
						if Child.Name == "optionSelect" then
							Child:Destroy()
						end
					end
					for _, Child in next, NewOptions do
						local OptionSelect = Instance.new("TextButton")
						local UICorner_2 = Instance.new("UICorner")
						local Sample11 = Instance.new("ImageLabel")
						Sample11.Name = "Sample11"
						Sample11.Parent = OptionSelect
						Sample11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Sample11.BackgroundTransparency = 1
						Sample11.Image = "http://www.roblox.com/asset/?id=4560909609"
						Sample11.ImageColor3 = ThemeList.SchemeColor
						Sample11.ImageTransparency = 0.6
						local Sample11 = Sample11
						DropYSize = DropYSize + 33
						OptionSelect.Name = "optionSelect"
						OptionSelect.Parent = DropFrame
						OptionSelect.BackgroundColor3 = ThemeList.ElementColor
						OptionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
						OptionSelect.Size = UDim2.new(0, 352, 0, 33)
						OptionSelect.AutoButtonColor = false
						OptionSelect.Font = Enum.Font.GothamSemibold
						OptionSelect.Text = "  " .. Child
						OptionSelect.TextColor3 = Color3.fromRGB(ThemeList.TextColor.r * 255 - 6, ThemeList.TextColor.g * 255 - 6, ThemeList.TextColor.b * 255 - 6)
						OptionSelect.TextSize = 14
						OptionSelect.TextXAlignment = Enum.TextXAlignment.Left
						OptionSelect.ClipsDescendants = true
						UICorner_2.CornerRadius = UDim.new(0, 4)
						UICorner_2.Parent = OptionSelect
						OptionSelect.MouseButton1Click:Connect(function()
							if not Focusing then
								Opened = false
								Callback(Child)
								ItemTextbox.Text = Child
								DropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
								wait(0.1)
								UpdateSectionFrame()
								UpdateSize()
								local Ripple = Sample11:Clone()
								Ripple.Parent = OptionSelect
								local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
								Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
								local Len, Size = 0.35, nil
								if OptionSelect.AbsoluteSize.X >= OptionSelect.AbsoluteSize.Y then
									Size = (OptionSelect.AbsoluteSize.X * 1.5)
								else
									Size = (OptionSelect.AbsoluteSize.Y * 1.5)
								end
								Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
								for Step = 1, 10 do
									Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
									wait(Len / 12)
								end
								Ripple:Destroy()
							else
								for _, Child in next, InfoContainer:GetChildren() do
									Utility:TweenObject(Child, {
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
						local Hovering = false
						OptionSelect.MouseEnter:Connect(function()
							if not Focusing then
								TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
								}):Play()
								Hovering = true
							end
						end)
						OptionSelect.MouseLeave:Connect(function()
							if not Focusing then
								TweenService:Create(OptionSelect, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = ThemeList.ElementColor,
								}):Play()
								Hovering = false
							end
						end)
						coroutine.wrap(function()
							while wait() do
								if not OptionHover then
									OptionSelect.BackgroundColor3 = ThemeList.ElementColor
								end
								OptionSelect.TextColor3 = Color3.fromRGB(ThemeList.TextColor.r * 255 - 6, ThemeList.TextColor.g * 255 - 6, ThemeList.TextColor.b * 255 - 6)
								Sample11.ImageColor3 = ThemeList.SchemeColor
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
			function Elements:NewKeybind(KeybindTitle, KeybindInfo, First, Callback)
				KeybindTitle = KeybindTitle or "KeybindText"
				KeybindInfo = KeybindInfo or "KebindInfo"
				Callback = Callback or function()
				end
				local PreviousKey = First.Name
				local KeybindElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local TogName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local TouchIcon = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")
				local TogName_2 = Instance.new("TextLabel")
				local InfoButton = ViewInfo
				local MoreInfo = Instance.new("TextLabel")
				local UICorner1 = Instance.new("UICorner")
				local Sample = Sample
				KeybindElement.Name = "keybindElement"
				KeybindElement.Parent = SectionInners
				KeybindElement.BackgroundColor3 = ThemeList.ElementColor
				KeybindElement.ClipsDescendants = true
				KeybindElement.Size = UDim2.new(0, 352, 0, 33)
				KeybindElement.AutoButtonColor = false
				KeybindElement.Font = Enum.Font.SourceSans
				KeybindElement.Text = ''
				KeybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				KeybindElement.TextSize = 14
				KeybindElement.MouseButton1Click:connect(function(ClickEvent)
					if not Focusing then
						TogName_2.Text = ". . ."
						local CapturedInput, GameProcessed = game:GetService("UserInputService").InputBegan:wait()
						if CapturedInput.KeyCode.Name ~= "Unknown" then
							TogName_2.Text = CapturedInput.KeyCode.Name
							PreviousKey = CapturedInput.KeyCode.Name
						end
						local Ripple = Sample:Clone()
						Ripple.Parent = KeybindElement
						local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
						Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
						local Len, Size = 0.35, nil
						if KeybindElement.AbsoluteSize.X >= KeybindElement.AbsoluteSize.Y then
							Size = (KeybindElement.AbsoluteSize.X * 1.5)
						else
							Size = (KeybindElement.AbsoluteSize.Y * 1.5)
						end
						Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
						for Step = 1, 10 do
							Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
							wait(Len / 12)
						end
					else
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
								Position = UDim2.new(0, 0, 2, 0),
							}, 0.2)
							Focusing = false
						end
						Utility:TweenObject(BlurFrame, {
							BackgroundTransparency = 1
						}, 0.2)
					end
				end)
				UserInputService.InputBegan:connect(function(CurrentInput, GameProcessed)
					if not GameProcessed then
						if CurrentInput.KeyCode.Name == PreviousKey then
							Callback()
						end
					end
				end)
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.RichText = true
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. KeybindInfo
				MoreInfo.TextColor3 = ThemeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				Sample.Name = "Sample"
				Sample.Parent = KeybindElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = ThemeList.SchemeColor
				Sample.ImageTransparency = 0.6
				TogName.Name = "togName"
				TogName.Parent = KeybindElement
				TogName.BackgroundColor3 = ThemeList.TextColor
				TogName.BackgroundTransparency = 1
				TogName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				TogName.Size = UDim2.new(0, 222, 0, 14)
				TogName.Font = Enum.Font.GothamSemibold
				TogName.Text = KeybindTitle
				TogName.RichText = true
				TogName.TextColor3 = ThemeList.TextColor
				TogName.TextSize = 14
				TogName.TextXAlignment = Enum.TextXAlignment.Left
				ViewInfo.Name = "viewInfo"
				ViewInfo.Parent = KeybindElement
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = ThemeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				ViewInfo.MouseButton1Click:Connect(function()
					if not InfoOpen then
						InfoOpen = true
						Focusing = true
						for _, Child in next, InfoContainer:GetChildren() do
							if Child ~= MoreInfo then
								Utility:TweenObject(Child, {
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
							BackgroundColor3 = ThemeList.ElementColor,
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
						InfoOpen = false
					end
				end)
				UpdateSectionFrame()
				UpdateSize()
				local OptionHover = false
				KeybindElement.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(KeybindElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
						}):Play()
						OptionHover = true
					end
				end)
				KeybindElement.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(KeybindElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = ThemeList.ElementColor,
						}):Play()
						OptionHover = false
					end
				end)
				UICorner1.CornerRadius = UDim.new(0, 4)
				UICorner1.Parent = MoreInfo
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = KeybindElement
				TouchIcon.Name = "touch"
				TouchIcon.Parent = KeybindElement
				TouchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TouchIcon.BackgroundTransparency = 1
				TouchIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				TouchIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				TouchIcon.Size = UDim2.new(0, 21, 0, 21)
				TouchIcon.Image = "rbxassetid://3926305904"
				TouchIcon.ImageColor3 = ThemeList.SchemeColor
				TouchIcon.ImageRectOffset = Vector2.new(364, 284)
				TouchIcon.ImageRectSize = Vector2.new(36, 36)
				TogName_2.Name = "togName"
				TogName_2.Parent = KeybindElement
				TogName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TogName_2.BackgroundTransparency = 1
				TogName_2.Position = UDim2.new(0.727386296, 0, 0.272727281, 0)
				TogName_2.Size = UDim2.new(0, 70, 0, 14)
				TogName_2.Font = Enum.Font.GothamSemibold
				TogName_2.Text = PreviousKey
				TogName_2.TextColor3 = ThemeList.SchemeColor
				TogName_2.TextSize = 14
				TogName_2.TextXAlignment = Enum.TextXAlignment.Right
				coroutine.wrap(function()
					while wait() do
						if not OptionHover then
							KeybindElement.BackgroundColor3 = ThemeList.ElementColor
						end
						TogName_2.TextColor3 = ThemeList.SchemeColor
						TouchIcon.ImageColor3 = ThemeList.SchemeColor
						ViewInfo.ImageColor3 = ThemeList.SchemeColor
						TogName.BackgroundColor3 = ThemeList.TextColor
						TogName.TextColor3 = ThemeList.TextColor
						Sample.ImageColor3 = ThemeList.SchemeColor
						MoreInfo.TextColor3 = ThemeList.TextColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
					end
				end)()
			end
			function Elements:NewColorPicker(ColorTitle, ColorInfo, DefaultColor, Callback)
				ColorTitle = ColorTitle or "ColorPicker"
				Callback = Callback or function()
				end
				DefaultColor = DefaultColor or Color3.fromRGB(1, 1, 1)
				local Hue, Saturation, Value = Color3.toHSV(DefaultColor)
				local ColorOpened = false
				local ColorElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local ColorHeader = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TouchIcon = Instance.new("ImageLabel")
				local TogName = Instance.new("TextLabel")
				local ViewInfo = Instance.new("ImageButton")
				local ColorPreview = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local ColorInners = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local RgbGradient = Instance.new("ImageButton")
				local UICorner_5 = Instance.new("UICorner")
				local RgbIndicator = Instance.new("ImageLabel")
				local DarknessGradient = Instance.new("ImageButton")
				local UICorner_6 = Instance.new("UICorner")
				local DarknessIndicator = Instance.new("ImageLabel")
				local ToggleDisabled = Instance.new("ImageLabel")
				local ToggleEnabled = Instance.new("ImageLabel")
				local RainbowButton = Instance.new("TextButton")
				local TogName_2 = Instance.new("TextLabel")
				local Sample = Instance.new("ImageLabel")
				Sample.Name = "Sample"
				Sample.Parent = ColorHeader
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = ThemeList.SchemeColor
				Sample.ImageTransparency = 0.6
				local Button = ColorHeader
				local Sample = Sample
				ColorElement.Name = "colorElement"
				ColorElement.Parent = SectionInners
				ColorElement.BackgroundColor3 = ThemeList.ElementColor
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
							local Ripple = Sample:Clone()
							Ripple.Parent = Button
							local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
							Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
							local Len, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
							for Step = 1, 10 do
								Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
								wait(Len / 12)
							end
							Ripple:Destroy()
						else
							ColorOpened = true
							ColorElement:TweenSize(UDim2.new(0, 352, 0, 141), "InOut", "Linear", 0.08, true)
							wait(0.1)
							UpdateSectionFrame()
							UpdateSize()
							local Ripple = Sample:Clone()
							Ripple.Parent = Button
							local OffsetX, OffsetY = (Mouse.X - Ripple.AbsolutePosition.X), (Mouse.Y - Ripple.AbsolutePosition.Y)
							Ripple.Position = UDim2.new(0, OffsetX, 0, OffsetY)
							local Len, Size = 0.35, nil
							if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
								Size = (Button.AbsoluteSize.X * 1.5)
							else
								Size = (Button.AbsoluteSize.Y * 1.5)
							end
							Ripple:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, (- Size / 2), 0.5, (- Size / 2)), "Out", "Quad", Len, true, nil)
							for Step = 1, 10 do
								Ripple.ImageTransparency = Ripple.ImageTransparency + 0.05
								wait(Len / 12)
							end
							Ripple:Destroy()
						end
					else
						for _, Child in next, InfoContainer:GetChildren() do
							Utility:TweenObject(Child, {
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
				ColorHeader.Name = "colorHeader"
				ColorHeader.Parent = ColorElement
				ColorHeader.BackgroundColor3 = ThemeList.ElementColor
				ColorHeader.Size = UDim2.new(0, 352, 0, 33)
				ColorHeader.ClipsDescendants = true
				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = ColorHeader
				TouchIcon.Name = "touch"
				TouchIcon.Parent = ColorHeader
				TouchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TouchIcon.BackgroundTransparency = 1
				TouchIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
				TouchIcon.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
				TouchIcon.Size = UDim2.new(0, 21, 0, 21)
				TouchIcon.Image = "rbxassetid://3926305904"
				TouchIcon.ImageColor3 = ThemeList.SchemeColor
				TouchIcon.ImageRectOffset = Vector2.new(44, 964)
				TouchIcon.ImageRectSize = Vector2.new(36, 36)
				TogName.Name = "togName"
				TogName.Parent = ColorHeader
				TogName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TogName.BackgroundTransparency = 1
				TogName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
				TogName.Size = UDim2.new(0, 288, 0, 14)
				TogName.Font = Enum.Font.GothamSemibold
				TogName.Text = ColorTitle
				TogName.TextColor3 = ThemeList.TextColor
				TogName.TextSize = 14
				TogName.RichText = true
				TogName.TextXAlignment = Enum.TextXAlignment.Left
				local MoreInfo = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				MoreInfo.Name = "TipMore"
				MoreInfo.Parent = InfoContainer
				MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
				MoreInfo.Position = UDim2.new(0, 0, 2, 0)
				MoreInfo.Size = UDim2.new(0, 353, 0, 33)
				MoreInfo.ZIndex = 9
				MoreInfo.Font = Enum.Font.GothamSemibold
				MoreInfo.Text = "  " .. ColorInfo
				MoreInfo.TextColor3 = ThemeList.TextColor
				MoreInfo.TextSize = 14
				MoreInfo.RichText = true
				MoreInfo.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MoreInfo
				ViewInfo.Name = "viewInfo"
				ViewInfo.Parent = ColorHeader
				ViewInfo.BackgroundTransparency = 1
				ViewInfo.LayoutOrder = 9
				ViewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				ViewInfo.Size = UDim2.new(0, 23, 0, 23)
				ViewInfo.ZIndex = 2
				ViewInfo.Image = "rbxassetid://3926305904"
				ViewInfo.ImageColor3 = ThemeList.SchemeColor
				ViewInfo.ImageRectOffset = Vector2.new(764, 764)
				ViewInfo.ImageRectSize = Vector2.new(36, 36)
				ViewInfo.MouseButton1Click:Connect(function()
					if not InfoOpen then
						InfoOpen = true
						Focusing = true
						for _, Child in next, InfoContainer:GetChildren() do
							if Child ~= MoreInfo then
								Utility:TweenObject(Child, {
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
							BackgroundColor3 = ThemeList.ElementColor,
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
						InfoOpen = false
					end
				end)
				ColorPreview.Name = "colorCurrent"
				ColorPreview.Parent = ColorHeader
				ColorPreview.BackgroundColor3 = DefaultColor
				ColorPreview.Position = UDim2.new(0.792613626, 0, 0.212121218, 0)
				ColorPreview.Size = UDim2.new(0, 42, 0, 18)
				UICorner_3.CornerRadius = UDim.new(0, 4)
				UICorner_3.Parent = ColorPreview
				UIListLayout.Parent = ColorElement
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)
				ColorInners.Name = "colorInners"
				ColorInners.Parent = ColorElement
				ColorInners.BackgroundColor3 = ThemeList.ElementColor
				ColorInners.Position = UDim2.new(0, 0, 0.255319148, 0)
				ColorInners.Size = UDim2.new(0, 352, 0, 105)
				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = ColorInners
				RgbGradient.Name = "rgb"
				RgbGradient.Parent = ColorInners
				RgbGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RgbGradient.BackgroundTransparency = 1
				RgbGradient.Position = UDim2.new(0.0198863633, 0, 0.0476190485, 0)
				RgbGradient.Size = UDim2.new(0, 211, 0, 93)
				RgbGradient.Image = "http://www.roblox.com/asset/?id=6523286724"
				UICorner_5.CornerRadius = UDim.new(0, 4)
				UICorner_5.Parent = RgbGradient
				RgbIndicator.Name = "rbgcircle"
				RgbIndicator.Parent = RgbGradient
				RgbIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RgbIndicator.BackgroundTransparency = 1
				RgbIndicator.Size = UDim2.new(0, 14, 0, 14)
				RgbIndicator.Image = "rbxassetid://3926309567"
				RgbIndicator.ImageColor3 = Color3.fromRGB(0, 0, 0)
				RgbIndicator.ImageRectOffset = Vector2.new(628, 420)
				RgbIndicator.ImageRectSize = Vector2.new(48, 48)
				DarknessGradient.Name = "darkness"
				DarknessGradient.Parent = ColorInners
				DarknessGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DarknessGradient.BackgroundTransparency = 1
				DarknessGradient.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
				DarknessGradient.Size = UDim2.new(0, 18, 0, 93)
				DarknessGradient.Image = "http://www.roblox.com/asset/?id=6523291212"
				UICorner_6.CornerRadius = UDim.new(0, 4)
				UICorner_6.Parent = DarknessGradient
				DarknessIndicator.Name = "darkcircle"
				DarknessIndicator.Parent = DarknessGradient
				DarknessIndicator.AnchorPoint = Vector2.new(0.5, 0)
				DarknessIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DarknessIndicator.BackgroundTransparency = 1
				DarknessIndicator.Size = UDim2.new(0, 14, 0, 14)
				DarknessIndicator.Image = "rbxassetid://3926309567"
				DarknessIndicator.ImageColor3 = Color3.fromRGB(0, 0, 0)
				DarknessIndicator.ImageRectOffset = Vector2.new(628, 420)
				DarknessIndicator.ImageRectSize = Vector2.new(48, 48)
				ToggleDisabled.Name = "toggleDisabled"
				ToggleDisabled.Parent = ColorInners
				ToggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleDisabled.BackgroundTransparency = 1
				ToggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
				ToggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleDisabled.Image = "rbxassetid://3926309567"
				ToggleDisabled.ImageColor3 = ThemeList.SchemeColor
				ToggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				ToggleDisabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.Name = "toggleEnabled"
				ToggleEnabled.Parent = ColorInners
				ToggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleEnabled.BackgroundTransparency = 1
				ToggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
				ToggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				ToggleEnabled.Image = "rbxassetid://3926309567"
				ToggleEnabled.ImageColor3 = ThemeList.SchemeColor
				ToggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				ToggleEnabled.ImageRectSize = Vector2.new(48, 48)
				ToggleEnabled.ImageTransparency = 1
				RainbowButton.Name = "onrainbow"
				RainbowButton.Parent = ToggleEnabled
				RainbowButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RainbowButton.BackgroundTransparency = 1
				RainbowButton.Position = UDim2.new(2.90643607e-6, 0, 0, 0)
				RainbowButton.Size = UDim2.new(1, 0, 1, 0)
				RainbowButton.Font = Enum.Font.SourceSans
				RainbowButton.Text = ''
				RainbowButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				RainbowButton.TextSize = 14
				TogName_2.Name = "togName"
				TogName_2.Parent = ColorInners
				TogName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TogName_2.BackgroundTransparency = 1
				TogName_2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
				TogName_2.Size = UDim2.new(0, 278, 0, 14)
				TogName_2.Font = Enum.Font.GothamSemibold
				TogName_2.Text = "Rainbow"
				TogName_2.TextColor3 = ThemeList.TextColor
				TogName_2.TextSize = 14
				TogName_2.TextXAlignment = Enum.TextXAlignment.Left
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				local Hovering = false
				ColorElement.MouseEnter:Connect(function()
					if not Focusing then
						TweenService:Create(ColorElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = Color3.fromRGB(ThemeList.ElementColor.r * 255 + 8, ThemeList.ElementColor.g * 255 + 9, ThemeList.ElementColor.b * 255 + 10),
						}):Play()
						Hovering = true
					end
				end)
				ColorElement.MouseLeave:Connect(function()
					if not Focusing then
						TweenService:Create(ColorElement, TweenInfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							BackgroundColor3 = ThemeList.ElementColor,
						}):Play()
						Hovering = false
					end
				end)
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(MoreInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				coroutine.wrap(function()
					while wait() do
						if not Hovering then
							ColorElement.BackgroundColor3 = ThemeList.ElementColor
						end
						TouchIcon.ImageColor3 = ThemeList.SchemeColor
						ColorHeader.BackgroundColor3 = ThemeList.ElementColor
						TogName.TextColor3 = ThemeList.TextColor
						MoreInfo.BackgroundColor3 = Color3.fromRGB(ThemeList.SchemeColor.r * 255 - 14, ThemeList.SchemeColor.g * 255 - 17, ThemeList.SchemeColor.b * 255 - 13)
						MoreInfo.TextColor3 = ThemeList.TextColor
						ViewInfo.ImageColor3 = ThemeList.SchemeColor
						ColorInners.BackgroundColor3 = ThemeList.ElementColor
						ToggleDisabled.ImageColor3 = ThemeList.SchemeColor
						ToggleEnabled.ImageColor3 = ThemeList.SchemeColor
						TogName_2.TextColor3 = ThemeList.TextColor
						Sample.ImageColor3 = ThemeList.SchemeColor
					end
				end)()
				UpdateSectionFrame()
				UpdateSize()
				local PickingColor = false
				local PickingDarkness = false
				local DarknessGradient = false
				local RgbGradient = RgbGradient
				local DarknessGradient = DarknessGradient
				local RgbCursor = RgbIndicator
				local DarknessCursor = DarknessIndicator
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
				local function HandleColorDrag()
					if PickingColor then
						local MouseLoc = MouseLocation()
						local OffsetX, OffsetY = MouseLoc.X - RgbGradient.AbsolutePosition.X, MouseLoc.Y - RgbGradient.AbsolutePosition.Y
						local MaxX, MaxY = RgbGradient.AbsoluteSize.X, RgbGradient.AbsoluteSize.Y
						if OffsetX < 0 then
							OffsetX = 0
						end
						if OffsetX > MaxX then
							OffsetX = MaxX
						end
						if OffsetY < 0 then
							OffsetY = 0
						end
						if OffsetY > MaxY then
							OffsetY = MaxY
						end
						OffsetX = OffsetX / MaxX
						OffsetY = OffsetY / MaxY
						local CursorOffsetX = RgbCursor.AbsoluteSize.X / 2
						local CursorOffsetY = RgbCursor.AbsoluteSize.Y / 2
						RgbCursor.Position = UDim2.new(OffsetX, - CursorOffsetX, OffsetY, - CursorOffsetY)
						Color = {
							1 - OffsetX,
							1 - OffsetY,
							Color[3],
						}
						local ComputedColor = Color3.fromHSV(Color[1], Color[2], Color[3])
						ColorPreview.BackgroundColor3 = ComputedColor
						Callback(ComputedColor)
					end
					if PickingDarkness then
						local MouseLoc = MouseLocation()
						local OffsetY = MouseLoc.Y - DarknessGradient.AbsolutePosition.Y
						local MaxY = DarknessGradient.AbsoluteSize.Y
						if OffsetY < 0 then
							OffsetY = 0
						end
						if OffsetY > MaxY then
							OffsetY = MaxY
						end
						OffsetY = OffsetY / MaxY
						local CursorOffsetY = DarknessCursor.AbsoluteSize.Y / 2
						DarknessCursor.Position = UDim2.new(0.5, 0, OffsetY, - CursorOffsetY)
						DarknessCursor.ImageColor3 = Color3.fromHSV(0, 0, OffsetY)
						Color = {
							Color[1],
							Color[2],
							1 - OffsetY,
						}
						local ComputedColor = Color3.fromHSV(Color[1], Color[2], Color[3])
						ColorPreview.BackgroundColor3 = ComputedColor
						Callback(ComputedColor)
					end
				end
				local function SetColor(ColorValues)
					local CursorOffsetX = RgbCursor.AbsoluteSize.X / 2
					local CursorOffsetY = RgbCursor.AbsoluteSize.Y / 2
					Color = {
						ColorValues[1],
						ColorValues[2],
						ColorValues[3],
					}
					RgbCursor.Position = UDim2.new(Color[1], - CursorOffsetX, Color[2] - 1, - CursorOffsetY)
					DarknessCursor.Position = UDim2.new(0.5, 0, Color[3] - 1, - CursorOffsetY)
					local ComputedColor = Color3.fromHSV(Color[1], Color[2], Color[3])
					ColorPreview.BackgroundColor3 = ComputedColor
				end
				local function SetRgbColor(ColorValues)
					local CursorOffsetX = RgbCursor.AbsoluteSize.X / 2
					local CursorOffsetY = RgbCursor.AbsoluteSize.Y / 2
					Color = {
						ColorValues[1],
						ColorValues[2],
						Color[3],
					}
					RgbCursor.Position = UDim2.new(Color[1], - CursorOffsetX, Color[2] - 1, - CursorOffsetY)
					local ComputedColor = Color3.fromHSV(Color[1], Color[2], Color[3])
					ColorPreview.BackgroundColor3 = ComputedColor
					Callback(ComputedColor)
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
						RainbowConnection = RunService.Heartbeat:Connect(function()
							SetRgbColor({
								Zigzag(Counter),
								1,
								1,
							})
							Counter = Counter + 0.01
						end)
					end
				end
				RainbowButton.MouseButton1Click:Connect(ToggleRainbow)
				Mouse.Move:connect(HandleColorDrag)
				RgbGradient.MouseButton1Down:connect(function()
					PickingColor = true
				end)
				DarknessGradient.MouseButton1Down:connect(function()
					PickingDarkness = true
				end)
				UserInputService.InputEnded:Connect(function(Input)
					if Input.UserInputType.Name == "MouseButton1" then
						if PickingDarkness then
							PickingDarkness = false
						end
						if PickingColor then
							PickingColor = false
						end
					end
				end)
				SetColor({
					Hue,
					Saturation,
					Value
				})
			end
			function Elements:NewLabel(Title)
				local LabelFunctions = {}
				local Label = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				Label.Name = "label"
				Label.Parent = SectionInners
				Label.BackgroundColor3 = ThemeList.SchemeColor
				Label.BorderSizePixel = 0
				Label.ClipsDescendants = true
				Label.Text = Title
				Label.Size = UDim2.new(0, 352, 0, 33)
				Label.Font = Enum.Font.Gotham
				Label.Text = "  " .. Title
				Label.RichText = true
				Label.TextColor3 = ThemeList.TextColor
				Objects[Label] = "TextColor3"
				Label.TextSize = 14
				Label.TextXAlignment = Enum.TextXAlignment.Left
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Label
				if ThemeList.SchemeColor == Color3.fromRGB(255, 255, 255) then
					Utility:TweenObject(Label, {
						TextColor3 = Color3.fromRGB(0, 0, 0),
					}, 0.2)
				end
				if ThemeList.SchemeColor == Color3.fromRGB(0, 0, 0) then
					Utility:TweenObject(Label, {
						TextColor3 = Color3.fromRGB(255, 255, 255),
					}, 0.2)
				end
				coroutine.wrap(function()
					while wait() do
						Label.BackgroundColor3 = ThemeList.SchemeColor
						Label.TextColor3 = ThemeList.TextColor
					end
				end)()
				UpdateSectionFrame()
				UpdateSize()
				function LabelFunctions:UpdateLabel(NewText)
					if Label.Text ~= "  " .. NewText then
						Label.Text = "  " .. NewText
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
