
local function add(x)
	x = x + 1;
end
local function table_add(t)
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
	
	local widget = {{name = "ImageButton", priority = 3}, {name = "TextButton", priority = 2}, {name = "ScrollView", priority = 1}};
	local function sortPrority(n1, n2)
		return n1.priority < n2.priority;
	end
	table.sort(widget, sortPrority);
	print(widget[1].name)
	
	local result = 1;
	add(result);
	print(result); -- 1
	
	local t = {x = 10};
	table_add(t);
	print(t.x); -- 11
	
	local skill = {{"one"}, "two", "three"};
	local s1 = skill[1];
	local s2 = skill[2];
	skill[1] = s2;
	print(s1);
end
main()