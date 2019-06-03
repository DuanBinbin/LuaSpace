local t = {} --原来的table

local _t = t -- 保持对原table的一个引用

t = {} -- 创建代理

-- 创建元表
local mt = {
    __index = function (t, k)
        print("access to element " .. tostring(k))
        return _t[k]
    end,

    __newindex = function (t, k, v)
        print("update of element " .. tostring(k))
        _t[k] = v
    end
}

setmetatable(t, mt)

t.x = 10 -- update of element x
print(t.x) -- access to element x

