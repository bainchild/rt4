do
   local s = {}
   local function gsub_escape(str)
      return str:gsub("[%%%+%-%]%[%$%^%*%.%(%)%?]","%%1")
   end
   function s.split(str,delim)
      @@check_argument(str,1,false,nil,"string")
      @@check_argument(delim,1,false,nil,"string")
      delim=gsub_escape(delim)
      local mat = {}
      for i,v in pairs((str..delim):gmatch("(.-)"..delim)) do
         table.insert(mat,v)
      end
      return mat
   end
   function s.pack(form,...)
      @@check_argument(form,1,false,nil,"string")
      error('Unimplemented')
      return unbounded()
   end
   function s.unpack(form,data,start)
      @@check_argument(form,1,false,nil,"string")
      @@check_argument(data,2,false,nil,"string")
      @@check_argument(start,3,true,1,"number")
      error('Unimplemented')
      return unbounded()
   end
   function s.packsize(form)
      @@check_argument(form,1,false,nil,"string")
      error('Unimplemented')
      return unbounded()
   end
   for i,v in pairs(string) do if s[i]==nil then s[i]=v end end
   s._global_name = "string"
   n.table.freeze(s)
   n.string = s
end