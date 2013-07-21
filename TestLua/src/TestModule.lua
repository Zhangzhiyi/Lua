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
	local req = require("require")
	req.bar()
	--req.baz()	baz()是私有函数，访问不了
	gtest()  --全局函数
	
	
end
main()