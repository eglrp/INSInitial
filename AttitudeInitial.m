%ǰ5S�����ݣ�500����Ԫ��ʵʩ�ֶ�׼
%20170330Salamander
clear
clc
%% ��������
Re=6378137.0;
f=1.0/298.257;
wiee=[  0;
        0;
        7.2722e-5];
DeltaT=0.01;%�����������λ����
RoughT=30;%�ֶ�׼ʱ������λ����
%% ������ʼ����
lati=39.813330*pi/180;
longti=116.15326*pi/180;
h=70.0;
vn=[0;0;0];
g=AccuG(lati,h);
[Cen,~]=LatiLongtiToCen(lati,longti);


gn=[0;0;-g];
wien=Cen*wiee;
VectorN=[gn,wien,cross(gn,wien)];
%% ��ȡ�۲�����

IMUData=importIMUfile('D:\Benzene Mo\docdefault\�ߵ����ݼ���\data20110913\imu_ENU.txt');
[nepoch,~]=size(IMUData);
%% �ֶ�׼
gb=mean([-IMUData.fbx(1:RoughT/DeltaT),-IMUData.fby(1:RoughT/DeltaT),-IMUData.fbz(1:RoughT/DeltaT)])';%�˴��ĸ���Ϊ�������ٶȼƹ۲��ļ�imu_ENU.txt�еĹ۲���������������������
wieb=mean([IMUData.wibbx(1:RoughT/DeltaT),IMUData.wibby(1:RoughT/DeltaT),IMUData.wibbz(1:RoughT/DeltaT)])';%wieb=wibb-webb ����������b���e������wieb=wibb
VectorB=[gb,wieb,cross(gb,wieb)];
Tbn=VectorN'\VectorB';
[ psi,theta,gama,~ ] = TbnToAttitude( Tbn );
AttitudeIni=[psi;theta;gama];
%% �ߵ�����Vn׼��
[Q,FlagFun]=AttiToQuater(AttitudeIni);


%% ����׼
for i=RoughT/DeltaT:nepoch
    
x=[DeltaVx;DeltaVy;Phix;Phiy;Phiz];
F=[0,2]
Dotx=F*x+w;





