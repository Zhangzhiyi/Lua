
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
	local file = io.open(source, "wb");
	assert(file);
	file:write(body);
	file:close();
end
function removeFile(source) --删除文件
	--local file = io.open(source,"w");
	--assert(file);
	local message = os.remove(source);
	--print(message);
	return message;
end
function removeFileDirect(source) --删除目录
	os.execute("rd " .. source);
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
local sep = "/";
function copyFilesAttrdir(path) -- 迭代复制目录
	if not lfs.chdir(path) then
		assert (lfs.mkdir(path), "could not make a new directory");
	end
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = path..sep..file
			--print ("\t=> "..f.." <=")
			local attr = lfs.attributes (f)
			assert (type(attr) == "table")
			if attr.mode == "directory" then
				copyFilesAttrdir (f)
			else
--				for name, value in pairs(attr) do
--					print (name, value)
--				end
				copyfile(f, f);
			end
		end
	end
end
function removeFilesAttrdir (path) -- 迭代删除非空目录
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = path..sep..file
			--print ("\t=> "..f.." <=")
			local attr = lfs.attributes (f)
			assert (type(attr) == "table")
			if attr.mode == "directory" then
				removeFilesAttrdir (f)
			else
--				for name, value in pairs(attr) do
--					print (name, value)
--				end
				os.remove(f);
			end
		end
	end
	if lfs.chdir(path) then -- 进入这个目录给锁定了，无法删除
		lfs.chdir(".."); --退回上一级目录
		assert (lfs.rmdir(path), "could not remove directory from previous test")
--		--lfs.rmdir(path);
--		--removeFileDirect(path)
	end
end
function parseFileListFromFile(source)
	local filedata = {};
	local file = io.open(source, "rb");
	assert(file);
	local splitString = "\r";
	local len = string.len(splitString);
	while true do
		local line = file:read("*line");
		if not line then break end;
		--print(line);
		--判断是否含有逗号，有就是文件，否则就是目录
		local isDotExsit = string.find(line, ",", 1);
		if not isDotExsit then
			local item = {path = string.sub(line, 1, -(len + 1)), size = 0, mode = "directory"};
			table.insert(filedata,item);
		else
			local index = 1;
			local item = {};
			local count = 0;
			while true do
				local start = string.find(line, ",", index);
				if not start then
					-- add last position
					item.md5 = string.sub(line, index, -(len + 1));
					item.mode = "file";
					break;
				end;
				count = count + 1;
				if count == 1 then
					item.path = string.sub(line, index, start - 1);
					elseif count == 2 then
					item.size = string.sub(line, index, start - 1);
				end
				index = start + 1;
			end
			table.insert(filedata,item);
		end
	end
	file:close();
	return filedata;
end
function parseFileListFormString(data, splitString)
	local filedata = {};
	local len = string.len(splitString);
	local rIndex = 1;
	while true do
		local rStart = string.find(data, splitString, rIndex);
		if not rStart then break end;
		local line = string.sub(data, rIndex, rStart - len);
		--print("line:" .. line);
		--判断是否含有逗号，有就是文件，否则就是目录
		local isDotExsit = string.find(line, ",", 1);
		if not isDotExsit then
			local item = {path = line, size = 0, mode = "directory"};
			table.insert(filedata,item);
			rIndex = rStart + len;
		else
			-- 文件
			local index = 1;
			local item = {};
			local count = 0;
			while true do
				local start = string.find(line, ",", index);
				if not start then
					-- add last position
					item.md5 = string.sub(line, index, -1);
					item.mode = "file";
					break;
				end;
				count = count + 1;
				if count == 1 then
					item.path = string.sub(line, index, start - 1);
					elseif count == 2 then
					item.size = string.sub(line, index, start - 1);
				end
				index = start + 1;
			end
			table.insert(filedata,item);
			rIndex = rStart + len;
		end
	end
	return filedata;
end
function compareFilelistDiff(oldFileData, newFileData) --比较差异
	local change = {};
	local delete = {};
	local downFilesSize = 0;
	for oldIndex,oldItem in ipairs(oldFileData) do
		local newIndex = 1;
		local newSize = table.getn(newFileData);
		if newSize == 0 then
			table.insert(delete,oldItem);
		end
		local index = half_seek(newFileData, 1, newSize, oldItem.path);
		if index == -1 then
			table.insert(delete,oldItem);
		else
			if oldItem.mode == "file" then
				if oldItem.size ~= newFileData[index].size or oldItem.md5 ~= newFileData[index].md5 then
					downFilesSize = downFilesSize + newFileData[index].size;
					table.insert(change, newFileData[index]);
				end
			end
			table.remove(newFileData, index);
		end
--		for newIndex, newItem in ipairs(newFileData) do
--			if oldItem.path == newItem.path then
--				if oldItem.size ~= newItem.size or oldItem.md5 ~= newItem.md5 then
--					downFilesSize = downFilesSize + newItem.size;
--					table.insert(change, newItem);
--				end
--				table.remove(newFileData,newIndex);
--				break;
--			else
--				if newIndex == newSize then
--					table.insert(delete,oldItem);
--				end
--			end
--		end

	end
	for k,v in ipairs(newFileData) do
		downFilesSize = downFilesSize + v.size;
		table.insert(change, v);
	end
	print("change:");
	print_double_table(change);
	print("delete:");
	print_double_table(delete);
	return change, delete, downFilesSize;
end


function lastIndexOf(str, split) -- 寻找最后匹配字符串的下表
	local index = 1;
	local result = nil;
	while true do
		local mStart = string.find(str, split, index);
	if not mStart then return result end
	result = mStart;
	index = mStart + string.len(split);
	end
end

function half_seek(t, low, high, target) -- 二分查找文件
	if low >=high and t[low].path ~= target then
		return -1;
	end
	local mid = _i((low + high)/2);
	if t[mid].path == target then
		return mid;
	elseif t[mid].path > target then
		high = mid - 1;
	else 
		low = mid + 1;
	end
	return half_seek(t, low, high, target);
end
function _i(v)
    return math.floor(_n(v))
end
function _n(v)
    v = tonumber(v)
    return v or 0
end
