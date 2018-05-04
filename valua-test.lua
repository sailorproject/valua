local v = require "valua"
local passing = true

local function check(val_test, test_value, expected, n)
	local res,err = val_test(test_value)
	local msg = "Validation "..tostring(n).." "

	if res == expected then
		msg = msg.. "succeeded"
	else
		passing = false
		msg = msg.. " \27[31m FAILED \27[0m"
	end
	msg = msg.." on '"..(tostring(test_value)).."'. Expected: "..tostring(expected)..", result: "..tostring(res)..". "
	print(msg)
	if err then print("\tTest Msg: value "..(err or "")) end
end

local test_values = {
	 [1] = "test string!",
	 [2] = "hey",
	 [3] = "",
	 [4] = nil,
	 [5] = true,
	 [6] = 42,
	 [7] = 1337,
	 [8] = '26/10/1980',
	 [9] = '10-26-1980',
	[10] = '29.02.2014',
	[11] = '29/02/2016',
	[12] = 'a@a.com',
	[13] = 'asd123',
	[14] = 5.7,
	[15] = {},
	[16] = {3,46},
	[17] = "<script>alert('boohoo@email.com XSS');</script>",
	[18] = "test-123_maria.2@newdomain.wow.movie",
	[19] = "10/06/1980 10:32:10"
}

local tests = {
	{v:new().type("string").len(3,5), {1,false}},
	{v:new().type("number").len(3,5), {1,false}},
	{v:new().type("table").empty(), {15,true, 16,false, 1,false}},
--  require('mobdebug').start('127.0.0.1')
	{v:new().not_empty(), {2,true, 3,false, 4,false, 16,true, 5,true, 6,true}},
	{v:new().len(2,10), {2,true}},
	{v:new().type("number"), {2,false}},
	{v:new().empty(), {3,true, 4,true, 5,false, 6,false}},
	{v:new().boolean(), {1,false, 5,true}},
	{v:new().compare("hey"), {1,false, 2,true}},
	{v:new().number().min(45), {2,false, 6,false, 7,true, 4,false}},
	{v:new().number().max(1009), {7,false, 6,true}},
	{v:new().date(), {9,false, 10,false, 11,true, 8,true}},
	{v:new().date('us'), {8,false, 9,true}},
	{v:new().email(), {13,false, 12,true, 17,false, 18,true}},
	{v:new().in_list({"hey",42}), {12,false, 6,true, 2,true}},
	{v:new().match("^%d+%p%d+%p%d%d%d%d$"), {1,false, 8,true}},
	{v:new().alnum(), {8,false, 13,true}},
	{v:new().integer(), {14,false, 6,true,}},
	{v:new().string(), {14,false, 1,true, 4,false}},
	{v:new().string().alnum(), {6,false}},
	{v:new().contains(" "), {2,false, 1,true}},
	{v:new().no_white(), {1,false, 2,true}},
	{v:new().datetime(), {19,true, 9,false}},
	{v:new().number().min(45).optional(), {2,false, 6,false, 7,true, 4,true}},
	{v:new().number().optional().min(45), {2,false, 6,false, 7,true, 4,true}},
	{v:new().string().optional(), {14,false, 1,true, 4,true}},
}

for n,t in ipairs(tests) do
	for i = 1, #t[2], 2 do
		check(t[1],test_values[t[2][i]],t[2][i+1],n)
	end
end

if not passing then
	error('Tests are failing')
end
