local sourcestr = "this is a string "
-- print("\nsourcestr is : "..sourcestr)
 
-- 使用函数拼接
local first_ret = string.rep(sourcestr, 3)
-- print("\nfirst_ret is : "..first_ret)

function calculate( params )
    if params == nil then
        return;
    end
    local retValue = 80 + 22 * (33 - 44) / 55 * (15 + 78)    
    return retValue
end

str1 = "80 + 22 * (33 - 44) / 55 * (15 + 78)"
--利用正则表达式拆分数据
-- print(string.match(str1, '[^%()]+'))
-- print("***match : "..string.match(str1, '%b()'))

str2 = "80 + 22 * -11 / 55 * 93" 
-- print("***2match : "..string.match(str1, '[%d.*%/%*%d]'))

-- print(string.gsub( str1,'%b()',"-11",1 ))
-- print(string.find( str1, '%b()'))

str1 = "He is a (8 455 + 9) good (3 + 4)!"
--利用正则表达式拆分数据
-- print(string.match(str1, '[^%()]+'))
-- print(string.match(str1, '%d+'))

for w in string.gmatch("80 + 22 * -11 / 55 * 93", '%d+') do --注意：%a表示单个字母，%a+表示多个字母
    -- print(w)    --连续输出每个单词
end

-- print(string.gsub( "ni de ming zi shi -1","-1","efg"))

-- print(string.match("abc100", "[+-]?%d+"))  -- 100
-- print(string.match("abc-100", "[+-]?%d+"))  -- -100
-- print(string.match("abc+100", "[+-]?%d+"))  -- +100

-- print(string.match("100", "^[+-]?%d+"))  -- 100
-- print(string.match("-100", "^[+-]?%d+"))  -- -100
-- print(string.match("+100", "^[+-]?%d+"))  -- +100

match = string.match("(1+2)","%b()")
if match then
    print("true")
else
    print("false")
end
print(string.match("80-4.4*93", '([0-9]*%.[0-9]*)%*([+-]?%d+)')) 

print(string.match("a (enclosed (in) parentheses) line","%b()"))