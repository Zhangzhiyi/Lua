module("mymodule", package.seeall)	-- optionally omitting package.seeall if desired
--如果没有package.seeall参数，之前定义的全局就看不见了，例如print输出这些全局的库就不能直接调用了

-- private  私有
local x = 1
local function baz() print 'test' end

function foo() print("foo", x) end

function bar()
  foo()
  baz()
  print "bar"
end