local function main()

	print(os.time()) --以秒为单位的 格林威志时间(gmt),注意不同时区的时差
	print(os.date()) --05/02/13 11:55:25
	print(os.clock()) --读取系统时钟，以秒为单位。表示从系统启动到当前时刻所过去的秒数
end
main()