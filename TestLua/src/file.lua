require "lfs"
function copyfile(source, destination)
	local file = io.open(source, "rb");
    assert(file);
    local data = file:read("*all"); -- 读取所有内容
    file:close();
    file = io.open(destination, "wb");
    assert(file);
    file:write(data);
    file:close();
end
function readFile(source) -- 读文件
	local file = io.open(source,"rb");
	assert(file);
	local data = file:read("*all");
	file:close();
	return data;
end
function writeFile(source, body) -- 写文件
	local file = io.open(source,"w");
	assert(file);
	file:write(body);
	file:close();
end
function removeFile(source) --删除文件
	--local file = io.open(source,"w");
	--assert(file);
	local message = os.remove(source);
	print(message);
	return message;
end
function removeFileDirect(source) --删除目录
	local message = os.execute("rd " .. source);
	--print(message);
end
function createFileDirect(source) --创建目录
	
	local message = os.execute("mkdir " .. source);
	--print(message);
end
function exist(filename)
    local f = io.open(filename)
    if f == nil then
        return false
    end
    io.close(f)
    return true
end
local function main()
	--local data = readFile("F:/TexasHoldEm/uid.txt");
	--print(data);
	
	f = assert(io.open("a.txt", 'w'));
	f:write('test');
	f:close();
	
	--removeFile("a.txt");
	--r - 读取模式w - 写入模式(覆盖现有内容)

	--a - 附加模式(附加在现有内容之后)

	--b - 二进制模式

	--r+ - 读取更新模式(现有数据保留)

	--w+ - 写入更新模式(现有数据擦除)

	--a+ - 附加更新模式(现有数据保留，只在文件末尾附加)
	copyfile("1.png", "2.png");--写图片要用二进制模式打开
	copyfile("uid.txt", "uid2.txt");
	
	--createFileDirect("tmp1\\tmp2");
	--removeFileDirect("tmp1\\tmp2");
	local isExist = exist("tmp1\\tmp2");
	if isExist then
		f = assert(io.open("tmp1\\tmp2\\a.txt", 'w'));
		f:write('test');
		f:close();
	end
	
end
main()