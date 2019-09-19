function main
f=figure;
      [x, y, z] = sphere(100);%Get sphere coordinates%取球体坐标

        r = 5;
        surf(r*x, r*y, r*z,'edgecolor','none','FaceColor',[220/255, 233/255, 255/255],'FaceAlpha','0.95','FaceLighting','gouraud');%Get an eye white sphere画眼睛白色球体
        hold on;

        [x1, y1, z1] = sphere();%Get sphere coordinates 获取球体坐标
        i =0;        j = 0;        k = 1;%%%%Set vectors for blue circle/eyeball设置蓝眼球向量
        rx = 2.5; ry = 2.5; rz = 2.5;
        offset=3;
        i=i/sqrt(i*i+j*j+k*k);
        j=j/sqrt(i*i+j*j+k*k);
        k=k/sqrt(i*i+j*j+k*k);
        SS=surf(rx*x1+offset*i, ry*y1+offset*j, rz*z1+offset*k,'edgecolor','none','FaceAlpha','0.9','FaceColor',[0/255, 230/255, 255/255]);%Get an eye blue sphere画蓝眼球
        x11 = x1(19:end,:)
        y11 = y1(19:end,:);
        z11 = z1(19:end,:);%
        DDD=surf(rx*x11+offset*i, ry*y11+offset*j, rz*z11+offset*k,'edgecolor','none','FaceAlpha','0.9','FaceColor',[0/255, 0/255, 0/255]);%Get an balck point in eye画眼球黑点
        
        axis equal;
        grid off
        axis([-10 10 -10 10 -10 10]);%Set the graph axis range 设定图轴范围
        axis off
        axis equal;
        axis vis3d; 
      
        set(f,'WindowButtonUpFcn',@startDragFcn);%Set the action function when the mouse is pressed in the picture设置图片中鼠标按下时动作函数
 function startDragFcn(varargin)%鼠标按下时动作函数
      set(f,'WindowButtonMotionFcn',@draggingFcn);%Set the action function when the mouse moves in the picture设置图片中鼠标移动时动作函数
 end
 function draggingFcn(varargin)%Action function when the mouse moves鼠标移动时动作函数
%       pt=get(aH,'CurrentPoint');
%       set(h,'Xdata',pt(1)*[1 1]);
    currPt = get(gca, 'CurrentPoint');    i = currPt(1,1);    j = currPt(1,2);    k = currPt(1,3);dirnew=[i,j,k];
    %Get current mouse pointer coordinates取当前鼠标指针坐标dirnew
dirorg=[SS.XData(21,10),SS.YData(21,10),SS.ZData(21,10)]/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
%Get the current eye direction vector取当前眼球方向向量dirorg
rotdir=cross(dirorg,dirnew);
%The direction in which two vectors need to move when the eye moves眼球动作时两向量需要运动的方向
rotTheta=180/pi*acos(dot(dirnew,dirorg)/(norm(dirnew)*norm(dirorg)))
%The angle of movement when the eye moves from the old position to the new position眼球动作时从旧位置到新位置时运动的角度
 rotate(SS,rotdir,rotTheta);%Rotate the blue eyeball to the direction of the mouse pointer旋转蓝色眼球到鼠标指针方向
 rotate(DDD,rotdir,rotTheta);%Rotate the black dot to the direction of the mouse pointer旋转黑色点到鼠标指针方向

 
 % dirafterrotate=[SS.XData(21,10),SS.YData(21,10),SS.ZData(21,10)]/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
% xx=SS.XData(21,10)/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
% yy=SS.YData(21,10)/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
% zz=SS.ZData(21,10)/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));

 end
 function stopDragFcn(varargin)
     set(f,'WindowButtonMotionFcn','');
 end
 end
