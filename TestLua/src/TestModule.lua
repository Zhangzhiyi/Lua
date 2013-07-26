--测试Lua的模块

require("module")
require("module2")

local function main()
	
	print("---------module----------")
	print(mymodule.x); -- nil,私有无法访问
	mymodule.bar()
	--mymodule.baz()   baz()是私有函数，访问不了
	mymodule.module2()  --module2  由于module和module2的键值一样，还是可以访问的
	print(mymodule.mo); --mo是在bar()函数定义的，也是加到mymodule里面去了
	print(mymodule.key);
	print("---------require----------")
	local isLoader = package.loaded["require"]; --判断文件是否已经加载,如果为nil就是没有加载
	print(isLoader);
	local req = require("require");
	local isLoader = package.loaded["require"]; --返回require文件的返回值, 如果文件没有返回值，就直接会返回true
	print(isLoader); -- 输出table 
	req.bar()
	req.setX(111);
	local req2 = require("require");  -- req 和 req2的引用是一样的，是同一个表
	req2.foo(); -- foo 111
	--req.baz()	baz()是私有函数，访问不了
	gtest()  --全局函数
	
	local t1 = mymodule.buildUI(); -- {1, 2, 3}
	local t2 = mymodule.buildUI2(); --{1, 10, 3}  t1也跟着改变了
	local t3 = mymodule.buildUI3(); --{5, 6, 7}  uiInstance赋值了一个新的table了，不影响t1, t2
	print("end"); 
end
main()