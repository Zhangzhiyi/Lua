c = {};
c.__add = function (op1, op2)
	for _, item in ipairs(op2) do
		table.insert(op1,item);
	end
	return op1;
end
function print_table(t) --打印有下表索引的值
	for k,v in pairs(t) do
		print(k, v);
	end
end
local function main()
	local a = {5, 6};
	local b = {7, 8};
	setmetatable(a,c);
	local d = a + b;
	print_table(d);
end
main()