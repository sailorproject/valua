package = "valua"
version = "0.3-1"
source = {
   url = "git://github.com/sailorproject/valua",
   tag = "0.3"
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
   "lua >= 5.1, < 5.4"
}
build = {
   type = "none",
   install ={
      lua ={
         valua = "valua.lua"
      }
   }
}
