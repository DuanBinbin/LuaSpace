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
 
