local v = require "valua"

local function check(val_test, test_value, expected, n) 
	local res,err = val_test(test_value)
	local msg = "Validation "..n.." "

	if res == expected then 
		msg = msg.. "succeeded"
	else 
		msg = msg.. "FAILED" 
	end
	msg = msg.." on '"..(tostring(test_value)).."'. Expected: "..tostring(expected)..", result: "..tostring(res)..". " 
	print(msg)
	if err then print("\tTest Msg: value "..(err or "")) end 
end 

local test_values = {  
        "test string!",
	"hey",
	"",
        nil,
        true,
        42,
        1337,
        '26/10/1980',
        '10-26-1980',
        '29.02.2014',
        '29/02/2016',
        'a@a.com',
        'asd123',
        5.7
}

local tests = {
	{v:new().type("string").len(3,5),{1,false}},
	{v:new().type("number").len(3,5), {1,false}},
	{v:new().not_empty(),{2,true,3,false,4,false}},
	{v:new().len(2,10),{2,true}},
	{v:new().type("number"),{2,false}},
	{v:new().empty(),{3,true,4,true}},
        {v:new().boolean(),{1,false,5,true}},
        {v:new().compare("hey"),{1,false,2,true}},
        {v:new().number().min(45),{2,false,6,false,7,true}},
        {v:new().number().max(1009),{7,false,6,true}},
        {v:new().date(),{9,false,10,false,11,true,8,true}},
        {v:new().date('us'),{8,false,9,true}},
        {v:new().email(),{13,false,12,true}},
        {v:new().in_list({"hey",42}),{12,false,6,true,2,true}},
        {v:new().match("^%d+%p%d+%p%d%d%d%d$"),{1,false,8,true}},
        {v:new().alnum(),{8,false,13,true}},
        {v:new().integer(),{14,false,6,true}},
        {v:new().string(),{14,false,1,true}},
        {v:new().string().alnum(),{6,false}},
        {v:new().contains(" "),{2,false,1,true}},
        {v:new().no_white(),{1,false,2,true}}
}

for n,t in ipairs(tests) do
	for i = 1, #t[2], 2 do
		check(t[1],test_values[t[2][i]],t[2][i+1],n)
	end
end
