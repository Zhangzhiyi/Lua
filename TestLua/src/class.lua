Account = {balance = 0}
--冒号的效果相当于在函数定义和函数调用的时候，增加一个额外的隐藏参数。
--这种方式只是提供了一种方便的语法，实际上并没有什么新的内容。
--我们可以使用dot语法定义函数而用冒号语法调用函数，反之亦然，只要我们正确的处理好额外的参数
function Account.a(content)
	print("Account.a()" .. content)
end
function Account:deposit (v)
    self.balance = self.balance + v
end
function Account:withdraw(v)
	self.balance = self.balance - v;
end
function Account:new(obj) --构造一个Account的对象
	obj = obj or {};
	setmetatable(obj,self);
	self.__index = self;
	return obj;
	
end

SpecialAccount = Account:new(); -- 继承
SpecialAccount.property = 100000;
function SpecialAccount:withdraw (v)
    if v - self.balance >= self:getLimit() then
       error"insufficient funds"
    end
    self.balance = self.balance - v
end
 
function SpecialAccount:getLimit ()
    return self.limit or 0
end
function SpecialAccount:getProperty ()
    return self.property or 0
end
function SpecialAccount:showCallMethod(str)
	print("SpecialAccount:showCallMethod " .. str)
end
function SpecialAccount.showCallMethod2(str)
	print("SpecialAccount.showCallMethod2 " .. str)
end
local function main()
--	Account:deposit(100);
--	print(Account.balance);
--	Account.withdraw(Account, 50);
--	print(Account.balance);
	local a = Account:new({balance = 200});
	print(a.balance);
	local b = Account:new();
	print(b.balance);
	print(type(a));
	--SpecialAccount从Account继承了new方法，当new执行的时候，self参数指向SpecialAccount。
	--所以，s的metatable是SpecialAccount，__index 也是SpecialAccount。
	--这样，s继承了SpecialAccount，后者继承了Account
	local s = SpecialAccount:new({limit = 1000.00});
	s:deposit(100.00);
	--Lua在s中找不到deposit域，他会到SpecialAccount中查找，在SpecialAccount中找不到，会到Account中查找。
	--使得SpecialAccount特殊之处在于，它可以重定义从父类中继承来的方法
	s:withdraw(200.00);
	print(s.balance);
	SpecialAccount.balance = 500;
	print(s.balance);
	print(SpecialAccount.balance);
	print(s.property);
	print(s:getProperty());
	s:showCallMethod("sdkjflksdf")
	--另一种调用方法，直接获取类的方法变量再调用
	local method = SpecialAccount["showCallMethod"]
	method(SpecialAccount, "12312931")
	--注意function的. 和 ：的区别
	local method2 = SpecialAccount["showCallMethod2"]
	method2("showCallMethod2")
	
	-- 注意：方法Account.a(content)不是用":"，
	-- 所以s:a("111111")相当于Account.a(SpecialAccount，content)就会报错
	s.a("111111")
end
main()