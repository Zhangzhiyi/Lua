local M = {} -- public interface

-- private
local x = 1
local function baz() print 'test' end

function M.foo() print("foo", x) end

function M.bar()
  M.foo()
  baz()
  print "bar"
end

function gtest()  -- 全局函数
	print("global function")
end
return M