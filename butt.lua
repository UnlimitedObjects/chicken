Key = ""

--// Utilities
local Bytecode = ""

local Cancel = function(...)
    while true do
        coroutine.yield(warn("AuthPro |", ...))
    end
end

--> Missing Functions
local getrenv = getrenv or Cancel("Missing Function | getrenv")
local getgenv = getgenv or Cancel("Missing Function | getgenv")

--> Secure Environment
local OriginalEnv = getfenv()
local Globals = {table.unpack(getrenv()), table.unpack(getgenv())}
local _ENV = setmetatable({}, {
    __index = function(_, Index)
        Bytecode ..= `{Index}`

        return Globals[Index]
    end
})

setfenv(0, _ENV)
setfenv(1, _ENV)

--> UI Control
local UI = {}

local CoreGui = game:GetService("CoreGui")

local AuthProUI = Instance.new("ScreenGui")
AuthProUI.Parent = CoreGui
AuthProUI.Name = "AuthPro"
AuthProUI.IgnoreGuiInset = true
AuthProUI.ResetOnSpawn = false
AuthProUI.ZIndexBehavior = Enum.ZIndexBehavior.Global

local Container = Instance.new("Frame")
Container.Parent = AuthProUI
Container.Name = "Container"
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(1, -230, 1, -540)
Container.Size = UDim2.new(0, 230, 0, 529)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.Padding = UDim.new(0.01, 0)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

UI.Success = function(Message)
    local Success = Instance.new("Frame")
    Success.Parent = Container
    Success.Name = "Success"
    Success.BackgroundTransparency = 1
    Success.Size = UDim2.new(1, 0, 0.12, 0)

    local Holder = Instance.new("Frame")
    Holder.Parent = Success
    Holder.Name = "Holder"
    Holder.BackgroundColor3 = Color3.new(0.368627, 0.72549, 0.411765)
    Holder.Position = UDim2.new(0, 0, 0, 0)
    Holder.Size = UDim2.new(1, 0, 1, 0)

    local Title = Instance.new("TextLabel")
    Title.Parent = Holder
    Title.Name = "Title"
    Title.Text = "AuthPro | Success"
    Title.TextScaled = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.04, 0, 0.1, 0)
    Title.Size = UDim2.new(0.95, 0, 0.4, 0)
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

    local Description = Instance.new("TextLabel")
    Description.Parent = Holder
    Description.Name = "Description"
    Description.Text = Message
    Description.TextScaled = true
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0.04, 0, 0.52, 0)
    Description.Size = UDim2.new(0.95, 0, 0.25, 0)
    Description.TextColor3 = Color3.new(1, 1, 1)
    Description.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = Holder
    UICorner.CornerRadius = UDim.new(0.2, 0)

    local Fix = Instance.new("Frame")
    Fix.Parent = Holder
    Fix.Name = "Fix"
    Fix.Position = UDim2.new(0.5, 0, 0, 0)
    Fix.Size = UDim2.new(0.5, 0, 1, 0)
    Fix.ZIndex = 0
    Fix.BackgroundColor3 = Color3.new(0.368627, 0.72549, 0.411765)
end

UI.Success("Test message")
