-- 元类
A = {name = "Default A",age = 0}

-- 基础类方法 new
function A:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- 基础类方法 printArea
function A:foo ()
  print("from A"..self.name..self.age)
end

-- 创建对象
local a = A:new()
a.name = "hanmeimei"
a.age = 17
a:foo()

B = A:new()
function B:new( o )
  o = o or A:new(o)
  setmetatable(o,self)
  self.__index = self
  return o
end

function B:foo(  )
  print("from B"..self.name..self.age)
end

local b = B:new()
b.name = "lilei"
b.age = 18
b:foo()