do
   local c = {}
   local c3 = {}
   local c3mt = {
      __index=function(self,k)
         if rawget(self,k) then return rawget(self,k) end
         if rawget(c3,k) then return rawget(c3,k) end
         error('Attempt to index Color3 with '..(n.type(k)=="string" and "'"..k.."'" or tostring(k)))
      end;
      __newindex=function(self,k)
         error('Attempt to index Color3 with '..(n.type(k)=="string" and "'"..k.."'" or tostring(k)))
      end;
      __mt="Locked";
      __tostring=function() return "Color3" end;
   }
   local function rgb_to_hsv(R,G,B)
      local M,m = math.max(R,G,B),math.min(R,G,B)
      local V,S = M,nil
      if M > 0 then
         S=1-(m/M)
      else
         S=0
      end
      local H=math.acos((R-G/2-B/2)/math.sqrt(R^2+G^2+B^2-(R*G)-(R*B)-(G*B)))
      if G<B then
         H=360-H
      end
      return H/360,S,V
   end
   local function hsv_to_rgb(H,S,V)
      local M = 255*V
      local m = M*(1-S)
      local z = (M-m)*(1-math.abs(H*6%2-1))
      if H>=0 and H<6 then
         return M,z+m,m
      elseif H>=6 and H<12 then
         return z+m,M,m
      elseif H>=12 and H<18 then
         return m,M,z+m
      elseif H>=18 and H<24 then
         return m,z+m,M
      elseif H>=24 and H<30 then
         return z+m,m,M
      elseif H>=30 and H<36 then
         return M,m,z+m
      end
   end
   function c3:Lerp(o,i)
      assert(n.type(self)=="Color3","Called with '.', did you mean to use ':'")
      @@check_argument(o,1,false,nil,"Color3")
      @@check_argument(i,2,false,nil,"number")
      local dr,dg,db = o.R-self.R,o.G-self.G,o.B-self.B
      return c.new(dr*i,dg*i,db*i)
   end
   function c3:ToHex()
      assert(n.type(self)=="Color3","Called with '.', did you mean to use ':'")
      return string.format("%02x%02x%02x",n.math.round(self.R*255),n.math.round(self.G*255),n.math.round(self.B*255))
   end
   function c3:ToHSV()
      assert(n.type(self)=="Color3","Called with '.', did you mean to use ':'")
      return rgb_to_hsv(self.R,self.G,self.B)
   end
   function c.new(r,g,b)
      @@check_argument(r,1,true,0,"number")
      @@check_argument(g,2,true,0,"number")
      @@check_argument(b,3,true,0,"number")
      return n._proxy(setmetatable({R=r;G=g;B=b},c3mt),"Color3")
   end
   function c.fromRGB(r,g,b)
      @@check_argument(r,1,false,nil,"number")
      @@check_argument(g,2,false,nil,"number")
      @@check_argument(b,3,false,nil,"number")
      return c.new(r/255,g/255,b/255)
   end
   function c.fromHSV(h,s,v)
      @@check_argument(h,1,false,nil,"number")
      @@check_argument(s,2,false,nil,"number")
      @@check_argument(v,3,false,nil,"number")
      return c.new(hsv_to_rgb(h,s,v))
   end
   function c.fromHex(str)
      @@check_argument(str,1,false,nil,"string")
      if str:sub(1,1)=="#" then str=str:sub(2) end
      if #str==3 then
         local r,g,b = str:match('(%x)(%x)(%x)')
         assert(r~=nil,"Bad hex string.")
         assert(g~=nil,"Bad hex string.")
         assert(b~=nil,"Bad hex string.")
         return c.new(tonumber(r)/16,tonumber(g)/16,tonumber(b)/16)
      elseif #str==6 then
         local r,g,b = str:match('(%x%x)(%x%x)(%x%x)')
         assert(r~=nil,"Bad hex string.")
         assert(g~=nil,"Bad hex string.")
         assert(b~=nil,"Bad hex string.")
         return c.fromRGB(tonumber(r),tonumber(g),tonumber(b))
      else
         -- ummm uhh
         error('Bad length')
      end
      return unbounded()
   end
   c._global_name = "Color3"
   n.table.freeze(c)
   n.Color3 = c
end