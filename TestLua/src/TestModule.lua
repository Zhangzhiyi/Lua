--测试Lua的模块

require("module")


local function main()
	
	print("---------module----------")
	mymodule.bar()
	--mymodule.baz()   baz()是私有函数，访问不了
	
	print("---------require----------")
	local req = require("require")
	req.bar()
	--req.baz()	baz()是私有函数，访问不了
	gtest()  --全局函数
end
main()