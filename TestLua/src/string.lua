function readFile(source)
	local file = io.open(source,"rb");
	assert(file);
	local data = file:read("*all");
	file:close();
	return data;

end
function print_double_table(t) --打印table里面还是table的键值对
	for k,v in pairs(t) do
		for k2,v2 in pairs(v) do
			print(k2, v2);
		end
	end
end
local function main()
	--[[调用string.sub(s,i,j)函数截取字符串s的从第i个字符到第j个字符之间的串。Lua中，字符串的第一个字符索引从1开始。
	你也可以使用负索引，负索引从字符串的结尾向前计数：-1指向最后一个字符，-2指向倒数第二个，以此类推。所以，
	string.sub(s, 1, j)返回字符串s的长度为j的前缀；string.sub(s, j, -1)返回从第j个字符开始的后缀。
	如果不提供第3个参数，默认为-1，因此我们将最后一个调用写为string.sub(s, j)；string.sub(s, 2, -2)返回去除第一个和最后一个字符后的子串。 --]]
	--记住：Lua中的字符串是恒定不变的。String.sub函数以及Lua中其他的字符串操作函数都不会改变字符串的值，而是返回一个新的字符串
	local s = "[in brackets]"
	print(string.sub(s, 2, -2))     --> in brackets
	local str = string.sub(s, 2, 1)
	print("str = " .. str .. " len = " .. string.len(str)) -- 空字符串
	--string.find的基本应用就是用来在目标串（subject string）内搜索匹配指定的模式的串。函数如果找到匹配的串返回他的位置，否则返回nil.
	--最简单的模式就是一个单词，仅仅匹配单词本身。比如，模式'hello'仅仅匹配目标串中的"hello"。当查找到模式的时候，函数返回两个值：匹配串开始索引和结束索引。
	s = "hello world"
	local i, j = string.find(s, "hello")
	print(i, j)                        --> 1    5
	print(string.sub(s, i, j))         --> hello
	print(string.find(s, "world"))     --> 7    11
	i, j = string.find(s, "l")
	print(i, j)                        --> 3    3
	print(string.find(s, "lll"))       --> nil
	--string.gsub函数有三个参数：目标串，模式串，替换串。他基本作用是用来查找匹配模式的串，并将使用替换串其替换掉,string.gsub的第二个返回值表示他进行替换操作的次数：
	s, count = string.gsub("Lua is cute", "cute", "great")
	print(s, count)      --> Lua is great
	s, count = string.gsub("all lii", "l", "x")
	print(s, count)     --> axx xii
	s, count = string.gsub("Lua is great", "perl", "tcl")
	print(s, count)      --> Lua is great
	--第四个参数是可选的，用来限制替换的字符次数:
	s, count = string.gsub("aall lii", "l", "x", 5)
	print(s, count)          --> aaxl lii
	s, count = string.gsub("aall lii", "l", "x", 2)
	print(s, count)          --> aaxx lii


	local socket = require("socket")
	local http = require("socket.http")
	local body, code, headers = http.request("http://192.168.162.34/autoUPD/10/filelist.txt");
	if code == 200 then
		print("body:\n" .. body);
	end

	local text = "12345"
	print(#text)--输入字符串长度
	
	local format = string.format("icon_gift_%d.png", 1)
	print(format)--输入字符串长度
end
main()
