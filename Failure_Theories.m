n1=input('Enter the deciding criteria for ductile or brittle (1 for entering true strain, 2 for entering it yourself ');
Sx =input('Enter the value of Sx');
Sy =input('Enter the value of Sy');
Txy =input('Enter the value of Txy');

if n1==1
    epsilonf=input('Enter the value of strain'); %to find out whether ductile or brittle
    if epsilonf>=0.05
         ch='d';
    else
        ch='b';
    end
elseif n1==2
    prompt = 'enter d for ductile and b for brittle' ;
    ch=input(prompt, 's');
end
%Conservative for design purposes (less precise) and Non Conservative for
%better failure predictor (more precise)
switch ch
    case 'b'
        Sut=input('Enter the value of Sut');
        Suc=input('Enter the value of Suc');
        n2=input('Enter whether Conservative(1) or Non-Conservative(2)');
        if n2==1
            Brittle_Columb_Mohr_Theory(Sx,Sy,Txy,Sut,Suc);
        else
            Modified_Mohr_Theory(Sx,Sy,Txy,Sut,Suc);
        end
    case 'd'
        Syt=input('Enter the value of Syt');
        Syc=input('Enter the value of Syc');
        n2=input('Enter whether Conservative(1) or Non-Conservative(2)');
        if Syt==Syc
            if n2==1
                Max_Shear_Stress_Theory(Sx,Sy,Txy,Syt,Syc);
            else
                DE(Sx,Sy,Txy,Syt,Syc);
            end
        else
            Ductile_Columb_Mohr_Theory(Sx,Sy,Txy);
        end
end

function n =Max_Shear_Stress_Theory(Sx,Sy,Txy,Syt,Syc)

Sa=(Sx+Sy)/2+(((Sx-Sy)/2)^2+Txy^2)^0.5;
Sb=(Sx+Sy)/2-(((Sx-Sy)/2)^2+Txy^2)^0.5;

if Sa>=Sb>=0
    S1=Sa;
    S3=0;
elseif Sa>=0>=Sb
        S1=Sa;
        S3=Sb;
else
    S1=0;
    S3=Sb;
end

Tmax=(S1-S3)/2;
n=(Syt/2)/Tmax;
n=abs(n);
fprintf('%d',n)
end

function n = Modified_Mohr_Theory(Sx,Sy,Txy,Sut,Suc)
Sa=(Sx+Sy)/2+(((Sx-Sy)/2)^2+Txy^2)^0.5;
Sb=(Sx+Sy)/2-(((Sx-Sy)/2)^2+Txy^2)^0.5;


if Sa>=Sb>=0
    n= Sut/Sa;
elseif Sa>=0>=Sb
    if -1<=(Sa/Sb)<=1
         n=Sut/Sa;
    else
        n=1/((((Sut-Suc)*Sa)/Sut*Suc)-(Sb/Suc));
    end
else
    n=-Suc/Sb;
end
n=abs(n);
fprintf('%d',n);
end

function n = Brittle_Columb_Mohr_Theory(Sx,Sy,Txy)
Sa=(Sx+Sy)/2+(((Sx-Sy)/2)^2+Txy^2)^0.5;
Sb=(Sx+Sy)/2-(((Sx-Sy)/2)^2+Txy^2)^0.5;

if Sa>=Sb>=0
    n=Sut/Sa;
elseif Sa>=0>=Sb
        n=1/((Sa/Sut)-(Sb/Suc));
else
    n=-Suc/Sb;
end
n=abs(n);
fprintf('%d',n)
end

function n = DE(Sx,Sy,Txy,Syt,Syc)
S=(Sx^2-Sx*Sy+Sy^2+3*Txy^2)^0.5
n=Syt/S;
n=abs(n);
fprintf('%d',n)
end

function n = Ductile_Columb_Mohr_Theory(Sx,Sy,Txy)

Sa=(Sx+Sy)/2+(((Sx-Sy)/2)^2+Txy^2)^0.5;
Sb=(Sx+Sy)/2-(((Sx-Sy)/2)^2+Txy^2)^0.5;

if Sa>=Sb>=0
    S1=Sa;
    S3=0;
elseif Sa>=0>=Sb
        S1=Sa;
        S3=Sb;
else
    S1=0;
    S3=-Sb;
end

n=1/((S1/Syt)-(S3/Syc));
n=abs(n);
fprintf('%d',n)
end
