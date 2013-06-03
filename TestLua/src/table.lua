require "PrintUtils"
function clear(t) --清空表
	if t then
		for k,v in ipairs(t) do
			t[k] = nil
		end
	end
end
local function main()

	local t = {x = 10, y = 20};
	t.z = 30;
	print_table(t);
	print_index_table(t);--这个没有任何输出
	t = {100, 200, 300, 400, 500}; --默认下标, 相当于t = {1 = 100, 2 = 200, 3 = 300, 4 = 400, 5 = 500};
	table.insert(t, 6, 600);
	print_index_table(t);
	print(table.concat(t,"|",1,6));
	local a, b = unpack(t, 1, 2) --unpack(list, i, j)相当于是return list[i], list[i+1], ..., list[j]
	print("a:" .. a, "b:" .. b)
	
	--可见table.getn和#table的作用是一样的,而且只对连续下表的table有效,而table.maxn是获取最大下标,不一定连续
	local data = {x=10, y=45; "one", "two", "three"};
	print("x = " .. data.x);
	print("x = " .. data["x"]);
	print(data[1]);
	print("data:table.getn = " .. table.getn(data), "data:#= " .. #data, "data:table.maxn = " .. table.maxn(data))
	
	local arr = {}
	arr[1] = "a"
	arr[2] = "b"
	arr[8] = "c"
	print("arr:table.getn = " .. table.getn(arr), "arr:#= " .. #arr, "arr:table.maxn = " .. table.maxn(arr))
	print_table(arr)       -- 能打印不连续下标的值
	print_index_table(arr) -- 不能打印不连续下标的值
	
	local t1 = {1, 2, 3};
	print("num:=" .. table.getn(t1)); -- num:=3
	print("num:=" .. #t1); -- num:=3
	
	
	local w1 = {name = "Tom" , age = "24"};
	local w2 = {name = "Tom" , age = "24"};
	if w1 == w2 then
		print("table both");
	else 
		print("table not both"); -- table not both
	end
	local a1 = "s"
	local a2 = "s"
	if a1 == a2 then
		print("String both") -- String both
	else 
		print("String not both")
	end
	local test = {"Tom", "LiLei"}
	print_table(test)
	clear(test)
	print_table(test) --清空了，没有输出了
	
	
end
main()
