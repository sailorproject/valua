package = "Valua"
version = "0.2"
source = {
   url = "https://github.com/Etiene/valua",
   tag = "v0.2"
}
description = {
   summary = "Validation for Lua!",
   detailed = [[
      This module provides tools for validating values, very useful in forms, but also usable elsewhere. It works in appended chains. Create a new validation object and start chaining your test functions.
   ]],
   homepage = "https://github.com/Etiene/valua", 
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.3"
}
build = {
   type = "builtin",
   modules = {
      ["valua"] = "valua.lua",
   }
}