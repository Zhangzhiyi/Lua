
require "file"
require "print"
require "lfs"
revision_name = "revision.txt";
filelist_name = "filelist.txt";
host = host or "http://192.168.162.34/autoUPD";

revisionUrl = revisionUrl or host .. "/revision.txt";
filelistUrl = host .. "/%d/" .. filelist_name;

targetUrl   = host .. "/%d/" .. "%s";
absolutePath = assert (lfs.currentdir()) .. "\\"; -- 获取当前项目路径

local newRevision;
local newFilelist;
local downloadTotalSize;
local haveDownloadSize = 0;
local function httpRequest(url) --网络协同
	local co = coroutine.create(function(url)
		local socket = require("socket")
		--socket:settimeout(10) settimeout会获取不了数据
		--socket.sleep(5); --测试
		local http = require("socket.http")
		--local body, code, headers = http.request(url);
		coroutine.yield(http.request(url));
	end)
	return coroutine.resume(co,url);
end
local function downloadFile(t)
	for k, v in ipairs(t) do
		if v.mode == "file" then
			local fileUrl = string.format(targetUrl, newRevision, v.path);
			local result, body, code, headers = httpRequest(fileUrl);
			if result then
				if code == 200 then
					--local name = string.sub(v.path,lastIndexOf(v.path, "/") or 0 + 1,-1);
					haveDownloadSize = haveDownloadSize + string.len(body);
					print(string.format("已下载百分比：%.2f", haveDownloadSize/downloadTotalSize * 100) .. "%");
					local filePath = absolutePath .. string.gsub(v.path, "/", "\\");
					writeFile(filePath, body);
					
				else
					print("下载文件失败！");
				end
			end
		else 
			local directoryPath = absolutePath .. string.gsub(v.path, "/", "\\");
			if not lfs.chdir(directoryPath) then
				assert (lfs.mkdir(directoryPath), "could not make a new directory");
			end
		end
	end
end
local function deleteFiles(t)
	for k, v in ipairs(t) do
		if v.mode == "file" then
			local filePath = absolutePath .. string.gsub(v.path, "/", "\\");
			removeFile(filePath);
		else
			local directoryPath = absolutePath .. string.gsub(v.path, "/", "\\");
			if lfs.chdir(directoryPath) then 
				--assert (lfs.rmdir(directoryPath), "could not remove directory from previous test")
				removeFilesAttrdir(directoryPath);
			end
		end
	end
	
end
local function main()
	
	removeFilesAttrdir("D:\\git\\cocos2dx-demo-of-zzy\\TexasHoldEm\\test");
	--读取本地的revision
	local revision = readFile("D:\\git\\cocos2dx-demo-of-zzy\\TexasHoldEm\\revision.txt");
	newRevision = revision;
	print(revision);
	
	--读取服务器的revision
	local result, serRevision, code, headers = httpRequest(revisionUrl);
	
	if result then
		if code == 200 then
			newRevision = serRevision;
			print(serRevision);
		else
			print("获取版本号失败！");
		end
	end
	
	local subRevision = newRevision - revision;
	local oldFilelistData = {};
	local newFilelistData = {}; 
	if subRevision == 0 then
		print("开始游戏！");
	elseif subRevision > 0 then 
		print("需要更新！");
		oldFilelistData = parseFileListFromFile("D:\\git\\cocos2dx-demo-of-zzy\\TexasHoldEm\\filelist.txt");
		--print_double_table(oldFilelistData);
		local result, serFilelist, code, headers = httpRequest(string.format(filelistUrl,newRevision));
		if result then
			if code == 200 then
				newFilelist = serFilelist;
				--print(serFilelist);
				newFilelistData = parseFileListFormString(newFilelist, "\n");
				--print_double_table(newFilelistData);
			else
				print("获取版本filelist失败！");
			end
		end
	end 
	
	if oldFilelistData and newFilelistData then
		local change, delete, totalFileSize =  compareFilelistDiff(oldFilelistData, newFilelistData);
		downloadTotalSize = totalFileSize;
		downloadFile(change);
		deleteFiles(delete);
		writeFile(absolutePath .. revision_name, newRevision);
		if newFilelist then writeFile(absolutePath .. filelist_name, newFilelist) end
		
	end
end
main()
