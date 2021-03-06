require "PrintUtils"
function clear(t) --清空表
	if t then
		for k,v in ipairs(t) do
			t[k] = nil
			print("clear count:=" .. #t);
		end
	end
end
function removeAll(t)
	for k, v in ipairs(t) do
		table.remove(t, k);
	end
end
local function main()
	local oa = "abc";
	local t = {x = 10, y = 20, oa = oa}; -- oa = "abc"
	t["1"] = "one";  --注意t["1"] 和 t [1] 是不同的
	print(t[1]); -- nil
	t[1] = 1;
	print(t[1]); -- 1
	print(t["1"]) -- one
	t.z = 30; -- 等同于t["z"] = 30;
	print_table(t);
	print_index_table(t);--这个没有任何输出
	t = {100, 200, 300, 400, 500}; --默认下标, 相当于t = {1 = 100, 2 = 200, 3 = 300, 4 = 400, 5 = 500};
	table.insert(t, 6, 600);
	print_index_table(t);
	table.concat(t,"|",1,6);
	print(table.concat(t,"|",1,6));
	local a, b = unpack(t, 1, 2) --unpack(list, i, j)相当于是return list[i], list[i+1], ..., list[j]
	print("a:" .. a, "b:" .. b)
	
	--可见table.getn和#table的作用是一样的,而且只对连续下表的table有效,而table.maxn是获取最大下标,不一定连续
	local data = {x=10, y=45; "one", "two", "three"};
	print("x = " .. data.x);
	print("x = " .. data["x"]);
	print(data[1]);
	print("data:table.getn = " .. table.getn(data), "data:#= " .. #data, "data:table.maxn = " .. table.maxn(data))--3, 3, 3
	
	local arr = {}
	arr[1] = "a"
	arr[2] = "b"
	arr[8] = "c"
	print_table(arr);
	print("arr:table.getn = " .. table.getn(arr), "arr:#= " .. #arr, "arr:table.maxn = " .. table.maxn(arr))--2, 2, 8
	print_table(arr)       -- 能打印不连续下标的值
	print_index_table(arr) -- 不能打印不连续下标的值
	
	local t1 = {1, 2, 3};
	print("t1 num:=" .. table.getn(t1)); -- num:=3
	print("t1 num:=" .. #t1); -- num:=3
	table.remove(t1, 2);  --注意：用remove后面的key会上移， 如果t1[2] = nil后面的key是不会上移的
	print("t1 num:=" .. #t1); -- num:=2
	table.insert(t1, 4);
	print("t1 num:=" .. #t1); -- num:=3
	
	local t2 = {1, 2, 3};
	print("t2 num:=" .. table.getn(t2)); -- num:=3
	print("t2 num:=" .. #t2); -- num:=3
	t2[2] = nil; --t1[2] = nil后面的key是不会上移的
	print("t2 num:=" .. #t2); -- num:=3 -- t[2]置nil后 t2 的个数还是不变
	print("t2 getn:=" .. table.getn(t2)); -- getn:3
	local count = 0;
	for k, v in pairs(t2) do  -- 只打印出2个元素 
		count = count + 1;
		print(k .. " " .. v);	--1 1, 3 3
	end
	print("count = " .. count)  -- 2 
	for k, v in ipairs(t2) do -- 1 1  只打印了1 1， 不能打印连续下标
		print(k .. " " .. v);
	end
	for i = 1, #t2 do -- 这种方式可以打印出3个元素, 以后建议用这个方式遍历table
		print(t2[i]); --1, nil, 3
	end
	table.insert(t2, 4);
	print("t2 num:=" .. #t2); -- num:=4   {1 = 1, 3 = 3, 4 = 4}
	
	local t3 = {1, 2, 3, 4, 5};  --测试删除后面部分键值情况
	for i = 3, #t3 do
		t3[i] = nil;
	end
	print("t3 num:=" .. table.getn(t3)); -- num:=2
	print("t3 num:=" .. #t3); -- num:=2
	
	local w1 = {name = "Tom" , age = "24"};
	local w2 = {name = "Tom" , age = "24"};
	if w1 == w2 then
		print("table both");
	else 
		print("table not both"); -- table not both (table的内存不一样)
	end
	local a1 = "s"
	local a2 = "s"
	if a1 == a2 then
		print("String both") -- String both
	else 
		print("String not both")
	end
	local testClear = {1, 2, 3, 4, 5, 6, 7}
	clear(testClear)
	print_table(testClear) --清空了，没有输出了
	print("testClear num:=" .. #testClear);
	
	local testRemoveAll = {1, 2, 3, 4, 5, 6, 7};
	removeAll(testRemoveAll);
	print_table(testRemoveAll); --没有完全清空，还有输出
	print("testClear num:=" .. #testRemoveAll);
	
	--function类型数据
	local fun = function() print("function") end
	fun()
	local keyTable = {1, 2, 3};
	local funTable = {fun = "function", keyTable = "table"};  --function和table数据类型也可以当table的key
	print(funTable.fun);
	print(funTable.keyTable);
	
	local arr = {};
	arr.index = nil;
	arr.type = nil;
	--注意：arr是没有index 和 type 的键值的
	for k, v in pairs(arr) do
		print(k);   --没有运行到此处
	end
end
main()
