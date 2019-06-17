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
        "[^&(%" .. reps .. "%)]+", --"[^%" .. reps .. "]+",
        function(w)
            table.insert(resultStrList, tonumber(w))
        end
    )
    return resultStrList
end

resValue = nil

--第一步：数据格式化，去除空
inputParams = string.gsub(inputParams,"%s","%1")

--第二步：计算()一级运算符
function getParenthesis(params)
    --判断是否存在()
    local isContinue = string.find(params, "%b()") 
    if not isContinue then
        resValue = params
        return
    end
    -- 处理值
    --获取:(33 + 44)
    local testStr1 = string.match(params,"%b()")
    --获取()中的操作符
    local operator = checkSpecialChar(testStr1)
    --获取()中的数字
    local table = split(testStr1,operator)
    --计算
    local res = calculate(operator,table[1],table[2])

    --将计算结果替换为计算内容
    local params = string.gsub(params, "%b()", res, 1)

    --递归
    getParenthesis(params)
end
getParenthesis(inputParams)
--获取小括号
resValue = string.gsub(resValue,"%s","")
print("三级降为二级",resValue)

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

-- printTable(numberTable)
-- printTable(operatorTable)

--******************** END :分离数据和运算符	********************

--******************** START : * / 二级运算	********************
function operateMultiply()
    local i,j 
    if string.find(resValue,"%.") then
        i,j = string.match(resValue, '([0-9]*%.[0-9]*)%*([+-]?%d+)') --([0-9]*%.[0-9]*)
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
    -- print("----k : " .. i .. ", value : " .. type(v) .. " " .. v)
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

for i, v in ipairs(operatorTableThree) do
    -- print("----k : " .. i .. ", value : " .. type(v) .. " " .. v)
    if v == "+" then
        -- print("计算加法")
    elseif v == "-" then
        resValue = operateSubtract()
    end
    resValue = operateSubtract()
end

print("输出计算结果：", resValue)