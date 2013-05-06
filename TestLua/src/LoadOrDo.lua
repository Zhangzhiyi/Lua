

local function main()
--	loadfile与loadstring
--	将文件或字符串编译为一个函数并返回该函数。
--	dofile实际是调用了loadfile，执行编译后的函数。
--	loadstring总是在全局环境中编译，也就是在全局环境中查找其中的变量。
--	i = 5
--	local i = 8
--	loadstring("print(i)")() --5
--	
--	Lua将所有独立的代码块视为一个匿名函数的函数体，并且该函数具有变长参数。
--	如 loadstring("a=1") 相当于 function(...) a=1 end
--	f = loadstring("print(...)")
--	f(5)

	local ls = loadstring("print(...)");
	ls(5)
	ls = loadstring("var = 10")
	ls()
	print(var)
	--loadfile("foo.lua") --生成了一个匿名函数 function() a="aa"; local b="bb"; print "cc" end
	loadfile("D:/git/cocos2dx-demo-of-zzy/TestLua/src/foo.lua")
	
	--执行脚本
	--dofile("D:/git/cocos2dx-demo-of-zzy/TestLua/src/foo.lua")
end
main()