local inputParams = "80 + 22 * (33 - 44) / 55 * (15 + 78)"

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

print(calculate(inputParams)) 