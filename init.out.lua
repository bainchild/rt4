
local function find(a,b)
   for i,v in pairs(a) do if v==b then return i end end
end
---@diagnostic disable-next-line: undefined-global
local n = {_proxy=function(a,ty)return a end,type=(typeof or type)}
local function select_overload(fq,...)
   local max_matching,max_match,args = -math.huge,nil,{...}
   for _,v in pairs(fq) do
      local matching = 0
      for i=1,#args do
         local ty=n.type(args[i])
         if (n.type(v.a)=="function" and v.a(i,ty)) or (n.type(v.a[i])=="table" and find(v.a[i],ty)~=nil) or ty==v.a[i] then
            matching=matching+1
         end
      end
      matching=matching/#args
      if matching>max_matching then
         max_match=v.f
         max_matching=matching
      end
   end
   return max_match~=nil,max_match
end

local function unbounded()
   error("Unbounded code.")
end

local function typecast(a,otype)
   local ty = n.type(a)
   if ty==otype then return a end
   error('Unable to cast '..ty..' to '..otype)
   return unbounded()
end
local function strict(tab,name)
   return setmetatable(tab,{
      __mt="Locked";
      __tostring=function() return name end;
   })
end
do
   local s = {}
   local function gsub_escape(str)
      return str:gsub("[%%%+%-%]%[%$%^%*%.%(%)%?]","%%1")
   end
   function s.split(str,delim)
      -- check_arg(str,1,false,nil,"string")
      -- check_arg(delim,1,false,nil,"string")
      delim=gsub_escape(delim)
      local mat = {}
      for i,v in pairs((str..delim):gmatch("(.-)"..delim)) do
         table.insert(mat,v)
      end
      return mat
   end
   function s.pack(form,...)
      -- check_arg(form,1,false,nil,"string")
      error('Unimplemented')
      return unbounded()
   end
   function s.unpack(form,data,start)
      -- check_arg(form,1,false,nil,"string")
      -- check_arg(data,2,false,nil,"string")
      if start==nil then start=(1) end
      error('Unimplemented')
      return unbounded()
   end
   function s.packsize(form)
      -- check_arg(form,1,false,nil,"string")
      error('Unimplemented')
      return unbounded()
   end
   for i,v in pairs(string) do if s[i]==nil then s[i]=v end end
   s._global_name = "string"
   n.table.freeze(s)
   n.string = s
end
do
   local m = {}
   function m.clamp(x,min,max)
      -- check_arg(x,1,false,nil,"number")
      -- check_arg(min,2,false,nil,"number")
      -- check_arg(max,3,false,nil,"number")
      if x<min then return min end
      if x>max then return max end
      return x
   end
   function m.sign(x)
      -- check_arg(x,1,false,nil,"number")
      if x==0 then return 0 end
      if x<0 then return -1 end
      if x>0 then return 1 end
      return unbounded()
   end
   function m.round(x)
      -- check_arg(x,1,false,nil,"number")
      local _,frac = math.modf(x)
      if frac<.5 then
         return m.floor(x)
      else
         return m.ceil(x)
      end
   end
   function m.noise(x,y,z)
      -- check_arg(x,1,false,nil,"number")
      if y==nil then y=(0) end
      if z==nil then z=(0) end
      error('Unimplemented.')
      return unbounded()
   end
   for i,v in pairs(math) do if m[i]==nil then m[i]=v end end
   m._global_name = "math"
   n.table.freeze(m)
   n.math = m
