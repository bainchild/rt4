do
   local t = {}
   function t.clear(tab)
      @@check_argument(tab,1,false,nil,"table")
      for i,v in pairs(tab) do tab[i]=nil end
      return nil
   end
   function t.clone(tab)
      @@check_argument(tab,1,false,nil,"table")
      local new = {}
      for i,v in pairs(tab) do new[i]=v end
      return new
   end
   function t.find(hay,needle,init)
      @@check_argument(hay,1,false,nil,"table")
      @@check_argument(needle,2,false,nil,nil)
      @@check_argument(init,3,true,nil,"number")
      for i,v in pairs(hay) do
         if ((init and n.type(i)=="number" and i>init) or n.type(init)=="nil") and v==needle then
            return i
         end
      end
      return nil
   end
   function t.move(src,a,b,offset,dst)
      @@check_argument(src,1,false,nil,"table")
      @@check_argument(a,2,false,nil,"number")
      @@check_argument(b,2,false,nil,"number")
      @@check_argument(offset,2,false,nil,"number")
      @@check_argument(dst,2,true,src,"table")
      for i=a,b,n.math.sign(b-a) do
         dst[offset+i] = src[i]
      end
      return dst
   end
   function t.pack(...)
      local args = {...}
      args.n = #args
      return args
   end
   local frozen = {}
   local frozen_mt = {}
   function frozen_mt:__newindex(k,v)
      error('Attempt to index a frozen table')
      return unbounded()
   end
   frozen_mt.__mt = "Locked"
   function t.freeze(a)
      check_argument(a,1,"table",false)
      local froze = t.clone(a)
      frozen[a] = froze
      setmetatable(froze,frozen_mt)
      return froze
   end
   function t.isfrozen(a)
      return frozen[a]~=nil
   end
   ---@diagnostic disable-next-line: deprecated
   if table.unpack==nil then
      t.unpack=unpack
   end
   for i,v in pairs(table) do
      if t[i]==nil and i~="setn" then t[i]=v end
   end
   t._global_name = "table"
   t.freeze(t)
   n.table = t
end