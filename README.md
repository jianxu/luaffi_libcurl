luaffi_libcurl
==============
通过luaffi盒libcurl实现http请求

ATTENTION：因为libcurl的curl_easy_perform是会阻塞请求的，所以请不要盒ngx_lua_module一起使用，会破坏nginx的非阻塞特性。建议在ngx_lua_module里使用基于cosocket实现的方法

使用
====
```lua
luajit http.lua
```
