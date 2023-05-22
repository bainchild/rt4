do
   local CFrame = {}
   function CFrame_fromXYZ(x,y,z)
      return n._proxy(setmetatable({X=X;Y=Y;Z=Z},{__index=CF}),"CFrame")
   end
   function CFrame.new(...)
      local s,r = select_overload({
         {a={"nil"},f=CFrame_identity};
         {a={"vector"},f=CFrame_fromV3};
         {a={"vector","vector"},f=CFrame_lookAt};
         {a={"number","number","number",f=CFrame_fromXYZ}};
      },...)
   end
   CFrame.identity = CFrame.new(0,0,0)
   n.CFrame = CFrame
end