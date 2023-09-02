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
         @@check_argument(b,3,false,nil,'number')
         return bc.new(n.Color3.new(v,g,b))
      elseif ty=="number" then
         if color[v] then return color[v] end
      else
         @@check_argument(v,1,false,nil,"number")
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