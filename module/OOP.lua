local table1 = {a = 1, b = 2}
local table2 = {a = 2, b = 3}
local table3 = table1

if table1 == table2 then 
    print("table1 == table2")
else
    print("table1 ~= table2")
end

table3.a = 3
print(table1.a)