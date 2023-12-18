--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

--// Variables
local HANDSHAKE_REMOTE = ReplicatedStorage:WaitForChild("Handshake")

--// Functions
local Encrypt = function(Input, Key)
    local Encrypted = {}

    for Index = 1, #Input do
        local Byte = string.byte(Input, Index)
        local KeyByte = string.byte(Key, (Index - 1) % #Key + 1)
        local EncryptedByte = bit32.bxor(Byte, KeyByte)
        
        table.insert(Encrypted, string.char(EncryptedByte))
    end
    
    return table.concat(Encrypted)
end

--> Handshake Recreation
print("Starting Handshake Recreation/Replication...")

local Count1 = 0
local Count2 = 0
local Count3 = 0

print("Grabbing Current Count Values")

for Index, Value in pairs(getgc()) do
    if type(Value) == "function" and islclosure(Value) then
        if getinfo(Value).source:find("Client") then
            local Upvalues = getupvalues(Value)

            for Index2, Value2 in pairs(Upvalues) do
                if type(Value2) == "number" then
                    Count1 = Value2
                    Count2 = Value2
                    Count3 = Value2
                end
            end
        end
    end
end

local CallbackMember = setmetatable({}, {
    __call = function(_, Input, Key)
        Count1 = Count1 + 2014141102
        Count2 = Count2 - 914796734
        Count3 = Count3 + 301929095

        local Table = {
            Count1,
            Count2,
            Count3,
            Encrypt(Input, Key),
            {
                "AntiHookmetamethod",
                "AntiHook",
                "AntiLuaHook"
            }
        }

        return Encrypt(HttpService:JSONEncode(Table), Key)
    end
})

for Index, Value in pairs(getgc(true)) do
    if type(Value) == 'table' and getmetatable(Value) and type(getmetatable(Value)) == "table" and type(rawget(getmetatable(Value), "__mode")) == "string" and rawget(getmetatable(Value), "__mode"):find("v") then
        getmetatable(Value).__mode = nil
    end
end

warn('Bypassed Anti Handshake Replication.')

for Index, Value in pairs(getgc()) do
    if type(Value) == "function" and islclosure(Value) then
        if getinfo(Value).source:find("Client") then
            hookfunction(Value, function() end)
        end
    end
end

print("Bypassed Client AC.")

HANDSHAKE_REMOTE.OnClientInvoke = CallbackMember

print('Replicated Handshake.')
