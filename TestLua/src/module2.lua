module("mymodule", package.seeall)

num = 99;
candies = {};
function module2()
	print("module2")
	mymodule["key"] = "value"; --����mymodule
	name = "name : module"; -- ����mymodule
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