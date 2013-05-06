
function add(x)
	x = x + 1;
end
function table_add(t)
	t.x = t.x + 1;
end
local function main()
	-- 根据成绩从高到低对学生排序
	names = {"Peter", "Paul", "Mary"}
	grades = {Mary = 10, Paul = 7, Peter = 8}
	table.sort(names, function (n1, n2)
    	return grades[n1] > grades[n2]    -- compare the grades
	end)
	print(names[1]);
	
	local result = 1;
	add(result);
	print(result);
	
	local t = {x = 10};
	table_add(t);
	print(t.x);
end
main()