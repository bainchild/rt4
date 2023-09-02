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