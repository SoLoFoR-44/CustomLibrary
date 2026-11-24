local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LoaderLibrary = {}

local Theme = {
	Background = Color3.fromRGB(17, 17, 21),
	Header = Color3.fromRGB(23, 23, 29),
	Panel = Color3.fromRGB(21, 21, 26),
	Card = Color3.fromRGB(16, 16, 20),
	Card_Hover = Color3.fromRGB(24, 24, 30),
	Border = Color3.fromRGB(36, 36, 44),
	Accent = Color3.fromRGB(218, 38, 107),
	Text_Primary = Color3.fromRGB(240, 240, 245),
	Text_Muted = Color3.fromRGB(130, 130, 142),
	Button_Exit = Color3.fromRGB(22, 22, 27),
	Button_Load = Color3.fromRGB(28, 28, 35),
	Button_Hover = Color3.fromRGB(36, 36, 45),
	Scroll_Bar = Color3.fromRGB(169, 169, 169),
}

local function Create_Instance(Class_Name, Properties, Parent)
	local Obj = Instance.new(Class_Name)
	for Key, Value in pairs(Properties) do
		Obj[Key] = Value
	end
	if Parent then
		Obj.Parent = Parent
	end
	return Obj
end

local function Apply_Corner(Parent, Radius)
	return Create_Instance("UICorner", {
		CornerRadius = UDim.new(0, Radius),
	}, Parent)
end

