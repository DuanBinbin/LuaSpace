function  setDefault( tb,defaultValue )
    local mt = {__index = function () return defaultValue end}
    setmetatable(tb,mt)
end

local t1 = {x = 10,y = 20}
print(t1.x,t1.z)

setDefault(t1,100)

print(t1.x,t1.z)