#!/usr/bin/env lua


Fruit = {count = "1"}
function Fruit:new(extension)
	local t = setmetatable(extension or {}, self)
	self.__index = self
	return t
end

function Fruit:Count()
	return self.count
end

OwnerF = Fruit:new({owner = "sam"})
function OwnerF:Owner()
	return self.owner
end

function foo(a)
	print("foo", a)
	return coroutine.yield(2*a)
end

co = coroutine.create(function(a,b)
		print("co-body", a, b)
		local r = foo(a+1)
		print("co-body", r)
		local r, s = coroutine.yield(a+b, a-b)
		print("co-body", r, s)
		return b, "end"
		end)



function iter(array, i)
	i = i + 1
	local v = array[i]
	if v then
		return i, v
	else
		return nil, nil
	end
end

function enum(array)
	return iter, array, 0
end

arr = {11, 2, 3}
--[[
for i , v in enum(arr) do
	print(i, v)
end

do 
	i, v = iter(arr, 0)
	while v do
		print(i, v)
		i, v = iter(arr, i)
	end
end
]]
function values(t)
	local i = 0
	return function()
		i = i+1
		return t[i]
	end
end
function foreach(arr, act)
	do 
		it, ar, st = enum(arr)
		i, v = it(arr, st)
		while i do
			act(i, v)
			i, v = it(arr, i)
		end
	end
end
--[[
for element in values(arr) do
	print(element)
end
]]

foreach(arr, print)






