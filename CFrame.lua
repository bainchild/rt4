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
      @@check_self(self,"CFrame")
      return self.X,self.Y,self.Z,
             self.XVector.X,self.XVector.Y,self.XVector.Z,
             self.YVector.X,self.YVector.Y,self.YVector.Z,
             self.ZVector.X,self.ZVector.Y,self.ZVector.Z
   end
   function CFrame_fromComponents(x,y,z,R00,R01,R02,R10,R11,R12,R20,R21,R22)
      @@check_argument(x,1,true,0,"number")
      @@check_argument(y,2,true,0,"number")
      @@check_argument(z,3,true,0,"number")
      @@check_argument(R00,4,true,0,"number")
      @@check_argument(R01,5,true,0,"number")
      @@check_argument(R02,6,true,0,"number")
      @@check_argument(R10,7,true,0,"number")
      @@check_argument(R11,8,true,0,"number")
      @@check_argument(R12,9,true,0,"number")
      @@check_argument(R20,10,true,0,"number")
      @@check_argument(R21,11,true,0,"number")
      @@check_argument(R22,12,true,0,"number")
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