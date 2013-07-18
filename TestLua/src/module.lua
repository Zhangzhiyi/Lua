module("mymodule", package.seeall)	-- optionally omitting package.seeall if desired
--如果没有package.seeall参数，之前定义的全局就看不见了，例如print输出这些全局的库就不能直接调用了

-- private  私有
local x = 1;
local uiInstance = nil;
local function baz() print 'test' end

function foo() print("foo", x) end

function bar()
  foo()
  baz()
  print "bar"
  
  mo = 2;
end
function buildUI()
	uiInstance = {1, 2, 3};
	return uiInstance;
end
function buildUI2()
	uiInstance[2] = 10;
	return uiInstance;
end
function buildUI3()
	uiInstance = {5, 6, 7};
	return uiInstance;
end
