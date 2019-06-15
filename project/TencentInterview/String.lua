--用来格式化字符串
print(string.format("i want %d apples", 5))
--返回字符串的内部数字编码，i、j为字符串的索引，i、j限定了多少字符就返回多少值

print(string.byte("abcdef",1,3))
-- 跟byte()相反，把数字编码转换为字符串

print(string.char(97,98,99))
-- 用来查找匹配的pattern，返回该pattern的索引。找到一个匹配就返回。如果找不到，返回空

str1 = "He is a (1 + 2) good (3 + 4)!"
--string.gsub 用来进行数字替换，并且返回替换完毕的字符串和替换字数
--字符串
print(string.gsub("i have an (3 - 4) apple", "(3 - 4)", "peach"))
--函数
function ff( arg )
    print("function arg : " .. arg)
end
print(string.gsub("my name is qsk", "%a+",ff))
--table
t = {}
metat = {}
metat.__index = function ( table,key )        
    return "!!" .. key
end
setmetatable(t, metat)
print(string.gsub("my name is qsk", "%a+", t))

--去除收尾空格
local function trim (s) 
    return (string.gsub(s, "^%s*(.-)%s*$", "%1")) 
end

print(trim(" aaa "))


--Lua中特殊字符：( ) . % + - * ? [ ^ $
--`%′用作特殊字符的转义字符，因此 '%.' 匹配点; '%%'匹配字符 `%′ .转义字符`%′不仅可以用来转义特殊字符，还可以用于所有的非字母的字符
--
function split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^%'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end

print(split("abcdef","f"))

demo = "80+22*(33-44)/55*(15+78)..."

t1 = split(demo,"+")

for k,v in pairs(t1) do
    print(k,v)
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

print(string.split("abcdaefg","d")) 
t2 = string.split("abcd(ae)fg","(")
for k,v in pairs(t2) do
    print(k,v)
end

print(string.match('2015-5-12 13:53', '(%d+)-(%d+)-(%d+)')) 
str3 = string.gsub("80 + 22 * -11 / 55 * 93	","%s","")
print(str3)
i,j =  string.match(str3, '([+-]?%d+)%*([+-]?%d+)')
print(tonumber(i),tonumber(j))


-- operatorTableTwo = {}
-- for i, v in ipairs(operatorTable) do    
--     if v == "*" or v == "/" then
--         print("operatorTabale".."k : " .. i .. ", value : " .. type(v) .. " " .. v)
--         -- mytable[3] = "/"
--         operatorTableTwo[i] = v
--     end
-- end

print(string.find("你的名字 love you 3333.333", "[0-9]+%.*[0-9]*"))
