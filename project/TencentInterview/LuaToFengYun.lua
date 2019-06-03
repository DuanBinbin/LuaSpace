-- 参考文档：
-- Lua的面向对象实现 https://www.cnblogs.com/pk-run/p/4248095.html

local _class = {}

function class( super )
    local class_type={}
    class_type.ctor = false --因为重载了__newindex函数，所以ctor不要定义为nil
    class_type.super = super
    class_type.new = function ( ... )
        local obj = {}
        --下面代码块只做了一件事：依次从父类到当前子类调用构造函数ctor
        do
            local create
            create = function ( c,... )
                if c.super then
                    create(c.super,...)
                end
                if c.ctor then
                    c.ctor(obj,...)
                end
            end
            create(class_type,...)
        end
        setmetatable(obj,{__index = _class[class_type]})  
        return obj  
    end

    --新加成员：防止定义类调用函数
    local vtb1 = {}
    _class[class_type] = vtb1

    setmetatable(class_type,{__newindex = 
        function ( t,k,v )
            vtb1[k] = v
        end
    })

    if super then
        setmetatable(vtb1,{__index = 
            function ( t,k )
                local ret = _class[super][k]
                vtb1[k] = ret
                return ret
            end
        })
    end

    return class_type
end