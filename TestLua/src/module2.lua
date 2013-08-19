module("mymodule", package.seeall)

num = 99;
candies = {};
function module2()
	print("module2")
	mymodule["key"] = "value"; --加入mymodule
	name = "name : module"; -- 加入mymodule
end
function getName()
	print(name); -- "name : module"
end
function assignName()
	name = "zhangzhiyi";
end
function getName()
	return name;
end