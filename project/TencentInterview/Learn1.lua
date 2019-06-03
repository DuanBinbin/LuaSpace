-- 元类
A = {name = "Default A",age = 0}

-- 基础类方法 new
function A:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  name = name or "Default A"
  age = age or 0
  return o
end

-- 基础类方法 printArea
function A:foo ()
  print("fromA "..self.name..self.age)
end

-- 创建对象
local a = A:new()
a.name = "hanmeimei"
a.age = 17
a:foo()