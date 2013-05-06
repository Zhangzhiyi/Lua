-- 如果以...为参数, 则表示参数的数量不定.
-- 参数将会自动存储到一个叫arg的table中.
-- arg.n中存放参数的个数. arg[]加下标就可以遍历所有的参数.
function funky_print(...)
	for i = 1 , arg.n do
		print("funky: "..arg[i]);
	end

end
function print_index_table(t) --打印有下表索引的值
	for k,v in ipairs(t) do
		print(k, v);
	end
end
function print_table(t) --打印键值对
	for k,v in pairs(t) do
		print(k, v);
	end
end
function print_double_table(t) --打印table里面还是table的键值对
	for k,v in pairs(t) do
		for k2,v2 in pairs(v) do
			print(k2, v2);
		end
	end
end