local ffi = require "ffi"

ffi.cdef(io.open('http.ffi', 'r'):read('*a'))

local libcurl = ffi.load('libcurl')
local curl = libcurl.curl_easy_init()
libcurl.curl_easy_setopt(curl, ffi.C.CURLOPT_URL, 'http://curl.haxx.se')

-- ffi.cast write_callback
local cbuffer = ffi.new('char*')
local csize = ffi.new('size_t')
local cnitems = ffi.new('size_t')
local coutstream = ffi.new('void*')

local result = ''

local lwrite_callback
lwrite_callback = function (cbuffer, csize, cnitems, coutstream)
    local rsize = tonumber(csize * cnitems)
	result = result .. ffi.string(cbuffer):sub(1, rsize)
	return rsize
end
local curl_write_callback = ffi.cast('curl_write_callback', lwrite_callback)
libcurl.curl_easy_setopt(curl, ffi.C.CURLOPT_WRITEFUNCTION, curl_write_callback)
res = libcurl.curl_easy_perform(curl)
if res ~= 0 then
    print(ffi.string(libcurl.curl_easy_strerror(res)))
end
curl_write_callback:free()
libcurl.curl_easy_cleanup(curl)
print("result\t", #result, "\t", result)
