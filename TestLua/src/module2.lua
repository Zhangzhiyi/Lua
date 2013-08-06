module("mymodule", package.seeall)

function module2()
	print("module2")
	mymodule["key"] = "value";
end
function assignName()
	name = "zhangzhiyi";
end
function getName()
	return name;
end