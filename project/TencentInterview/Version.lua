function m_class(...)
    -- TODO
    local local_table = ...
    local super = local_table.__super

    function local_table:new(...)
        local tempA = {}
        local Item = {}
        setmetatable(tempA,{__index = function(t,k)
            if Item[k] == nil then
                if type(local_table[k]) == "function" then
                    local fun = local_table[k]
                    Item[k] = function (...)
                        fun(Item,...)
                    end
                else
                    Item[k] = local_table[k]
                end
            end
            return Item[k]
        end,
        __newindex = function(ta, k, v)
            if type(Item[k]) == "function" then
                print("函数不能赋值")
                return
            end
            if Item[k] ~= nil and type(Item[k]) ~= type(v) then--type(temp[k]) ~= "nil" and
                print("类型不匹配：",k, "的类型是", type(Item[k]))
                return
            end
            Item[k] = v
        end})
        return tempA
    end

    if super then
        setmetatable(local_table,{__index = super})
    else
        setmetatable(local_table,{__index = local_table})
    end
    
    return local_table
end

-- 实现 class 方法
A = m_class{
    name = "string",
    age = 0,
    foo = function ( self )
        print("from A"..self.name..tostring(self.age))
    end,
}

B = m_class{
    __super = A,
    foo = function( self )
        print("from B"..self.name..tostring(self.age))
    end,
}
    
local a = A:new()
a.name = "hanmeimei"
a.age = 17
a:foo()

local b = B:new()
b.name = "lilei"
b.age = 18
b:foo()

a.name = 20
a.age = "20"
b.foo = "x"

-- 输出

-- from Ahanmeimei17
-- from Blilei18
-- 类型不匹配：name 的类型是 string
-- 类型不匹配：age 的类型是 number
-- 函数不能赋值