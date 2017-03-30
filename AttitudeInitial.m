%前5S的数据（500个历元）实施粗对准
%20170330Salamander
clear
clc
%% 参数定义
Re=6378137.0;
f=1.0/298.257;
wiee=[  0;
        0;
        7.2722e-5];
DeltaT=0.01;%采样间隔，单位：秒
RoughT=30;%粗对准时长，单位：秒
%% 其他初始数据
lati=39.813330*pi/180;
longti=116.15326*pi/180;
h=70.0;
vn=[0;0;0];
g=AccuG(lati,h);
[Cen,~]=LatiLongtiToCen(lati,longti);


gn=[0;0;-g];
wien=Cen*wiee;
VectorN=[gn,wien,cross(gn,wien)];
%% 读取观测数据

IMUData=importIMUfile('D:\Benzene Mo\docdefault\惯导数据计算\data20110913\imu_ENU.txt');
[nepoch,~]=size(IMUData);
%% 粗对准
gb=mean([-IMUData.fbx(1:RoughT/DeltaT),-IMUData.fby(1:RoughT/DeltaT),-IMUData.fbz(1:RoughT/DeltaT)])';%此处的负号为修正加速度计观测文件imu_ENU.txt中的观测量，不适用于其他情形
wieb=mean([IMUData.wibbx(1:RoughT/DeltaT),IMUData.wibby(1:RoughT/DeltaT),IMUData.wibbz(1:RoughT/DeltaT)])';%wieb=wibb-webb 静基座，则b相对e不动，wieb=wibb
VectorB=[gb,wieb,cross(gb,wieb)];
Tbn=VectorN'\VectorB';
[ psi,theta,gama,~ ] = TbnToAttitude( Tbn );
AttitudeIni=[psi;theta;gama];
%% 惯导计算Vn准备
[Q,FlagFun]=AttiToQuater(AttitudeIni);


%% 精对准
for i=RoughT/DeltaT:nepoch
    
x=[DeltaVx;DeltaVy;Phix;Phiy;Phiz];
F=[0,2]
Dotx=F*x+w;