end
do
   local t = {}
   function t.clear(tab)
      -- check_arg(tab,1,false,nil,"table")
      for i,v in pairs(tab) do tab[i]=nil end
      return nil
   end
   function t.clone(tab)
      -- check_arg(tab,1,false,nil,"table")
      local new = {}
      for i,v in pairs(tab) do new[i]=v end
      return new
   end
   function t.find(hay,needle,init)
      -- check_arg(hay,1,false,nil,"table")
      -- check_arg(needle,2,false,nil,nil)
      if init==nil then init=(nil) end
      for i,v in pairs(hay) do
         if ((init and n.type(i)=="number" and i>init) or n.type(init)=="nil") and v==needle then
            return i
         end
      end
      return nil
   end
   function t.move(src,a,b,offset,dst)
      -- check_arg(src,1,false,nil,"table")
      -- check_arg(a,2,false,nil,"number")
      -- check_arg(b,2,false,nil,"number")
      -- check_arg(offset,2,false,nil,"number")
      if dst==nil then dst=(src) end
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
--
do
   local Axes = {}
   function Axes.new(...)
      local args = {...}
      local x,y,z,front,back,left,right,top,bottom
      for _,v in pairs(args) do
         if n.type(v)=="boolean" then
            if x==nil then
               x=v
            elseif y==nil then
               y=v
            elseif z==nil then
               z=v
            end
         elseif n.type(v)=="EnumItem" then
            local enum = n.Enum
            if n.EnumType==enum.NormalId then
               if n==enum.NormalId.Top then
                  top=true
               elseif n==enum.NormalId.Bottom then
                  bottom=true
               elseif n==enum.NormalId.Left then
                  left=true
               elseif n==enum.NormalId.Right then
                  right=true
               elseif n==enum.NormalId.Front then
                  front=true
               elseif n==enum.NormalId.Back then
                  back=true
               end
            else
               error('Bad EnumItem "'..tostring(v)..'"')
            end
         else
            error('Bad type "'..n.type(v)..'"')
         end
      end
      return n._proxy(strict({
         X=x or false;
         Y=y or false;
         Z=z or false;
         Top=top or false;
         Bottom=bottom or false;
         Left=left or false;
         Right=right or false;
         Front=front or false;
         Back=back or false;
      },"Axes"),"Axes")
   end
   Axes._global_name = "Axes"
   n.table.freeze(Axes)
   n.Axes = Axes
