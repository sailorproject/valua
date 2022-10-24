package = "valua"
version = "current-1"
source = {
   url = "git://github.com/sailorproject/sailor",
}
description = {
   summary = "Validation for Lua!",
   detailed = [[
      This module provides tools for validating values, very useful in forms, but also usable elsewhere. It works in appended chains. Create a new validation object and start chaining your test functions.
   ]],
   homepage = "https://github.com/sailorproject/valua", 
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.5",
   "busted >= 2.0.rc10",
}
build = {
   type = "builtin",
   modules = {
      valua = "valua.lua"
   }
}
