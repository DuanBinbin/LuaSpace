--lua中的字符串不可变的
--lua中能够操作100K或者1M的字符串
local inputParams = "80 + 22 * (33 - 44) / 55 * (15 + 78)"

--判断是否可以转化为数字
srcstr = tonumber(inputParams) 
if srcstr then
    print("可以转化为number")        
else
    print("不能转化为number")
end

--自定义函数操作类型
function add( x,y )
    return x + y
end

function subtract( x,y )
     return x - y
end

function  multiply( x,y )
     return x * y
end

function  divide( x,y )
    return x / y
end

--根据算数运算符进行运算
function calculate(operator,x,y)
    if operator == "+" then
        return add(x,y)
    elseif operator == "-" then
        return subtract(x,y)
    elseif operator == "*" then
        return multiply(x,y)
    elseif operator == "/" then
        return divide(x,y)
    end
end

function calcultor( params )
    local temp = string.gsub( params,"%s+","")
    for i=1,string.len( temp ) do
        print(string.sub( temp, i,i ))
    end
end

--首位去除空格
function trim (s) 
    return (string.gsub(s, "^%s*(.-)%s*$", "%1")) 
end

--检查是否存在特殊字符并返回该特殊字符：+ - * /,备注：没有特殊符号的时候如何处理
function checkSpecialChar( params )
    print("checkSpecailChar:"..type(params))
    if string.find( params , "%+" ) then
        return "+"
    elseif string.find( params , "%-" ) then
        return "-"
    elseif string.find( params , "%*" ) then
        return "*"
    elseif string.find( params , "%/" ) then
        return "/"
    else
        return nil
    end
end

--分割字符串
function split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^%'..reps..']+',function ( w )
        table.insert(resultStrList,tonumber(w))
    end)
    return resultStrList
end

--获取运算符( )
function getParenthesis(params)
    local i,j
    local t = {}
    i = string.find(params,"%(")
    j = string.find(params,"%)")
    if not i then    
        return
    end
    local p = string.sub(params,i + 1,j - 1)  
    print(checkSpecialChar(p)  ) 

    --获取操作类型
    local operator = checkSpecialChar(p)
    print("operator : "..operator)

    --获取()v中的值，存在在表中
    t1 = split(p,operator)

    local res = calculate(operator,t1[1],t1[2])
    
    print("-----"..t1[1],t1[2].." ".. res)

    table.insert(t,res)    
end

str1 = "He is a (8 + 9) good (3 + 4)!"
demo = "80+22*(33-44)/55*(15+78)..."
--获取小括号
getParenthesis(demo)

-- for k,v in pairs(t1) do
--     print(k,type(v))
-- end

--用来格式化字符串
print(string.format("i want %d apples", 5))

s = "80+22*(33-44)/55*(15+78)..."
-- s = "hello world from Lua"
--利用正则表达式拆分数据
unknown = string.gmatch(s, '[^%()]+')
print(unknown) 
for w in string.gmatch(s, '[^%()]+') do --注意：%a表示单个字母，%a+表示多个字母
    print(w)    --连续输出每个单词
end

--第一步，获取所以数字
--第二步，获取操作符