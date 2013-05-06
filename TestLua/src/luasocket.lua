
function main()
	local host = "192.168.162.34";
	local file = "/autoUPD/9/test_dir3/test_file.txt";
	local socket = require"socket";
	control, err = assert(socket.connect(host, 80));
	control:send("GET " .. file .. " HTTP/1.0\r\n\r\n");

	local line = control:receive("*all");
	print(line);
	control:close();

	local socket = require("socket")
	local http = require("socket.http")

	local body, code, headers = http.request("http://192.168.162.34/autoUPD/10/filelist.txt");

	if code == 200 then
    print("body:\n" .. body);
	print("headers:\n" , headers);
	else print(error) end


end
main()
