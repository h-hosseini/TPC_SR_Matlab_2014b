% Amir kabir University of Technology (Tehran Polytechnic)
% Computer & Information Technology Engineering Department
% Resource Allocation in Wireless Networks
% TPC-SR Simulation using MATLAB
% Programmer: SeyedHedayat Hosseini
% Date: December, 2015
% Matlab Version: R2014b
% ******************************************************** %

function [ Powers ] = Power_to_reach_feasibility( Nu,Pathgain,Gammahat,Noise )
% This fanction create a transmit power to reach the Target-SINR Vector
% A*P>=B ===> P>=B/A ===> P>=inv(A)*B

Powers_v=zeros(Nu*4,1); %Vertical vector
Powers=zeros(1,Nu*4); % Horizontal vector
A=ones(Nu*4,Nu*4);
B=zeros(Nu*4,1);

% We creat the matrix of A
for i=1:Nu*4
    for j=1:Nu*4
        if (i~=j)
            A(i,j)=(-1)*Gammahat(1,i)*Pathgain(i,j)/Pathgain(i,i);
        end
    end
end

% We creat the matrix of B
for i=1:Nu*4
    B(i,1)=Gammahat(1,i)*Noise/Pathgain(i,i);
end

Powers_v=inv(A)*B;

for i=1:Nu*4
    Powers(1,i)=Powers_v(i,1);


end

