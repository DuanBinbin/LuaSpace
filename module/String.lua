--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{bin}
    time:2019-06-13 22:56:14
]]

print(string.find('2015-5-12 13:53', '(%d+)-(%d+)-(%d+)'))
print(string.find('(1+2)', '%(+'))

print(string.gsub('Hanazawa Kana', 'na', 'nya'))

local str = "abc(1+2-3)def"
-- local match_str = string.match(str, "%(+%d+%)+")
local match_str = string.match(str, "(+-)")
print(match_str)  -- 123

str = "<body>主干</body>"
print(string.match(str, "<body>.+</body>"))  -- <body>主干</body>
print(string.match(str, "<body>(.+)</body>"))  -- 主干

-- 常规替换
x = string.gsub("hello world", "(%w+)", "lua")
print("\n",x)

-- 都用匹配的第一个串*2来替换
x = string.gsub("hello world", "(%w+)", "%1 %1")
print("\n",x)

-- 用匹配出的完成串*2来替换第一次匹配的结果
x = string.gsub("hello world", "%w+", "%0 %0", 1)
print("\n",x)

-- 使用一个完整匹配和一个匹配的第二个串来替换
x = string.gsub("hello world from c to lua", "(%w+) (%a+)", "%0 %2")
print("\n",x)

-- 调用系统函数来替换
x = string.gsub("os = $OS, pathext = $PATHEXT", "%$(%w+)", os.getenv)
print("\n",x)

-- 调用自定义函数
 x = string.gsub("4 + 5 = $return 4+5$", "%$(.-)%$", function (s)
      return loadstring(s)()
    end)
print("\n",x)

-- 调用表来替换c
local t = {name="lua", version="5.1"}
              Sx = string.gsub("$name-$version.tar.gz", "%$(%w+)", t)
print("\n",x)

print("_______________________________________________")
local checkNil = nil

if checkNil then
    print("check true")
else
    print("check false")
end
 
