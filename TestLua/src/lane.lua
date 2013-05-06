require "lanes"

local function main()
	--local linda= lanes.linda()
  local function ret(name, b)
  	print(name .. ":start")
    while b >= 0 do
    	b = b - 1
    	print(name .. ":" .. b)
    end
    print(name .. ":end")
    return b;
  end
  
  local lgen = lanes.gen("*", ret)
  local ln = lgen("a", 100)
  local ln2 = lgen("b", 100)
--  print("????")
  local result = ln[1]
  local result2 = ln2[1]
  --print(result)
--  local function loop1()
--  	while true do
--  		print("loop1") 
--  		--os.execute("sleep 0.1") 
--  	end
--  end
--  local function loop2()
--  	while true do
--  		print("loop2") 
--  		--os.execute("sleep 0.1") 
--  	end
--  end
--  thread1= lanes.gen("*",loop1)()
--  thread2= lanes.gen("*",loop2)()
  --print(thread1)
	
  while true do
  	--休眠
  	local socket = require("socket")
  	socket.select(nil, nil, 1)
  	if result == -1 and result2 == -1 then
  		print("break");
  		break;
  	end
  end
  
	  
  
end
main()
