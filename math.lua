do
   local m = {}
   function m.clamp(x,min,max)
      @@check_argument(x,1,false,nil,"number")
      @@check_argument(min,2,false,nil,"number")
      @@check_argument(max,3,false,nil,"number")
      if x<min then return min end
      if x>max then return max end
      return x
   end
   function m.sign(x)
      @@check_argument(x,1,false,nil,"number")
      if x==0 then return 0 end
      if x<0 then return -1 end
      if x>0 then return 1 end
      return unbounded()
   end
   function m.round(x)
      @@check_argument(x,1,false,nil,"number")
      local _,frac = math.modf(x)
      if frac<.5 then
         return m.floor(x)
      else
         return m.ceil(x)
      end
   end
   function m.noise(x,y,z)
      @@check_argument(x,1,false,nil,"number")
      @@check_argument(y,2,true,0,"number")
      @@check_argument(z,3,true,0,"number")
      error('Unimplemented.')
      return unbounded()
   end
   for i,v in pairs(math) do if m[i]==nil then m[i]=v end end
   m._global_name = "math"
   n.table.freeze(m)
   n.math = m
end