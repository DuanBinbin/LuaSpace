--lua中的字符串不可变的;lua中能够操作100K或者1M的字符串
local inputParams = "80 + 22 * (33 - 44) / 55 * (15 + 78)"

--自定义函数操作类型
function add(x, y)
    return x + y
end

function subtract(x, y)
    return x - y
end

function multiply(x, y)
    return x * y
end

function divide(x, y)
    return x / y
end

--根据算数运算符进行运算
function calculate(operator, x, y)
    if operator == "+" then
        return add(x, y)
    elseif operator == "-" then
        return subtract(x, y)
    elseif operator == "*" then
        return multiply(x, y)
    elseif operator == "/" then
        return divide(x, y)
    end
end

function calcultor(params)
    local temp = string.gsub(params, "%s+", "")
    for i = 1, string.len(temp) do
        print(string.sub(temp, i, i))
    end
end

--首位去除空格
function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

--检查是否存在特殊字符并返回该特殊字符：+ - * /,备注：没有特殊符号的时候如何处理
function checkSpecialChar(params)
    if string.find(params, "%+") then
        return "+"
    elseif string.find(params, "%-") then
        return "-"
    elseif string.find(params, "%*") then
        return "*"
    elseif string.find(params, "%/") then
        return "/"
    else
        return nil
    end
end

--分割字符串
function split(str, reps)
    local resultStrList = {}
    string.gsub(
        str,
        "[^%" .. reps .. "]+",
        function(w)
            table.insert(resultStrList, tonumber(w))
        end
    )
    return resultStrList
end

--只能计算 1 * 2这种类型，如果是1 * 2 + 3 就计算不了了
function getParenthesisValue(params)
    --获取操作类型
    local operator = checkSpecialChar(params)
    --获取()v中的值，存在在表中
    t = split(params, operator)
    --计算
    print("operator : " .. operator .. "; value = " .. t[1] .. ", " .. t[2])
    return calculate(operator, t[1], t[2])
end

resValue = nil

--获取运算符( )
function getParenthesis(params)

    local i, j
    local t = {}
    i = string.find(params, "%(")
    j = string.find(params, "%)")
    if not i then
        resValue = params
        return
    end
    --获取()中的内容
    local p = string.sub(params, i + 1, j - 1)

    --计算()中的内容
    local res = getParenthesisValue(p)

    local p1 = string.sub(params, i, j)

    --将计算结果替换为计算内容
    local params = string.gsub(params, "%b()", res, 1)

    getParenthesis(params)

    --记录()中的结果
    -- table.insert(t,res)
end
getParenthesis(inputParams)
--获取小括号
resValue = string.gsub(resValue,"%s","")
print("三级降为二级",resValue)

--********************至此，三级计算降为二级计算 80 + 22 * -11 / 55 * 93	********************
--知识点：string常用API，lua中的正则表达式

--******************** 分离数据和运算符	********************
local numberTable = {}
--用来替换负数
local tempTable
for w in string.gmatch(resValue, "[+-]?%d+") do --注意：%a表示单个字母，%a+表示多个字母;[+-]?%d+,在一段文本内查找一个整数，整数可能带有正负号    
    -- 接 
    local temp = tonumber(w)
    if temp < 0 then
        tempTable = string.gsub(resValue,w,"a",1)
    end
    table.insert(numberTable, temp)
end

--输出Table中的值
function  printTable( t )
    print(t)
    for i, v in ipairs(t) do
        print("k : " .. i .. ", value : " .. type(v) .. " " .. v)
    end
end

-- 操作字符 --[^%d]
local operatorTable = {}
for w in string.gmatch(tempTable, "[%+%-%*%/]") do --注意：%a表示单个字母，%a+表示多个字母;[+-]?%d+,在一段文本内查找一个整数，整数可能带有正负号
    table.insert(operatorTable,w)
end

printTable(numberTable)
printTable(operatorTable)

--******************** END :分离数据和运算符	********************

--******************** START : 分离二级运算符	********************

resValue = string.gsub(resValue,"%s","")
print(resValue)

--[[ ([0-9]*%.[0-9]*),表示小数 ；([+-]?%d+)%*([+-]?%d+) ]]

function operateMultiply()
    local i,j 
    if string.find(resValue,"%.") then
        i,j = string.match(resValue, '([0-9]*%.[0-9]*)%*([+-]?%d+)')
    else 
        i,j = string.match(resValue, '([+-]?%d+)%*([+-]?%d+)')
    end
    local multiplyValue = multiply(i,j)
    local pattern = tonumber(i).."*"..tonumber(j)
    if string.find(resValue,"%.") then
        return string.gsub(resValue,'([0-9]*%.[0-9]*)%*([+-]?%d+)',multiplyValue,1)
    else 
        return string.gsub(resValue,'([+-]?%d+)%*([+-]?%d+)',multiplyValue,1)
    end
          
end

function operateDivide()
    local i,j 

    if string.find(resValue,"%.") then
        i,j = string.match(resValue, '([0-9]*%.[0-9]*)%/([+-]?%d+)')
    else 
        i,j = string.match(resValue, '([+-]?%d+)%/([+-]?%d+)')
    end
        
    local multiplyValue = divide(i,j)
    local pattern = tonumber(i).."/"..tonumber(j)
    return string.gsub(resValue,'([+-]?%d+)%/([+-]?%d+)',multiplyValue,1)      
end

local operatorTableThree = {}
for i, v in ipairs(operatorTable) do
    print("----k : " .. i .. ", value : " .. type(v) .. " " .. v)
    if v == "+" or v == "-" then
        table.insert( operatorTableThree,v )
    elseif v == "*" then
        resValue = operateMultiply()        
    elseif v == "/" then
        resValue = operateDivide()
    end
    print(resValue)
end

function operateSubtract()
    local i,j 
    if string.find(resValue,"%.") then
        i,j = string.match(resValue, '([+-]?%d+)%-([0-9]*%.[0-9]*)')
    else 
        i,j = string.match(resValue, '([+-]?%d+)%-([+-]?%d+)')
    end
    local multiplyValue = subtract(i,j)
    local pattern = tonumber(i).."-"..tonumber(j)
    if string.find(resValue,"%.") then
        return string.gsub(resValue,'([+-]?%d+)%-([0-9]*%.[0-9]*)',multiplyValue,1)
    else 
        return string.gsub(resValue,'([+-]?%d+)%-([+-]?%d+)',multiplyValue,1)
    end          
end

printTable(operatorTableThree)
for i, v in ipairs(operatorTableThree) do
    print("----k : " .. i .. ", value : " .. type(v) .. " " .. v)

    if v == "+" then
        print("计算加法")
    elseif v == "-" then
        resValue = operateSubtract()
    end
    resValue = operateSubtract()
    print(resValue)
end