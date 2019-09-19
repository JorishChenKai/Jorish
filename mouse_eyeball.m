function main
f=figure;
      [x, y, z] = sphere(100);%Get sphere coordinates%ȡ��������

        r = 5;
        surf(r*x, r*y, r*z,'edgecolor','none','FaceColor',[220/255, 233/255, 255/255],'FaceAlpha','0.95','FaceLighting','gouraud');%Get an eye white sphere���۾���ɫ����
        hold on;

        [x1, y1, z1] = sphere();%Get sphere coordinates ��ȡ��������
        i =0;        j = 0;        k = 1;%%%%Set vectors for blue circle/eyeball��������������
        rx = 2.5; ry = 2.5; rz = 2.5;
        offset=3;
        i=i/sqrt(i*i+j*j+k*k);
        j=j/sqrt(i*i+j*j+k*k);
        k=k/sqrt(i*i+j*j+k*k);
        SS=surf(rx*x1+offset*i, ry*y1+offset*j, rz*z1+offset*k,'edgecolor','none','FaceAlpha','0.9','FaceColor',[0/255, 230/255, 255/255]);%Get an eye blue sphere��������
        x11 = x1(19:end,:)
        y11 = y1(19:end,:);
        z11 = z1(19:end,:);%
        DDD=surf(rx*x11+offset*i, ry*y11+offset*j, rz*z11+offset*k,'edgecolor','none','FaceAlpha','0.9','FaceColor',[0/255, 0/255, 0/255]);%Get an balck point in eye������ڵ�
        
        axis equal;
        grid off
        axis([-10 10 -10 10 -10 10]);%Set the graph axis range �趨ͼ�᷶Χ
        axis off
        axis equal;
        axis vis3d; 
      
        set(f,'WindowButtonUpFcn',@startDragFcn);%Set the action function when the mouse is pressed in the picture����ͼƬ����갴��ʱ��������
 function startDragFcn(varargin)%��갴��ʱ��������
      set(f,'WindowButtonMotionFcn',@draggingFcn);%Set the action function when the mouse moves in the picture����ͼƬ������ƶ�ʱ��������
 end
 function draggingFcn(varargin)%Action function when the mouse moves����ƶ�ʱ��������
%       pt=get(aH,'CurrentPoint');
%       set(h,'Xdata',pt(1)*[1 1]);
    currPt = get(gca, 'CurrentPoint');    i = currPt(1,1);    j = currPt(1,2);    k = currPt(1,3);dirnew=[i,j,k];
    %Get current mouse pointer coordinatesȡ��ǰ���ָ������dirnew
dirorg=[SS.XData(21,10),SS.YData(21,10),SS.ZData(21,10)]/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
%Get the current eye direction vectorȡ��ǰ����������dirorg
rotdir=cross(dirorg,dirnew);
%The direction in which two vectors need to move when the eye moves������ʱ��������Ҫ�˶��ķ���
rotTheta=180/pi*acos(dot(dirnew,dirorg)/(norm(dirnew)*norm(dirorg)))
%The angle of movement when the eye moves from the old position to the new position������ʱ�Ӿ�λ�õ���λ��ʱ�˶��ĽǶ�
 rotate(SS,rotdir,rotTheta);%Rotate the blue eyeball to the direction of the mouse pointer��ת��ɫ�������ָ�뷽��
 rotate(DDD,rotdir,rotTheta);%Rotate the black dot to the direction of the mouse pointer��ת��ɫ�㵽���ָ�뷽��

 
 % dirafterrotate=[SS.XData(21,10),SS.YData(21,10),SS.ZData(21,10)]/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
% xx=SS.XData(21,10)/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
% yy=SS.YData(21,10)/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));
% zz=SS.ZData(21,10)/sqrt(SS.ZData(21,10)*SS.ZData(21,10)+SS.YData(21,10)*SS.YData(21,10)+SS.XData(21,10)*SS.XData(21,10));

 end
 function stopDragFcn(varargin)
     set(f,'WindowButtonMotionFcn','');
 end
 end
