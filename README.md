# LuaSpace
三天掌握LUA



## Lua：表(table)

1.作为字典和数组；2.用于设置闭包环境、module；3.用来模拟对象和类

table作为字典时，key值可以是除了nil之外的任何类型的值。
最常见的两种类型就是整数型和字符串类型。当key为字符串时，table可以被当做结构体。同时形如 t["field"] 这种形式的写法可以简写成 t.field 这种形式。

## Lua：元表(Metatable)

**对两个table进行操作**

设置和获取元表：
setmetable(table,metatable):对指定table设置元表(metatable),如果元表(metatable)中存在_metatable键值，setmetatable会失败。
getmetatable(table):返回对象的元表(metatable)



元方法：

__index：用来对表访问，可以为 nil、table、function

` local mt = {}
mt.__index = {key = "it is key"}
t = {1,2,3}
--输出未定义的key索引，输出为nil
print(t.key)
setmetatable(t,mt)
--输出表中未定义，但元表的__index中定义的key索引时，输出__index中的key索引值"it is key"
print(t.key)
--输出表中未定义，但元表的__index中也未定义的值时，输出为nil
print(t.key2) `

__newindex：用来对表更新

当为table中一个不存在的索引赋值时，会去调用元表中的__newindex元方法



元表的使用场景

作为table的元表：通过为table设置元素可以在lua中实现面向对象编程

作为userdata的元表：通过对userdata和元表可以实现在lua中对c中的结构进行面向对象式的访问

[lua元表详解](https://www.cnblogs.com/blueberryzzz/p/8947446.html)

## Lua中面向对象编程思想

Lua中属性：table(Lua中最基本结构)
Lua中方法：function
Lua中的类：table + function
Lua中的继承:metetable

明天一早学习：******
1.元表中_index和_newindex的用法(改变错误抛出异常)
2.实现继承的集中方式

参考文档：
[脚本之家](https://www.jb51.net/list/list_245_1.htm)

[Lua Tutorial](https://www.tutorialspoint.com/lua/index.htm)

[Lua 5.3 参考手册](http://cloudwu.github.io/lua53doc/contents.html)

https://www.cnblogs.com/ring1992/p/6000929.html)

功能



# Lua中不能不清楚的知识点

## 1. for循环中pairs和ipairs的区别

使用 `ipairs` 对数组进行遍历时，只会从 1 遍历到索引中断处



2. Lua中":"和"."的区别

```Lua
--(1)冒号定义
function class:test()
　　--这里会接受self参数，比如
　　print(self.a,self.b)
　　--在这里self就是class对象本身，因此不会出错
end

--(2)点号定义
function class.test()
　　--点号定义时，默认不会接受self参数，因此在这里用self会出错，找不到全局变量self，当然如果你把self定义成了一个全局变量的话。。。那么你赢了。。
　　print(self.a,self.b)--报错，找不到全局变量self
end
```

## 2. 关于表长度的计算

```Lua
a = {}
for i=1,5 do
  a[i] = 0
end
a[8] = 0                        -- 虽然索引不连贯，但长度是以最大索引为准
print(#a)
a[100] = 0                      -- 索引不连贯，而且长度不再以最大索引为准了
print(#a)
```

结果为：

```Lua
8
8
```

使用`ipairs`对数组进行遍历是，只会从1遍历到索引中断出

```Lua
for i,v in ipairs(a) do
  print(i,v)
end
```

结果为：

```Lua
1   0
2   0
3   0
4   0
5   0
```



## 3. 关于对象的模拟

类定义的一般

```Lua
Account = {balance=100}
function Account:withdraw(v)
  self.balance = self.balance - v
end
a = Account
Account = nil

a:withdraw(10)                  -- 没问题，这个时候 self 指向的是a，因此会去寻找 a.balance
print(a.balance)
```

