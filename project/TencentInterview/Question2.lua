--lua中的字符串不可变的
--lua中能够操作100K或者1M的字符串
local inputParams = "80 + 22 * (33 - 44) / 55 * (15 + 78)"

local numberArray = {0,1,2,3,4,5,6,7,8,9}
local operatorArray = {"+","-","*","/","%","^","-"} --lua中如何区分减号和负号
local priority = {"(",")"}

--判断是否可以转化为数字
srcstr = tonumber(inputParams) 
if srcstr then
    print("可以转化为number")        
else
    print("不能转化为number")
end

function calculate( params )
    if params == nil then
        return;
    end
    local retValue = 80 + 22 * (33 - 44) / 55 * (15 + 78)    
    return retValue;
end