end
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
      -- check_arg(o,1,false,nil,"Color3")
      -- check_arg(i,2,false,nil,"number")
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
      if r==nil then r=(0) end
      if g==nil then g=(0) end
      if b==nil then b=(0) end
      return n._proxy(setmetatable({R=r;G=g;B=b},c3mt),"Color3")
   end
   function c.fromRGB(r,g,b)
      -- check_arg(r,1,false,nil,"number")
      -- check_arg(g,2,false,nil,"number")
      -- check_arg(b,3,false,nil,"number")
      return c.new(r/255,g/255,b/255)
   end
   function c.fromHSV(h,s,v)
      -- check_arg(h,1,false,nil,"number")
      -- check_arg(s,2,false,nil,"number")
      -- check_arg(v,3,false,nil,"number")
      return c.new(hsv_to_rgb(h,s,v))
   end
   function c.fromHex(str)
      -- check_arg(str,1,false,nil,"string")
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
do
   local color,cnames = {},{}
   local clrstr = "White	1	[242, 243, 243]\n	Grey	2	[161, 165, 162]\n	Light yellow	3	[249, 233, 153]\n	Brick yellow	5	[215, 197, 154]\n	Light green (Mint)	6	[194, 218, 184]\n	Light reddish violet	9	[232, 186, 200]\n	Pastel Blue	11	[128, 187, 219]\n	Light orange brown	12	[203, 132, 66]\n	Nougat	18	[204, 142, 105]\n	Bright red	21	[196, 40, 28]\n	Med. reddish violet	22	[196, 112, 160]\n	Bright blue	23	[13, 105, 172]\n	Bright yellow	24	[245, 205, 48]\n	Earth orange	25	[98, 71, 50]\n	Black	26	[27, 42, 53]\n	Dark grey	27	[109, 110, 108]\n	Dark green	28	[40, 127, 71]\n	Medium green	29	[161, 196, 140]\n	Lig. Yellowich orange	36	[243, 207, 155]\n	Bright green	37	[75, 151, 75]\n	Dark orange	38	[160, 95, 53]\n	Light bluish violet	39	[193, 202, 222]\n	Transparent	40	[236, 236, 236]\n	Tr. Red	41	[205, 84, 75]\n	Tr. Lg blue	42	[193, 223, 240]\n	Tr. Blue	43	[123, 182, 232]\n	Tr. Yellow	44	[247, 241, 141]\n	Light blue	45	[180, 210, 228]\n	Tr. Flu. Reddish orange	47	[217, 133, 108]\n	Tr. Green	48	[132, 182, 141]\n	Tr. Flu. Green	49	[248, 241, 132]\n	Phosph. White	50	[236, 232, 222]\n	Light red	100	[238, 196, 182]\n	Medium red	101	[218, 134, 122]\n	Medium blue	102	[110, 153, 202]\n	Light grey	103	[199, 193, 183]\n	Bright violet	104	[107, 50, 124]\n	Br. yellowish orange	105	[226, 155, 64]\n	Bright orange	106	[218, 133, 65]\n	Bright bluish green	107	[0, 143, 156]\n	Earth yellow	108	[104, 92, 67]\n	Bright bluish violet	110	[67, 84, 147]\n	Tr. Brown	111	[191, 183, 177]\n	Medium bluish violet	112	[104, 116, 172]\n	Tr. Medi. reddish violet	113	[229, 173, 200]\n	Med. yellowish green	115	[199, 210, 60]\n	Med. bluish green	116	[85, 165, 175]\n	Light bluish green	118	[183, 215, 213]\n	Br. yellowish green	119	[164, 189, 71]\n	Lig. yellowish green	120	[217, 228, 167]\n	Med. yellowish orange	121	[231, 172, 88]\n	Br. reddish orange	123	[211, 111, 76]\n	Bright reddish violet	124	[146, 57, 120]\n	Light orange	125	[234, 184, 146]\n	Tr. Bright bluish violet	126	[165, 165, 203]\n	Gold	127	[220, 188, 129]\n	Dark nougat	128	[174, 122, 89]\n	Silver	131	[156, 163, 168]\n	Neon orange	133	[213, 115, 61]\n	Neon green	134	[216, 221, 86]\n	Sand blue	135	[116, 134, 157]\n	Sand violet	136	[135, 124, 144]\n	Medium orange	137	[224, 152, 100]\n	Sand yellow	138	[149, 138, 115]\n	Earth blue	140	[32, 58, 86]\n	Earth green	141	[39, 70, 45]\n	Tr. Flu. Blue	143	[207, 226, 247]\n	Sand blue metallic	145	[121, 136, 161]\n	Sand violet metallic	146	[149, 142, 163]\n	Sand yellow metallic	147	[147, 135, 103]\n	Dark grey metallic	148	[87, 88, 87]\n	Black metallic	149	[22, 29, 50]\n	Light grey metallic	150	[171, 173, 172]\n	Sand green	151	[120, 144, 130]\n	Sand red	153	[149, 121, 119]\n	Dark red	154	[123, 46, 47]\n	Tr. Flu. Yellow	157	[255, 246, 123]\n	Tr. Flu. Red	158	[225, 164, 194]\n	Gun metallic	168	[117, 108, 98]\n	Red flip/flop	176	[151, 105, 91]\n	Yellow flip/flop	178	[180, 132, 85]\n	Silver flip/flop	179	[137, 135, 136]\n	Curry	180	[215, 169, 75]\n	Fire Yellow	190	[249, 214, 46]\n	Flame yellowish orange	191	[232, 171, 45]\n	Reddish brown	192	[105, 64, 40]\n	Flame reddish orange	193	[207, 96, 36]\n	Medium stone grey	194	[163, 162, 165]\n	Royal blue	195	[70, 103, 164]\n	Dark Royal blue	196	[35, 71, 139]\n	Bright reddish lilac	198	[142, 66, 133]\n	Dark stone grey	199	[99, 95, 98]\n	Lemon metalic	200	[130, 138, 93]\n	Light stone grey	208	[229, 228, 223]\n	Dark Curry	209	[176, 142, 68]\n	Faded green	210	[112, 149, 120]\n	Turquoise	211	[121, 181, 181]\n	Light Royal blue	212	[159, 195, 233]\n	Medium Royal blue	213	[108, 129, 183]\n	Rust	216	[144, 76, 42]\n	Brown	217	[124, 92, 70]\n	Reddish lilac	218	[150, 112, 159]\n	Lilac	219	[107, 98, 155]\n	Light lilac	220	[167, 169, 206]\n	Bright purple	221	[205, 98, 152]\n	Light purple	222	[228, 173, 200]\n	Light pink	223	[220, 144, 149]\n	Light brick yellow	224	[240, 213, 160]\n	Warm yellowish orange	225	[235, 184, 127]\n	Cool yellow	226	[253, 234, 141]\n	Dove blue	232	[125, 187, 221]\n	Medium lilac	268	[52, 43, 117]\n	Slime green	301	[80, 109, 84]\n	Smoky grey	302	[91, 93, 105]\n	Dark blue	303	[0, 16, 176]\n	Parsley green	304	[44, 101, 29]\n	Steel blue	305	[82, 124, 174]\n	Storm blue	306	[51, 88, 130]\n	Lapis	307	[16, 42, 220]\n	Dark indigo	308	[61, 21, 133]\n	Sea green	309	[52, 142, 64]\n	Shamrock	310	[91, 154, 76]\n	Fossil	311	[159, 161, 172]\n	Mulberry	312	[89, 34, 89]\n	Forest green	313	[31, 128, 29]\n	Cadet blue	314	[159, 173, 192]\n	Electric blue	315	[9, 137, 207]\n	Eggplant	316	[123, 0, 123]\n	Moss	317	[124, 156, 107]\n	Artichoke	318	[138, 171, 133]\n	Sage green	319	[185, 196, 177]\n	Ghost grey	320	[202, 203, 209]\n	Lilac	321	[167, 94, 155]\n	Plum	322	[123, 47, 123]\n	Olivine	323	[148, 190, 129]\n	Laurel green	324	[168, 189, 153]\n	Quill grey	325	[223, 223, 222]\n	Crimson	327	[151, 0, 0]\n	Mint	328	[177, 229, 166]\n	Baby blue	329	[152, 194, 219]\n	Carnation pink	330	[255, 152, 220]\n	Persimmon	331	[255, 89, 89]\n	Maroon	332	[117, 0, 0]\n	Gold	333	[239, 184, 56]\n	Daisy orange	334	[248, 217, 109]\n	Pearl	335	[231, 231, 236]\n	Fog	336	[199, 212, 228]\n	Salmon	337	[255, 148, 148]\n	Terra Cotta	338	[190, 104, 98]\n	Cocoa	339	[86, 36, 36]\n	Wheat	340	[241, 231, 199]\n	Buttermilk	341	[254, 243, 187]\n	Mauve	342	[224, 178, 208]\n	Sunrise	343	[212, 144, 189]\n	Tawny	344	[150, 85, 85]\n	Rust	345	[143, 76, 42]\n	Cashmere	346	[211, 190, 150]\n	Khaki	347	[226, 220, 188]\n	Lily white	348	[237, 234, 234]\n	Seashell	349	[233, 218, 218]\n	Burgundy	350	[136, 62, 62]\n	Cork	351	[188, 155, 93]\n	Burlap	352	[199, 172, 120]\n	Beige	353	[202, 191, 163]\n	Oyster	354	[187, 179, 178]\n	Pine Cone	355	[108, 88, 75]\n	Fawn brown	356	[160, 132, 79]\n	Hurricane grey	357	[149, 137, 136]\n	Cloudy grey	358	[171, 168, 158]\n	Linen	359	[175, 148, 131]\n	Copper	360	[150, 103, 102]\n	Medium brown	361	[86, 66, 54]\n	Bronze	362	[126, 104, 63]\n	Flint	363	[105, 102, 92]\n	Dark taupe	364	[90, 76, 66]\n	Burnt Sienna	365	[106, 57, 9]\n	Institutional white	1001	[248, 248, 248]\n	Mid gray	1002	[205, 205, 205]\n	Really black	1003	[17, 17, 17]\n	Really red	1004	[255, 0, 0]\n	Deep orange	1005	[255, 176, 0]\n	Alder	1006	[180, 128, 255]\n	Dusty Rose	1007	[163, 75, 75]\n	Olive	1008	[193, 190, 66]\n	New Yeller	1009	[255, 255, 0]\n	Really blue	1010	[0, 0, 255]\n	Navy blue	1011	[0, 32, 96]\n	Deep blue	1012	[33, 84, 185]\n	Cyan	1013	[4, 175, 236]\n	CGA brown	1014	[170, 85, 0]\n	Magenta	1015	[170, 0, 170]\n	Pink	1016	[255, 102, 204]\n	Deep orange	1017	[255, 175, 0]\n	Teal	1018	[18, 238, 212]\n	Toothpaste	1019	[0, 255, 255]\n	Lime green	1020	[0, 255, 0]\n	Camo	1021	[58, 125, 21]\n	Grime	1022	[127, 142, 100]\n	Lavender	1023	[140, 91, 159]\n	Pastel light blue	1024	[175, 221, 255]\n	Pastel orange	1025	[255, 201, 201]\n	Pastel violet	1026	[177, 167, 255]\n	Pastel blue-green	1027	[159, 243, 233]\n	Pastel green	1028	[204, 255, 204]\n	Pastel yellow	1029	[255, 255, 204]\n	Pastel brown	1030	[255, 204, 153]\n	Royal purple	1031	[98, 37, 209]\n	Hot pink	1032	[255, 0, 191]\n\n\n"
   for name,index,rgb in clrstr:gmatch("(%w+)%s*(%d+)(%b%[%])") do
      index=tonumber(index)
      local clr = n.Color3.fromRGB((rgb:gmatch("%[%d*, %d*, %d*%]")()))
      if index~=nil then
         color[index] = strict({
            Number=index;
            r=clr.R;
            g=clr.G;
            b=clr.B;
            Name=name;
            Color=clr;
         })
      end
   end
   for _,v in pairs(color) do cnames[v.Name]=v end
   local function c3diff(a,b)
      return math.abs(a.R-b.R)+math.abs(a.G-b.G)+math.abs(a.B-b.B)
   end
   local bc = {}
   function bc.new(v,g,b)
      local ty = n.type(v)
      if ty=="string" then
         if cnames[v] then return cnames[v] end
      elseif ty=="Color3" then
         local lowest,closest = math.huge,nil
         for i,c in pairs(color) do
            local diff = c3diff(c.Color,v)
            if diff<lowest then
               lowest=diff
               closest=c
            end
         end
         if closest then return closest end
      elseif ty=="number" and n.type(g)=="number" then
         -- check_arg(b,3,false,nil,'number')
         return bc.new(n.Color3.new(v,g,b))
      elseif ty=="number" then
         if color[v] then return color[v] end
      else
         -- check_arg(v,1,false,nil,"number")
      end
      return bc.Grey()
   end
   function bc.random()
      return color[math.random(1,#color)]
   end
   local pallette = {}
   for i=1,255 do
      pallette[i]=bc.random()
   end
   function bc.pallette(idx)
      -- todo
      if pallette[idx] then return pallette[idx] end
      return bc.Grey()
   end
   function bc.White() return cnames.White end
   function bc.Grey() return cnames["Medium stone grey"] end
   function bc.DarkGrey() return cnames["Dark stone grey"] end
   function bc.Black() return cnames.Black end
   function bc.Red() return cnames["Bright Red"] end
   function bc.Yellow() return cnames["Bright Yellow"] end
   function bc.Green() return cnames["Dark Green"] end
   function bc.Blue() return cnames["Bright Blue"] end
   bc._global_name = "BrickColor"
   bc = n.table.freeze(bc)
   n.BrickColor = bc
end
do
   local CFrame = {}
   local CF = {}
   function CF:__index(k)
      if n.type(k)=="string" and k:sub(1,1)=="_" then return nil end
      if rawequal(k,"Rotation") or rawequal(k,"rotation") then
         return CFrame_fromV3(self.Position)
      end
      if rawget(self,k) then return rawget(self,k) end
      return rawget(CF,k)
   end
   function CF:GetComponents()
      
      return self.X,self.Y,self.Z,
             self.XVector.X,self.XVector.Y,self.XVector.Z,
             self.YVector.X,self.YVector.Y,self.YVector.Z,
             self.ZVector.X,self.ZVector.Y,self.ZVector.Z
   end
   function CFrame_fromComponents(x,y,z,R00,R01,R02,R10,R11,R12,R20,R21,R22)
      if x==nil then x=(0) end
      if y==nil then y=(0) end
      if z==nil then z=(0) end
      if R00==nil then R00=(0) end
      if R01==nil then R01=(0) end
      if R02==nil then R02=(0) end
      if R10==nil then R10=(0) end
      if R11==nil then R11=(0) end
      if R12==nil then R12=(0) end
      if R20==nil then R20=(0) end
      if R21==nil then R21=(0) end
      if R22==nil then R22=(0) end
      local Vector3 = n.Vector3
      return n._proxy(setmetatable({
         X=x;
         Y=y;
         Z=z;
         Position=Vector3.new(x,y,z);
         LookVector=-Vector3.new(R02,R12,R22);
         UpVector=Vector3.new(R01,R11,R21);
         RightVector=Vector3.new(R00,R10,R20);
         XVector=Vector3.new(R00,R01,R02);
         YVector=Vector3.new(R10,R11,R12);
         ZVector=Vector3.new(R20,R21,R22);
         identity=CFrame.identity;
      },CF),"CFrame")
   end
   function CFrame_fromV3(v)
      return CFrame_fromComponents(v.X,v.Y,v.Z)
   end
   function CFrame_lookAt()
   end
   local function CFrame_identity()
      return CFrame.identity
   end
   function CFrame.new(...)
      local s,r = select_overload({
         {a={"nil"},f=CFrame_identity};
         {a={"vector"},f=CFrame_fromV3};
         {a={"vector","vector"},f=CFrame_lookAt};
         {a={{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"},{"number","nil"}},f=CFrame_fromComponents};
      },...)
      assert(s,"What were you trying to do?? (type full mismatch)")
      return r(...)
   end
   CFrame.identity = CFrame.new(0,0,0)
   n.CFrame = CFrame
end
-- @@"CatalogSearchParams.lua"
-- @@"ColorSequence.lua"
-- @@"ColorSequenceKeypoint.lua"
-- @@"Content.lua"
-- @@"DateTime.lua"
-- @@"DockWidgetPluginGuiInfo.lua"
-- @@"EnumItem.lua"
-- @@"Enum.lua"
-- @@"Enums.lua"
-- @@"Faces.lua"
-- @@"FloatCurveKey.lua"
-- @@"Font.lua"
-- @@"Instance.lua"
-- @@"NumberRange.lua"
-- @@"NumberSequence.lua"
-- @@"NumberSequenceKeypoint.lua"
-- @@"OverlapParams.lua"
-- @@"PathWaypoint.lua"
-- @@"PhysicalProperties.lua"
-- @@"RBXScriptConnection.lua"
-- @@"RBXScriptSignal.lua"
-- @@"Random.lua"
-- @@"Ray.lua"
-- @@"RaycastParams.lua"
-- @@"RaycastResult.lua"
-- @@"Rect.lua"
-- @@"Region3.lua"
-- @@"Region3int16.lua"
-- @@"SharedTable.lua"
-- @@"TweenInfo.lua"
-- @@"UDim.lua"
-- @@"UDim2.lua"
-- @@"Vector2.lua"
-- @@"Vector2int16.lua"

-- @@"Vector3int16.lua"
return n
