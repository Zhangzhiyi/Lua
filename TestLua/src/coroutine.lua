
local function main()
	--协同有三个状态：挂起态（suspended）、运行态（running）、停止态（dead）。当我们创建协同程序成功时，其为挂起态，即此时协同程序并未运行。
	local co = coroutine.create(function()
		print("hi"); -- hi
	end)
	print(co); --thread: 0000000009534790
	print(coroutine.status(co)); --suspended
	--函数coroutine.resume使协同程序由挂起状态变为运行态
	print(coroutine.resume(co)); --true
	--协同程序打印出"hi"后，任务完成，便进入终止态：
	print(coroutine.status(co)); --dead 
	
	--只有resume，没有yield，resume把参数传递给协同的主程序
	co = coroutine.create(function (a,b,c)
    	print("co", a,b,c)
	end)
	print(coroutine.resume(co, 1, 2, 3));
	print("-----------------")
	--数据由yield传给resume。true表明调用成功，true之后的部分，即是yield的参数
	co = coroutine.create(function (a,b)
    	coroutine.yield(a + b, a - b) -- 执行成功会返回true， 可尝试更改不能执行+、-运算的参数试试
    	print("again");
	end)
	print(coroutine.resume(co, 20, 10));    --> true  30  10
	-- false	attempt to perform arithmetic on local 'a' (a string value) 运行失败的协程序会变为dead状态
	--print(coroutine.resume(co, "a", 10)); 
	print(coroutine.resume(co)) -- again  从上次调用yield的下一句继续执行
	
	--协同代码结束时的返回值，也会传给resume
	co = coroutine.create(function ()
    	return 6, 7
	end)
	print(coroutine.resume(co))     --> true  6  7
	
	co = coroutine.create(function ()
    	for i = 1, 5  do
    		coroutine.yield(i)    -- 会中断
    	end
	end)
	print(coroutine.resume(co))		-- 1
	print(coroutine.resume(co))		-- 2
	print(coroutine.resume(co))		-- 3
	print(coroutine.resume(co))		-- 4
	print(coroutine.resume(co))		-- 5
end
main()