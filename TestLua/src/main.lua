local p = require "PrintUtils"

-- 如果以...为参数, 则表示参数的数量不定.
-- 参数将会自动存储到一个叫arg的table中.
-- arg.n中存放参数的个数. arg[]加下标就可以遍历所有的参数.
function funky_print(...)
	for i = 1 , arg.n do
		print("funky: "..arg[i]);
	end

end
local function main()
	if not (5>1) then --false和nil是假（false），其他为真，0也是true. nil只能和自己相等
		print("true");	
	else
		print("false");
	end
	
	print("Hello World!");
	local a = 5;
	local b = a + 1;
	print(b);
	
	local object = {name = "Tom", age = 24};
	print(object);
	print(object.name);
	
	print(sum(1, 1));

	local i;
	--升序
	for i = 1 , 5 do -- 注意：每次循环运行这句 i 都是nil, 实际是for i = 1 , 5,  1 do
		print("i is now "..i);
	end
	print(i); --注意：循环出来i = nil;
	--降序
	for i = 5, 1, -1  do
		print("i is now "..i);
	end
	
	for i = 1, -1 do
		print("i is now "..i);
	end
	funky_print("one", "two");
	
	--Lua是动态类型语言，变量不要类型定义。Lua中有8个基本类型分别为：nil、boolean、number、string、userdata、function、thread和table。函数type可以测试给定变量或者值的类型。
	print(type(s));
	local s = 10;
	print(type(s));
	s = "HelloWorld";
	print(type(s));
	s = print; 
	print(type(s));
	print(type(object));
	--  [[...]]表示字符串。这种形式的字符串可以包含多行也
	lineString = [[aaaa
	bbbb
	cccc]];
	print(lineString);
	--运行时，Lua会自动在string和numbers之间自动进行类型转换，当一个字符串使用算术操作符时，string就会被转成数字
	print("1" + 1);
	
	--遇到赋值语句Lua会先计算右边所有的值然后再执行赋值操作，所以我们可以这样进行交换变量的值：
	x = 1; y = 2;
	x,y = y,x;
	print("x="..x,"y="..y);
	
	-- 返回多个参数
	local e
	s, e = string.find("hello Lua users", "Lua");
	print(s, e);
	s, e = string.find("hello hello", " hel");
	print(s, e);
	
	
	local splitString = "\r\n";
	local len = string.len(splitString);
	print("len:" .. len); -- 2
	
	print(package.path);
	local flag = true;
	print(tostring(flag))
	
	local hex = 0x11 -- 十六进制
	print(hex)
	
	global = 1111 --用_G[key]访问全局变量
	local value = _G["global"]
	print(value)
	assert(value, "No this message in MessageDefine.lua!")
	
	local radian = math.atan2(1,1) --atan2求的是弧度
	print(radian)
	
	local flag2 = false
	
	if flag2 ~= nil then
		local isEnable = true
		print(isEnable)
	end
	
	--function类型数据
	local fun = function() print("function") end
	fun()
	local keyTable = {1, 2, 3};
	local funTable = {fun = "function", keyTable = "table"};  --function和table数据类型也可以当table的key
	print(funTable.fun);
	print(funTable.keyTable);
end
main()
