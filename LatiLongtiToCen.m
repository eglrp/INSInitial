function [ Cen,flag ] = LatiLongtiToCen( lati,longti )
%ʹ���������ڵľ�γ������ɵ���ϵe������ϵn������任����
%20170309 Salamander
%���뵥λΪ����
%flag=0��ʾ����
flag=1;
if lati<-0.5*pi||lati>0.5*pi||longti<-pi||longti>pi
    disp('������LatiLongtiToCen ���뾭γ�ȳ���')
    return
end

Cen=[-sin(longti),          cos(longti),            0;
    -sin(lati)*cos(longti), -sin(lati)*sin(longti), cos(lati);
    cos(lati)*cos(longti),  cos(lati)*sin(longti),  sin(lati)    ];
flag=0;
end

