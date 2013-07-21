
function add(x)
	x = x + 1;
end
function table_add(t)
	t.x = t.x + 1;
end
local function main()
	-- 根据成绩从高到低对学生排序
	local names = {"Peter", "Paul", "Mary"}
	local grades = {Mary = 10, Paul = 7, Peter = 8}
	table.sort(names, function (n1, n2)
    	return grades[n1] > grades[n2]    -- compare the grades
	end)
	print(names[1]);
	
	local widget = {{name = "ImageButton", priority = 1}, {name = "TextButton", priority = 2}, {name = "ScrollView", priority = 3}};
	local function sortPrority(n1, n2)
		return widget[n1].priority < widget[n2].priority
	end
	table.sort(widget, sortPrority);

	
	local result = 1; 
	add(result);	--值传递
	print(result); -- 1  
	
	local t = {x = 10};
	table_add(t);	--引用传递
	print(t.x); -- 11
end
main()