% Amir kabir University of Technology (Tehran Polytechnic)
% Computer & Information Technology Engineering Department
% Resource Allocation in Wireless Networks
% TPC-SR Simulation using MATLAB
% Programmer: SeyedHedayat Hosseini
% Date: December, 2015
% Matlab Version: R2014b
% ******************************************************** %

function [ D ] = Distance_Generator(NU,show_plot)
%Distance between the 2 users groups which uniformly distributed in 2 500*500 square
%Coverage area and 2 base stations that they are located in (250,250)& (750,250)

%BS1 & its users specifications
x1=rand(1,NU).*500;
y1=rand(1,NU).*500;
%x1=[50,150,400,450,-250];
%y1=[250,250,250,250,250];
BS1=[250,250];

%BS2 & its users specifications
x2=500 + rand(1,NU).*500;
y2=rand(1,NU).*500;
%x2=[550,600,700,850,950];
%y2=[250,250,250,250,250];
BS2=[750,250];

%BS3 & its users specifications
x3=rand(1,NU).*500;
y3=500+rand(1,NU).*500;

BS3=[250,750];

%BS4 & its users specifications
x4=500 + rand(1,NU).*500;
y4=500+rand(1,NU).*500;

BS4=[750,750];

%  vector of users location, Row 1 is X axis & Row 2 is Y axis of users
%  which indicate by matrix column indexes
Users=zeros(2,NU*4);
for i=1:NU
    Users(1,i)=x1(1,i);
    Users(2,i)=y1(1,i);
    Users(1,i+1*NU)=x2(1,i);
    Users(2,i+1*NU)=y2(1,i);
    Users(1,i+2*NU)=x3(1,i);
    Users(2,i+2*NU)=y3(1,i);
    Users(1,i+3*NU)=x4(1,i);
    Users(2,i+3*NU)=y4(1,i);
end

%BS allocation Vector
%Column 1 is X axis & Column 2 is Y axis of a Base station that
  %it allocate to user which indicate by matrix row indexes
BS=zeros(NU*4,2);
for i=1:NU*4
   if (Users(1,i)<500) %BS 1 || 3
       if (Users(2,i)<500)
           BS(i,1)=BS1(1,1);     %x
           BS(i,2)=BS1(1,2);     %y
       else
           BS(i,1)=BS3(1,1);     %x
           BS(i,2)=BS3(1,2);     %y
       end
    elseif (Users(2,i)<500) % BS 2 
         BS(i,1)=BS2(1,1);
         BS(i,2)=BS2(1,2);
       else
            BS(i,1)=BS4(1,1);
            BS(i,2)=BS4(1,2);
   end
end

%Distance matrix, According to Comments of Dr Rasti: distance between user 
  %of j and allocated Base Station to user of i
D = zeros(NU*4,NU*4);
for i=1:NU*4
    for j=1:NU*4
        D(i,j) = (((Users(1,j) - BS(i,1))^2) + ((Users(2,j) - BS(i,2))^2))^(0.5);
    end
end

%str='Users locations are :\n';
%for i=1:NU*2
%    str=strcat(str,sprintf('User %d : (%0.5f,%3.5f)  ',i,Users(1,i),Users(2,i)));
%end
%disp(str);

if (show_plot)
    figure(1);
    plot(Users(1,:),Users(2,:),'rO ');
    for i=1:NU*4
        text(Users(1,i)-10,Users(2,i)+30,int2str(i));
    end
    hold on;
    plot(BS(:,1),BS(:,2),'B* '),grid on, grid minor;
    title('Users & Base Stations');
    legend('Users','Base Stations');
    xlabel('X');
    ylabel('Y');
end
end