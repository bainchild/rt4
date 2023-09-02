!(
local assert_disabled = callMacro("ASSERT","abc>0","bad")==""
function indent(s)
   return s:gsub("\n","\n"..getCurrentIndentationInOutput())
end
function check_argument(variable,idx,can_be_nil,default,type_)
   if assert_disabled then
      if evaluate(can_be_nil) then
         return "if "..variable.."==nil then "..variable.."=("..default..") end"
      else
         return ("-- check_arg(%s,%s,%s,%s,%s)"):format(variable,idx,can_be_nil,default,type_)
      end
   end
   if evaluate(can_be_nil) then
      return indent("if "..variable.."==nil then\n"
                  .."   "..variable.."=("..default..")\n"
                  .."else\n"
                  .."   "..variable.."=assert(typecast("..variable..","..type_.."))\n"
                  .."end")
   else
      if type_=="nil" then
         return "assert("..variable.."~=nil,'Argument "..idx.." missing or nil')"
      else
         return indent("assert("..variable.."~=nil,'Argument "..idx.." missing or nil')\n"
                  ..variable.."=assert(typecast("..variable..","..type_.."))")
      end
   end
end
function check_self(var,ty)
   return callMacro("ASSERT","n.type("..var..")=="..ty)
end
)
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
!if not assert_disabled then
local function unbounded()
   for i=1,5 do
      error('Unbounded code.')
   end
   coroutine.yield()
   local function f()
      return f()
   end
   f()
   return nil
end
!else
local function unbounded()
   error("Unbounded code.")
end
!end
local function typecast(a,otype)
   local ty = n.type(a)
   if ty==otype then return a end
   error('Unable to cast '..ty..' to '..otype)
   return unbounded()
end
local function strict(tab,name)
   return setmetatable(tab,{!if not assert_disabled then
      __index=function(self,k)
         if rawget(self,k) then return rawget(self,k) end
         error('Attempt to index '..name..' with '..(n.type(k)=="string" and "'"..k.."'" or tostring(k)))
      end;
      __newindex=function(self,k)
         error('Attempt to index '..name..' with '..(n.type(k)=="string" and "'"..k.."'" or tostring(k)))
      end;!end
      __mt="Locked";
      __tostring=function() return name end;
   })
end
@@"string.lua"
@@"math.lua"
@@"table.lua"
--
@@"Axes.lua"
@@"Color3.lua"
@@"BrickColor.lua"
@@"CFrame.lua"
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
@@"Vector3.lua"
-- @@"Vector3int16.lua"
return n