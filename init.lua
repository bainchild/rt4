local n = {_proxy=function(a)return a end}
function select_overload(fq,...)
   local max_matching,max_match,args = -math.huge,nil,{...}
   for i,v in pairs(fq) do
      local matching = 0
      for i=1,#args do
         local ty=(typeof or type)(args[i])
         if (type(v.a)=="function" and v.a(i,ty)) or (type(v.a[i])=="table" and find(v.a[i],ty)~=nil) or ty==v then
            matching=matching+1
         end
      end
      if matching>max_matching then
         max_match=v.f
      end
   end
   return max_match~=nil,max_match
end
@@"extra/rt4/CFrame.lua"
return n