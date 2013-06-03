function sum(x, y)
	return x + y;
end

function print_table(t) --打印键值对
	for k,v in pairs(t) do
		print(k, v);
	end
end
function print_index_table(t) --打印有下表索引的值
	for k,v in ipairs(t) do
		print(k, v);
	end
end