local function Apply_Stroke(Parent, Color, Thickness)
	return Create_Instance("UIStroke", {
		Color = Color or Theme.Border,
		Thickness = Thickness or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, Parent)
end

function LoaderLibrary:CreateWindow(Options)
	Options = Options or {}
	local Gui_Name = Options.Gui_Name or "LoaderUI"
	local Title = Options.Title or "Loader"
	local Icon_Id = Options.Icon_Id or "rbxassetid://12702460854"
	local Expires = Options.Expires or "Never"
	local Last_Update = Options.Last_Update or "???"
	local On_Load = Options.On_Load or function() end

	local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

	local Gui_Parent = (type(gethui) == "function" and gethui()) or CoreGui
	local Existing_Gui = Gui_Parent:FindFirstChild(Gui_Name)
	if Existing_Gui then
		Existing_Gui:Destroy()
	end

	local Screen_Gui = Instance.new("ScreenGui")
	ProtectGui(Screen_Gui)
	Screen_Gui.Name = Gui_Name
	Screen_Gui.ResetOnSpawn = false
	Screen_Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Screen_Gui.IgnoreGuiInset = true
	Screen_Gui.Parent = Gui_Parent

	local Main_Frame = Create_Instance("Frame", {
		Name = "Main_Frame",
		Size = UDim2.fromOffset(520, 315),
		Position = UDim2.new(0.5, -260, 0.5, -157),
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		ClipsDescendants = true,
	}, Screen_Gui)
	Apply_Stroke(Main_Frame, Theme.Border, 1)

	Create_Instance("Frame", {
		Name = "Top_Accent",
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0,
		ZIndex = 3,
	}, Main_Frame)

	local Header_Frame = Create_Instance("Frame", {
		Name = "Header_Frame",
		Size = UDim2.new(1, 0, 0, 48),
		Position = UDim2.fromOffset(0, 2),
		BackgroundColor3 = Theme.Header,
		BorderSizePixel = 0,
	}, Main_Frame)

	Create_Instance("Frame", {
		Name = "Header_Divider",
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1),
		BackgroundColor3 = Theme.Border,
		BorderSizePixel = 0,
	}, Header_Frame)

	Create_Instance("TextLabel", {
		Name = "Title_Label",
		Size = UDim2.new(1, -32, 1, 0),
		Position = UDim2.fromOffset(16, 0),
		BackgroundTransparency = 1,
		Text = Title,
		Font = Enum.Font.GothamBlack,
		TextSize = 22,
		TextColor3 = Theme.Text_Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, Header_Frame)

	local Body_Frame = Create_Instance("Frame", {
		Name = "Body_Frame",
		Size = UDim2.new(1, -28, 1, -78),
		Position = UDim2.fromOffset(14, 64),
		BackgroundTransparency = 1,
	}, Main_Frame)

	local Left_Panel = Create_Instance("Frame", {
		Name = "Left_Panel",
		Size = UDim2.new(0, 240, 1, 0),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
	}, Body_Frame)
	Apply_Corner(Left_Panel, 6)
	Apply_Stroke(Left_Panel, Theme.Border, 1)

	local Selected_Header = Create_Instance("Frame", {
		Name = "Selected_Header",
		Size = UDim2.new(1, -24, 0, 46),
		Position = UDim2.fromOffset(12, 12),
		BackgroundTransparency = 1,
	}, Left_Panel)

	Create_Instance("ImageLabel", {
		Name = "Product_Icon",
		Size = UDim2.fromOffset(34, 34),
		Position = UDim2.fromOffset(0, 6),
		BackgroundTransparency = 1,
		Image = Icon_Id,
		ScaleType = Enum.ScaleType.Fit,
	}, Selected_Header)

	local Selected_Title = Create_Instance("TextLabel", {
		Name = "Selected_Title",
		Size = UDim2.new(1, -46, 0, 20),
		Position = UDim2.fromOffset(44, 5),
		BackgroundTransparency = 1,
		Text = "None",
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = Theme.Text_Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, Selected_Header)

	local Products_Count = Create_Instance("TextLabel", {
		Name = "Products_Count",
		Size = UDim2.new(1, -46, 0, 16),
		Position = UDim2.fromOffset(44, 25),
		BackgroundTransparency = 1,
		Text = "Products: 0",
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.Text_Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, Selected_Header)

	local Products_Scroll = Create_Instance("ScrollingFrame", {
		Name = "Products_Scroll",
		Size = UDim2.new(1, -14, 1, -74),
		Position = UDim2.fromOffset(10, 64),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Theme.Scroll_Bar,
		ScrollBarImageTransparency = 0.15,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
	}, Left_Panel)

	Create_Instance("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 8),
	}, Products_Scroll)

	Create_Instance("UIPadding", {
		PaddingTop = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 1),
	}, Products_Scroll)

	local Right_Column = Create_Instance("Frame", {
		Name = "Right_Column",
		Size = UDim2.new(0, 240, 1, 0),
		Position = UDim2.new(1, -240, 0, 0),
		BackgroundTransparency = 1,
	}, Body_Frame)

	local Changelog_Panel = Create_Instance("Frame", {
		Name = "Changelog_Panel",
		Size = UDim2.new(1, 0, 0, 126),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
	}, Right_Column)
	Apply_Corner(Changelog_Panel, 6)
	Apply_Stroke(Changelog_Panel, Theme.Border, 1)

	Create_Instance("TextLabel", {
		Name = "Changelog_Title",
		Size = UDim2.new(1, -24, 0, 26),
		Position = UDim2.fromOffset(12, 6),
		BackgroundTransparency = 1,
		Text = "Changelog",
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text_Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, Changelog_Panel)

	Create_Instance("Frame", {
		Name = "Changelog_Divider",
		Size = UDim2.new(1, -24, 0, 1),
		Position = UDim2.fromOffset(12, 34),
		BackgroundColor3 = Theme.Border,
		BorderSizePixel = 0,
	}, Changelog_Panel)

	local Changelog_Scroll = Create_Instance("ScrollingFrame", {
		Name = "Changelog_Scroll",
		Size = UDim2.new(1, -18, 1, -44),
		Position = UDim2.fromOffset(12, 40),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.Scroll_Bar,
		ScrollingDirection = Enum.ScrollingDirection.Y,
	}, Changelog_Panel)

	local Changelog_Text = Create_Instance("TextLabel", {
		Name = "Changelog_Text",
		Size = UDim2.new(1, -6, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.Text_Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
	}, Changelog_Scroll)

	local Info_Panel = Create_Instance("Frame", {
		Name = "Info_Panel",
		Size = UDim2.new(1, 0, 0, 56),
		Position = UDim2.fromOffset(0, 136),
		BackgroundColor3 = Theme.Panel,
		BorderSizePixel = 0,
	}, Right_Column)
	Apply_Corner(Info_Panel, 6)
	Apply_Stroke(Info_Panel, Theme.Border, 1)

	Create_Instance("TextLabel", {
		Name = "Expires_Key",
		Size = UDim2.new(0.5, -12, 0, 20),
		Position = UDim2.fromOffset(12, 8),
		BackgroundTransparency = 1,
		Text = "Expires:",
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextColor3 = Theme.Text_Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, Info_Panel)

	Create_Instance("TextLabel", {
		Name = "Expires_Value",
		Size = UDim2.new(0.5, -12, 0, 20),
		Position = UDim2.new(0.5, 0, 0, 8),
		BackgroundTransparency = 1,
		Text = Expires,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.Text_Muted,
		TextXAlignment = Enum.TextXAlignment.Right,
	}, Info_Panel)

	Create_Instance("TextLabel", {
		Name = "Update_Key",
		Size = UDim2.new(0.5, -12, 0, 20),
		Position = UDim2.fromOffset(12, 28),
		BackgroundTransparency = 1,
		Text = "Last update:",
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextColor3 = Theme.Text_Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, Info_Panel)

	Create_Instance("TextLabel", {
		Name = "Update_Value",
		Size = UDim2.new(0.5, -12, 0, 20),
		Position = UDim2.new(0.5, 0, 0, 28),
		BackgroundTransparency = 1,
		Text = Last_Update,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.Text_Muted,
		TextXAlignment = Enum.TextXAlignment.Right,
	}, Info_Panel)

	local Buttons_Row = Create_Instance("Frame", {
		Name = "Buttons_Row",
		Size = UDim2.new(1, 0, 0, 35),
		Position = UDim2.new(0, 0, 1, -35),
		BackgroundTransparency = 1,
	}, Right_Column)

	local Exit_Button = Create_Instance("TextButton", {
		Name = "Exit_Button",
		Size = UDim2.new(0.5, -5, 1, 0),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = Theme.Button_Exit,
		Text = "Exit",
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = Theme.Text_Muted,
		AutoButtonColor = false,
		BorderSizePixel = 0,
	}, Buttons_Row)
	Apply_Corner(Exit_Button, 5)
	Apply_Stroke(Exit_Button, Theme.Border, 1)

	local Load_Button = Create_Instance("TextButton", {
		Name = "Load_Button",
		Size = UDim2.new(0.5, -5, 1, 0),
		Position = UDim2.new(0.5, 5, 0, 0),
		BackgroundColor3 = Theme.Button_Load,
		Text = "Load",
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = Theme.Text_Primary,
		AutoButtonColor = false,
		BorderSizePixel = 0,
	}, Buttons_Row)
	Apply_Corner(Load_Button, 5)
	Apply_Stroke(Load_Button, Theme.Border, 1)

	local Window = {}
	local Products = {}
	local Card_Refs = {}
	local Selected_Index = nil
	local Fast_Tween = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function Select_Product(Index)
		local Product = Products[Index]
		if not Product or Product.Status == "Offline" then
			return
		end

		Selected_Index = Index
		Selected_Title.Text = Product.Name
		Changelog_Text.Text = Product.Changelog or ""

		for Item_Index, Ref in ipairs(Card_Refs) do
			local Is_Selected = (Item_Index == Index)
			TweenService:Create(Ref.Accent_Bar, Fast_Tween, {
				BackgroundTransparency = Is_Selected and 0 or 1,
			}):Play()
			TweenService:Create(Ref.Card_Button, Fast_Tween, {
				BackgroundColor3 = Is_Selected and Theme.Card or Theme.Panel,
			}):Play()
			TweenService:Create(Ref.Card_Stroke, Fast_Tween, {
				Color = Is_Selected and Color3.fromRGB(52, 52, 64) or Theme.Border,
			}):Play()
		end
	end

	function Window:AddProduct(Product)
		local Index = #Products + 1
		Products[Index] = Product
		Products_Count.Text = "Products: " .. tostring(#Products)

		local Card_Button = Create_Instance("TextButton", {
			Name = "Product_" .. tostring(Index),
			Size = UDim2.new(1, 0, 0, 56),
			BackgroundColor3 = Theme.Panel,
			Text = "",
			AutoButtonColor = false,
			BorderSizePixel = 0,
			LayoutOrder = Index,
		}, Products_Scroll)
		Apply_Corner(Card_Button, 5)
		local Card_Stroke = Apply_Stroke(Card_Button, Theme.Border, 1)

		local Accent_Bar = Create_Instance("Frame", {
			Name = "Accent_Bar",
			Size = UDim2.new(0, 2, 0, 26),
			Position = UDim2.new(0, 8, 0.5, -13),
			BackgroundColor3 = Theme.Accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, Card_Button)
		Apply_Corner(Accent_Bar, 2)

		Create_Instance("TextLabel", {
			Name = "Name_Label",
			Size = UDim2.new(1, -26, 0, 18),
			Position = UDim2.fromOffset(18, 9),
			BackgroundTransparency = 1,
			Text = Product.Name or "Product",
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextColor3 = Theme.Text_Primary,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, Card_Button)

		local Status_Text = Product.Status or "Offline"
		local Status_Hex = Status_Text == "Online" and "#57B866" or "#D94B4B"
		Create_Instance("TextLabel", {
			Name = "Status_Label",
			Size = UDim2.new(0.55, -18, 0, 16),
			Position = UDim2.fromOffset(18, 30),
			BackgroundTransparency = 1,
			RichText = true,
			Text = string.format('Status: <font color="%s">%s</font>', Status_Hex, Status_Text),
			Font = Enum.Font.GothamMedium,
			TextSize = 11,
			TextColor3 = Theme.Text_Muted,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, Card_Button)

		Create_Instance("TextLabel", {
			Name = "Version_Label",
			Size = UDim2.new(0.45, -10, 0, 16),
			Position = UDim2.new(0.55, 0, 0, 30),
			BackgroundTransparency = 1,
			Text = "Version: " .. (Product.Version or "?"),
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextColor3 = Theme.Text_Muted,
			TextXAlignment = Enum.TextXAlignment.Right,
		}, Card_Button)

		Card_Refs[Index] = {
			Card_Button = Card_Button,
			Accent_Bar = Accent_Bar,
			Card_Stroke = Card_Stroke,
		}

		local Is_Offline = (Status_Text == "Offline")
		if Is_Offline then
			Card_Button.BackgroundTransparency = 0.45
			Card_Button.Active = false
		end

		Card_Button.MouseEnter:Connect(function()
			if not Is_Offline and Selected_Index ~= Index then
				TweenService:Create(Card_Button, Fast_Tween, { BackgroundColor3 = Theme.Card_Hover }):Play()
			end
		end)

		Card_Button.MouseLeave:Connect(function()
			if not Is_Offline and Selected_Index ~= Index then
				TweenService:Create(Card_Button, Fast_Tween, { BackgroundColor3 = Theme.Panel }):Play()
			end
		end)

		Card_Button.MouseButton1Click:Connect(function()
			if not Is_Offline then
				Select_Product(Index)
			end
		end)

		if not Selected_Index and not Is_Offline then
			Select_Product(Index)
		end
	end

	function Window:Destroy()
		if Screen_Gui then
			Screen_Gui:Destroy()
		end
	end

	Exit_Button.MouseEnter:Connect(function()
		TweenService:Create(Exit_Button, Fast_Tween, {
			BackgroundColor3 = Theme.Button_Hover,
			TextColor3 = Theme.Text_Primary,
		}):Play()
	end)

	Exit_Button.MouseLeave:Connect(function()
		TweenService:Create(Exit_Button, Fast_Tween, {
			BackgroundColor3 = Theme.Button_Exit,
			TextColor3 = Theme.Text_Muted,
		}):Play()
	end)

	Exit_Button.MouseButton1Click:Connect(function()
		Window:Destroy()
	end)

	Load_Button.MouseEnter:Connect(function()
		TweenService:Create(Load_Button, Fast_Tween, {
			BackgroundColor3 = Theme.Button_Hover,
		}):Play()
	end)

	Load_Button.MouseLeave:Connect(function()
		TweenService:Create(Load_Button, Fast_Tween, {
			BackgroundColor3 = Theme.Button_Load,
		}):Play()
	end)

	Load_Button.MouseButton1Click:Connect(function()
		local Selected_Product = Selected_Index and Products[Selected_Index]
		if Selected_Product and Selected_Product.Status ~= "Offline" and type(On_Load) == "function" then
			On_Load(Selected_Product, Window)
		end
	end)

	local Dragging = false
	local Drag_Start = nil
	local Start_Position = nil

	Header_Frame.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			Drag_Start = Input.Position
			Start_Position = Main_Frame.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
			local Delta = Input.Position - Drag_Start
			Main_Frame.Position = UDim2.new(
				Start_Position.X.Scale,
				Start_Position.X.Offset + Delta.X,
				Start_Position.Y.Scale,
				Start_Position.Y.Offset + Delta.Y
			)
		end
	end)

	return Window
end

getgenv().LoaderLibrary = LoaderLibrary
return LoaderLibrary
