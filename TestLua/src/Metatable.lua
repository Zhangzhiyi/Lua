require "PrintUtils"
c = {name = "zhangzhiyi", age = 24};
c.__add = function (op1, op2)
	for _, item in ipairs(op2) do
		table.insert(op1,item);
	end
	return op1;
end
local function main()
	local a = {5, 6};
	local b = {7, 8};
	local metable = getmetatable(a) --获取元方法  
	--print_table(getmetatable(a));  --报错 a的metatable为空
	--print_table(getmetatable(c));  --报错 c的metatable为空
	setmetatable(a,c);  --如果在a寻找到__add元方法，就进行操作，否则继续在b中寻找
	print_table(getmetatable(a));  --__add	function: 000000000985A780  age	24  name zhangzhiyi
	c.__index = c;  --等价于 c.__index = function(c, key) return c[key] end
	--print_table(getmetatable(c));  --报错 报错 c的metatable为空
	print(a.name); -- zhangzhiyi
	--setmetatable(b,c);
	print_table(getmetatable(a));
	a[3] = 66
	local d = a + b;
	print_table(d);
	
	local proto = {x = 0, y = 0, width = 100, height = 101};
	local metatable = {};
	metatable.__index = function(table, key) 
		return proto[key] 
	end;
	--metatable.__index = proto; 与上面等价   __index 可以是function 或者 table
	local cmd = {x = 1000};
	local cmd2 = setmetatable(cmd, metatable);
	print(cmd.x);   -- 1000   查找cmd是否有x的键值，有则返回
	print(cmd.y);	-- 0     查找cmd是否有y的键值，没有则去搜索metatable的__index
end
main()

--[[ 
Lua中的metatable 类似于C++中的虚函数，当索引table中的项不存在时，会进一步索引metetable（如果设置了的话）是否存在该项。这跟虚函数概念
我们叫 metatable 中的键名为 事件 (event) ，把其中的值叫作 元方法 (metamethod)。 在上个例子中，事件是 "add" 而元方法就是那个执行加法操作的函数。
一个 metatable 可以控制一个对象做数学运算操作、比较操作、连接操作、取长度操作、取下标操作时的行为， metatable 中还可以定义一个函数，让 userdata
 作垃圾收集时调用它。 对于这些操作，Lua 都将其关联上一个被称作事件的指定健。 当 Lua 需要对一个值发起这些操作中的一个时， 它会去检查值中 metatable 
 中是否有对应事件。 如果有的话，键名对应的值（元方法）将控制 Lua 怎样做这个操作。
metatable 可以控制的操作已在下面列出来。 每个操作都用相应的名字区分。 每个操作的键名都是用操作名字加上两个下划线 '__' 前缀的字符串； 举例来说，
"add" 操作的键名就是字符串 "__add"。 这些操作的语义用一个 Lua 函数来描述解释器如何执行更为恰当。
--]]