function f=benchmark_func(x,func_num, ~)

persistent fhd f_bias local_func_num

% benchmark_func.m is the main function for 25 test functions, all minimize
% problems
% e.g. f=benchmark_func(x,func_num)
% x is the variable, f is the function value
% func_num is the function num,

%       25 TEST FUCNTIONS
% 	    Unimodal Functions (5):
% 1.    Shifted Sphere Function 					                Bounds[-100,100]	f_bias=-450
% 2.	Shifted Schwefel's Problem 1.2				            	Bounds[-100,100]	f_bias=-450
% 3.	Shifted Rotated High Conditioned Elliptic Function			Bounds[-100,100]	f_bias=-450
% 4.	Shifted Schwefel's Problem 1.2 with Noise in Fitness 		Bounds[-100,100]	f_bias=-450
% 5.	Schwefel's  Problem 2.6 with Global Optimum on Bounds		Bounds[-100,100]	f_bias=-310
%
% 	    Multimodal Functions (20):
% 	    Basic Functions (7):
% 6.	Shifted Rosenbrock's  Function					            Bounds[-100,100]	f_bias=390
% 7.	Shifted Rotated Griewank's  Function without Bounds	        Initilization Range [0, 600]	f_bias=-180
% 8.	Shifted Rotated Ackley's  Function with Global Optimum on Bounds	Bounds[-32,32]	f_bias=-140
% 9.	Shifted Rastrigin's  Function 					            Bounds[-5,5]	    f_bias=-330
% 10.	Shifted Rotated Rastrigin's  Function 				        Bounds[-5,5]	    f_bias=-330
% 11.	Shifted Rotated Weierstrass Function 				        Bounds[-0.5,0.5]	f_bias=90
% 12.	Schwefel's  Problem 2.13					                Bounds[-100,100]	f_bias=-460
% 	    Expanded Functions (2):
% 13.	Expanded Extended Griewank's  plus Rosenbrock's  Function (F8F2)	Bounds[-3,1]	f_bias=-130
% 14.	Expanded Rotated Extended Scaffe's  F6 				        Bounds[-100,100]	f_bias=-300
% 	    Hybrid Composition Functions (11):
% 15.	Hybrid Composition Function 1				                Bounds[-5,5]	    f_bias= 120
% 16.	Rotated Hybrid Composition Function 1				        Bounds[-5,5]	    f_bias= 120
% 17.	Rotated Hybrid Composition Function 1 with Noise in Fitness		Bounds[-5,5]	f_bias= 120
% 18.	Rotated Hybrid Composition Function 2			        	Bounds[-5,5]	    f_bias=10
% 19.	Rotated Hybrid Composition Function 2 with a Narrow Basin for the Global Optimum	Bounds[-5,5]]	f_bias=10
% 20.	Rotated Hybrid Composition Function 2 with the Global Optimum on the Bounds		Bounds[-5,5]	f_bias=10
% 21.	Rotated Hybrid Composition Function 3						Bounds[-5,5]    	f_bias=360
% 22.	Rotated Hybrid Composition Function 3 with High Condition Number Matrix		Bounds[-5,5]	f_bias=360
% 23.	Non-Continuous Rotated Hybrid Composition Function 3		Bounds[-5,5]    	f_bias=360
% 24.	Rotated Hybrid Composition Function 4				        Bounds[-5,5]	    f_bias=260
% 25.	Rotated Hybrid Composition Function 4 without Bounds	    Intilization Range[-2,5]	f_bias=260
%
%J. J. Liang & P. N. Suganthan   2005.Feb 18

if isempty(local_func_num) || local_func_num ~= func_num
    local_func_num = func_num;
    if func_num==1 
        fhd=str2func('sphere_func'); %[-100,100]
    elseif func_num==2 
        fhd=str2func('schwefel_102'); %[-100,100]
    elseif func_num==3 
        fhd=str2func('high_cond_elliptic_rot_func'); %[-100,100]
    elseif func_num==4
        fhd=str2func('schwefel_102_noise_func'); %[-100,100]
    elseif func_num==5 
        fhd=str2func('schwefel_206'); %[no bound],initial[-100,100];
    elseif func_num==6 
        fhd=str2func('rosenbrock_func'); %[-100,100]
    elseif func_num==7
        fhd=str2func('griewank_rot_func'); %[-600,600]
    elseif func_num==8 
        fhd=str2func('ackley_rot_func'); %[-32,32]
    elseif func_num==9 
        fhd=str2func('rastrigin_func'); %[-5,5]
    elseif func_num==10 
        fhd=str2func('rastrigin_rot_func'); %[-5,5]
    elseif func_num==11 
        fhd=str2func('weierstrass_rot'); %[-0.5,0.5]
    elseif func_num==12
        fhd=str2func('schwefel_213'); %[-pi,pi]
    elseif func_num==13 
        fhd=str2func('EF8F2_func'); %[-3,1]
    elseif func_num==14
        fhd=str2func('E_ScafferF6_func'); %[-100,100]
    elseif func_num==15 
        fhd=str2func('hybrid_func1'); %[-5,5]
    elseif func_num==16 
        fhd=str2func('hybrid_rot_func1'); %[-5,5]
    elseif func_num==17
        fhd=str2func('hybrid_rot_func1_noise'); %[-5,5]
    elseif func_num==18
        fhd=str2func('hybrid_rot_func2'); %[-5,5]
    elseif func_num==19 
        fhd=str2func('hybrid_rot_func2_narrow'); %[-5,5]
    elseif func_num==20 
        fhd=str2func('hybrid_rot_func2_onbound'); %[-5,5]
    elseif func_num==21 
        fhd=str2func('hybrid_rot_func3'); %[-5,5]
    elseif func_num==22 
        fhd=str2func('hybrid_rot_func3_highcond'); %[-5,5]
    elseif func_num==23 
        fhd=str2func('hybrid_rot_func3_noncont'); %[-5,5]
    elseif func_num==24 
        fhd=str2func('hybrid_rot_func4'); %[-5,5]
    elseif func_num==25 
        fhd=str2func('hybrid_rot_func4'); %[-5,5]
    end
    load fbias_data;
end

f=feval(fhd,x)+f_bias(func_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%Unimodal%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	1.Shifted Sphere Function
function fit=sphere_func(x)

persistent o
[ps,D]=size(x);
if isempty(o)
    load sphere_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-100+200*rand(1,D);
    end
   
end
% %%x=x-repmat(o,ps,1);
fit=sum(x.^2,2);

% 	2.Shifted Schwefel's Problem 1.2
function f=schwefel_102(x)

persistent o
[ps,D]=size(x);
if isempty(o)
    load schwefel_102_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-100+200*rand(1,D);
    end
   
end
% %%x=x-repmat(o,ps,1);
f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end

% 	3.Shifted Rotated High Conditioned Elliptic Function
function fit=high_cond_elliptic_rot_func(x)

persistent o M
[ps,D]=size(x);
if isempty(o)
    load high_cond_elliptic_rot_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-100+200*rand(1,D);
    end
    if D==2,load elliptic_M_D2,
    elseif D==10,load elliptic_M_D10,
    elseif D==30,load elliptic_M_D30,
    elseif D==50,load elliptic_M_D50,
    else
        A=normrnd(0,1,D,D);[M,~]=cGram_Schmidt(A);
    end
   
end
%%%x=x-repmat(o,ps,1);
x=x*M;
a=1e+6;
fit=0;
for i=1:D
    fit=fit+a.^((i-1)/(D-1)).*x(:,i).^2;
end

% 	4.Shifted Schwefel's Problem 1.2 with Noise in Fitness
function f=schwefel_102_noise_func(x)

persistent o
[ps,D]=size(x);
if isempty(o)
    load schwefel_102_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-100+200*rand(1,D);
    end
    
end
% %%x=x-repmat(o,ps,1);
f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end
f=f.*(1+0.4.*abs(normrnd(0,1,ps,1)));

% 	5.Schwefel's Problem 2.6
function f=schwefel_206(x)%after Fletcher and Powell

persistent A B o
[ps,D]=size(x);
if isempty(o)
    
    load schwefel_206_data
    if length(o)>=D
        A=A(1:D,1:D);o=o(1:D);
    else
        o=-100+200*rand(1,D);
        A=round(-100+2*100.*rand(D,D));
        while det(A)==0
            A=round(-100+2*100.*rand(D,D));
        end
    end
    % o(1:ceil(D/4))=-100;o(max(floor(0.75*D),1):D)=100;
    o = zeros(1, D);
    B=A*o';
end
f = zeros(ps, 1);
for i=1:ps
    f(i,1)=max(abs(A*(x(i,:)')-B));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%Multimodal%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	6.Shifted Rosenbrock's Function
function f=rosenbrock_func(x)
persistent o
[ps,D]=size(x);
if isempty(o)
    load rosenbrock_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-90+180*rand(1,D);
    end

end
% x=x-repmat(o,ps,1)+1;
x = x + 1;
f=sum(100.*(x(:,1:D-1).^2-x(:,2:D)).^2+(x(:,1:D-1)-1).^2,2);

% 	7.Shifted Rotated Griewank's Function
function f=griewank_rot_func(x)

persistent o M
[ps,D]=size(x);
if isempty(o)
    load griewank_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-600+1200*rand(1,D);
    end
    c=3;
    if D==2,load griewank_M_D2,
    elseif D==10,load griewank_M_D10,
    elseif D==30,load griewank_M_D30,
    elseif D==50,load griewank_M_D50,
    else
        M=rot_matrix(D,c);
        M=M.*(1+0.3.*normrnd(0,1,D,D));
    end
    o=o(1:D);
end
% %%x=x-repmat(o,ps,1);
x=x*M;
f=1;
for i=1:D
    f=f.*cos(x(:,i)./sqrt(i));
end
f=sum(x.^2,2)./4000-f+1;

% 	8.Shifted Rotated Ackley's Function with Global Optimum on Bounds
function f=ackley_rot_func(x)

persistent o M
[ps,D]=size(x);
if isempty(o)
    load ackley_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-30+60*rand(1,D);
    end
    o(2.*[1:floor(D/2)]-1)=-32;
    c=100;
    if D==2,load ackley_M_D2,
    elseif D==10,load ackley_M_D10,
    elseif D==30,load ackley_M_D30,
    elseif D==50,load ackley_M_D50,
    else
        M=rot_matrix(D,c);
    end
 
end
%%%x=x-repmat(o,ps,1);
x=x*M;
f=sum(x.^2,2);
f=20-20.*exp(-0.2.*sqrt(f./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);

% 	9.Shifted Rastrign's Function
function f=rastrigin_func(x)

persistent o
[ps,D]=size(x);
if isempty(o)
    load rastrigin_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-5+10*rand(1,D);
    end

end
%%x=x-repmat(o,ps,1);
f=sum(x .^2, 2) + sum(10 - 10 * cos(2 * pi * x), 2);

% 	10.Shifted Rotated Rastrign's Function
function f=rastrigin_rot_func(x)

persistent o M
[ps,D]=size(x);
if isempty(o)
    load rastrigin_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-5+10*rand(1,D);
    end
    c=2;
    if D==2,load rastrigin_M_D2,
    elseif D==10,load rastrigin_M_D10,
    elseif D==30,load rastrigin_M_D30,
    elseif D==50,load rastrigin_M_D50,
    else
        M=rot_matrix(D,c);
    end

end
%%x=x-repmat(o,ps,1);
x=x*M;
f=sum(x .^2, 2) + sum(10 - 10 * cos(2 * pi * x), 2);

% 	11.Shifted Rotated Weierstrass Function
function [f]=weierstrass_rot(x)

persistent o M
[ps,D]=size(x);
if isempty(o)
    load weierstrass_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-0.5+0.5*rand(1,D);
    end
    c=5;
    if D==2,load weierstrass_M_D2,
    elseif D==10,load weierstrass_M_D10,
    elseif D==30,load weierstrass_M_D30,
    elseif D==50,load weierstrass_M_D50,
    else
        M=rot_matrix(D,c);
    end
    
end
%%x=x-repmat(o,ps,1);
x=x*M;
x=x+0.5;
a = 0.5;%0<a<1
b = 3;
kmax = 20;
[ps,D]=size(x);

c1(1, 1, 1:kmax+1) = a.^(0:kmax);
c2(1, 1, 1:kmax+1) = 2*pi*b.^(0:kmax);
c=-w(0.5,c1,c2);
f = sum(w(x, c1, c2), 2) + c*D;


%--------------------------------

% 	12.Schwefel's Problem 2.13
function f=schwefel_213(x)%after Fletcher and Powell

persistent a b A alpha
[ps,D]=size(x);
if isempty(alpha)
    
    load schwefel_213_data
    if length(alpha)>=D
        alpha=alpha(1:D);a=a(1:D,1:D);b=b(1:D,1:D);
    else
        alpha=-3+6*rand(1,D);
        a=round(-100+200.*rand(D,D));
        b=round(-100+200.*rand(D,D));
    end
    alpha = zeros(1, D);
    alpha=repmat(alpha,D,1);
    A=sum(a.*sin(alpha)+b.*cos(alpha),2);
end

f = sum((bsxfun(@minus, a * sin(x)' + b * cos(x)', A)') .^ 2, 2);


% 	13. Expanded Extended Griewank's plus Rosenbrock's Function (F8F2)
function fit=EF8F2_func(x)
%-3,1

persistent  o
[ps,D]=size(x);
if isempty(o)
    load EF8F2_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-1+1*rand(1,D);
    end
    
end
% x=x-repmat(o,ps,1)+1;
x = x + 1;
fit=0;
for i=1:(D-1)
    fit=fit+F8F2(x(:,[i,i+1]));
end
fit=fit+F8F2(x(:,[D,1]));

function f=F8F2(x)
f2=100.*(x(:,1).^2-x(:,2)).^2+(1-x(:,1)).^2;
f=1+f2.^2./4000-cos(f2);

% ---------------------------------------------------------------
% 	14. Expanded Rotated Extended Scaffer's F6
function f=E_ScafferF6_func(x)

persistent  o M
fhd=str2func('ScafferF6');
[ps,D]=size(x);
if isempty(o)
    load E_ScafferF6_func_data
    if length(o)>=D
        o=o(1:D);
    else
        o=-100+200*rand(1,D);
    end
    
    c=3;
    if D==2,load E_ScafferF6_M_D2,
    elseif D==10,load E_ScafferF6_M_D10,
    elseif D==30,load E_ScafferF6_M_D30,
    elseif D==50,load E_ScafferF6_M_D50,
    else
        M=rot_matrix(D,c);
    end
end
%%x=x-repmat(o,ps,1);
x=x*M;
f=0;
for i=1:(D-1)
    f=f+feval(fhd,(x(:,i:i+1)));
end
f=f+feval(fhd,x(:,[D,1]));

function f=ScafferF6(x)
f=0.5+(sin(sqrt(x(:,1).^2+x(:,2).^2)).^2-0.5)./(1+0.001*(x(:,1).^2+x(:,2).^2)).^2;
%---------------------------------------------------
%   15.Hybrid Composition Function 1
function fit=hybrid_func1(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func1_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    func = cell(1, fun_num);
    func{1}=str2func('frastrigin');
    func{2}=str2func('frastrigin');
    func{3}=str2func('fweierstrass');
    func{4}=str2func('fweierstrass');
    func{5}=str2func('fgriewank');
    func{6}=str2func('fgriewank');
    func{7}=str2func('fackley');
    func{8}=str2func('fackley');
    func{9}=str2func('fsphere');
    func{10}=str2func('fsphere');
    bias=((1:fun_num)-1).*100;
    sigma=ones(1,fun_num);
    lamda=[1; 1; 10; 10; 5/60; 5/60; 5/32; 5/32; 5/100; 5/100];
    lamda=repmat(lamda,1,D);
    M = mat2cell(repmat(diag(ones(1, D)), 1, fun_num), D, D * ones(1, fun_num));
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%---------------------------------------------------------------------
%   16.Rotated Hybrid Composition Function 1
function fit=hybrid_rot_func1(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func1_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    func = cell(1, fun_num);
    func{1}=str2func('frastrigin');
    func{2}=str2func('frastrigin');
    func{3}=str2func('fweierstrass');
    func{4}=str2func('fweierstrass');
    func{5}=str2func('fgriewank');
    func{6}=str2func('fgriewank');
    func{7}=str2func('fackley');
    func{8}=str2func('fackley');
    func{9}=str2func('fsphere');
    func{10}=str2func('fsphere');
    bias=((1:fun_num)-1).*100;
    sigma=ones(1,fun_num);
    lamda=[1; 1; 10; 10; 5/60; 5/60; 5/32; 5/32; 5/100; 5/100];
    lamda=repmat(lamda,1,D);
    c = 2 * ones(1, fun_num);
    if D==2,load hybrid_func1_M_D2,
    elseif D==10,load hybrid_func1_M_D10,
    elseif D==30,load hybrid_func1_M_D30,
    elseif D==50,load hybrid_func1_M_D50,
    else
        M = arrayfun(@(cc) rot_matrix(D, cc), c, 'UniformOutput', false);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%----------------------------------------------------------------
%   17.	Rotated Hybrid Composition Function 1 with Noise in Fitness
function fit=hybrid_rot_func1_noise(x)
[ps,D]=size(x);
fit=hybrid_rot_func1(x).*(1+0.2.*abs(normrnd(0,1,ps,1)));
%----------------------------------------------------------------
%   18.	Rotated Hybrid Composition Function 2
function fit=hybrid_rot_func2(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func2_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=0;
    func = cell(1, fun_num);
    func{1}=str2func('fackley');
    func{2}=str2func('fackley');
    func{3}=str2func('frastrigin');
    func{4}=str2func('frastrigin');
    func{5}=str2func('fsphere');
    func{6}=str2func('fsphere');
    func{7}=str2func('fweierstrass');
    func{8}=str2func('fweierstrass');
    func{9}=str2func('fgriewank');
    func{10}=str2func('fgriewank');
    bias=((1:fun_num)-1).*100;
    sigma=[1 2 1.5 1.5 1 1 1.5 1.5 2 2];
    lamda=[2*5/32; 5/32; 2*1; 1; 2*5/100; 5/100; 2*10; 10; 2*5/60; 5/60];
    lamda=repmat(lamda,1,D);
    c=[2 3 2 3 2 3 20 30 200 300];
    if D==2,load hybrid_func2_M_D2,
    elseif D==10,load hybrid_func2_M_D10,
    elseif D==30,load hybrid_func2_M_D30,
    elseif D==50,load hybrid_func2_M_D50,
    else
        M = arrayfun(@(cc) rot_matrix(D, cc), c, 'UniformOutput', false);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%----------------------------------------------------------------
%   19.	Rotated Hybrid Composition Function 2 with a Narrow Basin for the Global Optimum
function fit=hybrid_rot_func2_narrow(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func2_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=0;
    func = cell(1, fun_num);
    func{1}=str2func('fackley');
    func{2}=str2func('fackley');
    func{3}=str2func('frastrigin');
    func{4}=str2func('frastrigin');
    func{5}=str2func('fsphere');
    func{6}=str2func('fsphere');
    func{7}=str2func('fweierstrass');
    func{8}=str2func('fweierstrass');
    func{9}=str2func('fgriewank');
    func{10}=str2func('fgriewank');
    bias=((1:fun_num)-1).*100;
    sigma=[0.1 2 1.5 1.5 1 1 1.5 1.5 2 2];
    lamda=[0.1*5/32; 5/32; 2*1; 1; 2*5/100; 5/100; 2*10; 10; 2*5/60; 5/60];
    lamda=repmat(lamda,1,D);
    c=[2 3 2 3 2 3 20 30 200 300];
    if D==2,load hybrid_func2_M_D2,
    elseif D==10,load hybrid_func2_M_D10,
    elseif D==30,load hybrid_func2_M_D30,
    elseif D==50,load hybrid_func2_M_D50,
    else
        M = arrayfun(@(cc) rot_matrix(D, cc), c, 'UniformOutput', false);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%----------------------------------------------------------------
%   20.	Rotated Hybrid Composition Function 2 with the Global Optimum on the Bounds
function fit=hybrid_rot_func2_onbound(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func2_data % saved the predefined optima,
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=0;
    o(1,2.*[1:floor(D/2)])=5;
    func = cell(1, fun_num);
    func{1}=str2func('fackley');
    func{2}=str2func('fackley');
    func{3}=str2func('frastrigin');
    func{4}=str2func('frastrigin');
    func{5}=str2func('fsphere');
    func{6}=str2func('fsphere');
    func{7}=str2func('fweierstrass');
    func{8}=str2func('fweierstrass');
    func{9}=str2func('fgriewank');
    func{10}=str2func('fgriewank');
    bias=((1:fun_num)-1).*100;
    sigma=[1 2 1.5 1.5 1 1 1.5 1.5 2 2];
    lamda=[2*5/32; 5/32; 2*1; 1; 2*5/100; 5/100; 2*10; 10; 2*5/60; 5/60];
    lamda=repmat(lamda,1,D);
    c=[2 3 2 3 2 3 20 30 200 300];
    if D==2,load hybrid_func2_M_D2,
    elseif D==10,load hybrid_func2_M_D10,
    elseif D==30,load hybrid_func2_M_D30,
    elseif D==50,load hybrid_func2_M_D50,
    else
        M = arrayfun(@(cc) rot_matrix(D, cc), c, 'UniformOutput', false);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%-------------------------------------------------
%    21.Rotated Hybrid Composition Function 3
function fit=hybrid_rot_func3(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func3_data % saved the predefined optima, a 10*1000 matrix;
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    func = cell(1, fun_num);
    func{1}=str2func('fE_ScafferF6');
    func{2}=str2func('fE_ScafferF6');
    func{3}=str2func('frastrigin');
    func{4}=str2func('frastrigin');
    func{5}=str2func('fEF8F2');
    func{6}=str2func('fEF8F2');
    func{7}=str2func('fweierstrass');
    func{8}=str2func('fweierstrass');
    func{9}=str2func('fgriewank');
    func{10}=str2func('fgriewank');
    bias=((1:fun_num)-1).*100;
    sigma=[1,1,1,1,1,2,2,2,2,2];
    lamda=[5*5/100; 5/100; 5*1; 1; 5*1; 1; 5*10; 10; 5*5/200; 5/200];
    lamda=repmat(lamda,1,D);
    c=ones(1,D);
    if D==2,load hybrid_func3_M_D2,
    elseif D==10,load hybrid_func3_M_D10,
    elseif D==30,load hybrid_func3_M_D30,
    elseif D==50,load hybrid_func3_M_D50,
    else
        M = arrayfun(@(cc) cGram_Schmidt(normrnd(0, 1, D, D)), 1:fun_num, 'UniformOutput', false);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%-----------------------------------------
%   22.	Rotated Hybrid Composition Function 3 with High Condition Number Matrix
function fit=hybrid_rot_func3_highcond(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func3_data % saved the predefined optima, a 10*1000 matrix;
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    func = cell(1, fun_num);
    func{1}=str2func('fE_ScafferF6');
    func{2}=str2func('fE_ScafferF6');
    func{3}=str2func('frastrigin');
    func{4}=str2func('frastrigin');
    func{5}=str2func('fEF8F2');
    func{6}=str2func('fEF8F2');
    func{7}=str2func('fweierstrass');
    func{8}=str2func('fweierstrass');
    func{9}=str2func('fgriewank');
    func{10}=str2func('fgriewank');
    bias=((1:fun_num)-1).*100;
    sigma=[1,1,1,1,1,2,2,2,2,2];
    lamda=[5*5/100; 5/100; 5*1; 1; 5*1; 1; 5*10; 10; 5*5/200; 5/200];
    lamda=repmat(lamda,1,D);
    c=[10 20 50 100 200 1000 2000 3000 4000 5000];
    if D==2,load hybrid_func3_HM_D2,
    elseif D==10,load hybrid_func3_HM_D10,
    elseif D==30,load hybrid_func3_HM_D30,
    elseif D==50,load hybrid_func3_HM_D50,
    else
        M = arrayfun(@(cc) rot_matrix(D, cc), c, 'UniformOutput', false);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%-----------------------------------------
%   23.	Non-Continuous Rotated Hybrid Composition Function 3
function fit=hybrid_rot_func3_noncont(x)

persistent  o
[ps,D]=size(x);
if isempty(o)
    load hybrid_func3_data % saved the predefined optima, a 10*1000 matrix;
    o=o(1,1:D);
end
oo=repmat(o,ps,1);
x=(abs(x-oo)<0.5).*x+(abs(x-oo)>=0.5).*(round(x.*2)./2);
fit=hybrid_rot_func3(x);
%-----------------------------------------
%   24.	Rotated Hybrid Composition Function 4
function fit=hybrid_rot_func4(x)

persistent  fun_num func o sigma lamda bias M
if isempty(o)
    [ps,D]=size(x);
    
    fun_num=10;
    load hybrid_func4_data % saved the predefined optima, a 10*1000 matrix;
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    func = cell(1, fun_num);
    func{1}=str2func('fweierstrass');
    func{2}=str2func('fE_ScafferF6');
    func{3}=str2func('fEF8F2');
    func{4}=str2func('fackley');
    func{5}=str2func('frastrigin');
    func{6}=str2func('fgriewank');
    func{7}=str2func('fE_ScafferF6_noncont');
    func{8}=str2func('frastrigin_noncont');
    func{9}=str2func('felliptic');
    func{10}=str2func('fsphere_noise');
    bias=((1:fun_num)-1).*100;
    sigma=[2,2,2,2,2,2,2,2,2,2];
    lamda=[10; 5/20; 1; 5/32; 1; 5/100 ; 5/50; 1; 5/100; 5/100; ];
    lamda=repmat(lamda,1,D);
    c=[100 50 30 10 5 5 4 3 2 2];
    if D==2,load hybrid_func4_M_D2,
    elseif D==10,load hybrid_func4_M_D10,
    elseif D==30,load hybrid_func4_M_D30,
    elseif D==50,load hybrid_func4_M_D50,
    else
        M = arrayfun(@(cc) rot_matrix(D, cc), c, 'UniformOutput', false);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%----------------------------------
function fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M)
[ps,D]=size(x);
weight = reshape(exp(-sum((repmat(x, 1, 1, length(sigma)) - repmat(reshape(o',1, size(o, 2), size(o, 1)), size(x, 1), 1, 1)) .^2 , 2)...
    ./ repmat(reshape(2 * D * (sigma .^2), 1, 1, length(sigma)),size(x, 1), 1, 1)), size(x, 1), fun_num);
weight = bsxfun(@(a, b) (a == b) .* a + (a ~= b) .* a .* (1 - b .^ 10), weight, max(weight, [], 2));
weight=weight./repmat(sum(weight, 2),1,fun_num);
fit=0;
for i=1:fun_num
    oo=repmat(o(i,:),ps,1);
    f = feval(func{i}, ((x-oo)./repmat(lamda(i,:),ps,1))*M{i});
    x1=5*ones(1,D);
    f1 = feval(func{i}, (x1./lamda(i,:))*M{i});
    fit1=2000.*f./f1;
    fit=fit+weight(:, i).*(fit1+bias(i));
end
%-------------------------------------------------
%basic functions

function f=fsphere(x)
%Please notice there is no use to rotate a sphere function, with rotation
%here just for a similar structure as other functions and easy programming
[ps,D]=size(x);
f=sum(x.^2,2);
%--------------------------------
function f=fsphere_noise(x)
[ps,D]=size(x);
f=sum(x.^2,2).*(1+0.1.*normrnd(0,1,ps,1));
%--------------------------------
function f=fgriewank(x)
[ps,D]=size(x);
f=1;
for i=1:D
    f=f.*cos(x(:,i)./sqrt(i));
end
f=sum(x.^2,2)./4000-f+1;
%--------------------------------
function f=fackley(x)
[ps,D]=size(x);
f=sum(x.^2,2);
f=20-20.*exp(-0.2.*sqrt(f./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);
%--------------------------------
function f=frastrigin(x)
[ps,D]=size(x);
f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
%--------------------------------
function f=frastrigin_noncont(x)
[ps,D]=size(x);
x=(abs(x)<0.5).*x+(abs(x)>=0.5).*(round(x.*2)./2);
f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
%--------------------------------
function [f]=fweierstrass(x)
[ps,D]=size(x);
x=x+0.5;
a = 0.5;
b = 3;
kmax = 20;
c1(1, 1, 1:kmax+1) = a.^(0:kmax);
c2(1, 1, 1:kmax+1) = 2*pi*b.^(0:kmax);
c=-w(0.5,c1,c2);
f = sum(w(x, c1, c2), 2) + c*D;

function y = w(x,c1,c2)
[ps,D]=size(x);
y = sum(repmat(c1, ps, D, 1) .* ...
    cos(repmat(c2, ps, D, 1) .* repmat(x, 1, 1, length(c1))), 3);

%--------------------------------
function f=fE_ScafferF6(x)
fhd=str2func('ScafferF6');
[ps,D]=size(x);

f=0;
for i=1:(D-1)
    f=f+feval(fhd,(x(:,i:i+1)));
end
f=f+feval(fhd,x(:,[D,1]));
%--------------------------------
function f=fE_ScafferF6_noncont(x)
fhd=str2func('ScafferF6');
[ps,D]=size(x);
x=(abs(x)<0.5).*x+(abs(x)>=0.5).*(round(x.*2)./2);
f=0;
for i=1:(D-1)
    f=f+feval(fhd,(x(:,i:i+1)));
end
f=f+feval(fhd,x(:,[D,1]));
%------------------------------
function f=fEF8F2(x)
[ps,D]=size(x);
f=0;
for i=1:(D-1)
    f=f+F8F2(x(:,[i,i+1]));
end
f=f+F8F2(x(:,[D,1]));

%--------------------------------
function f=fschwefel_102(x)
[ps,D]=size(x);
f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end
%--------------------------------
function f=felliptic(x)
[ps,D]=size(x);
a=1e+6;
f=0;
for i=1:D
    f=f+a.^((i-1)/(D-1)).*x(:,i).^2;
end
%--------------------------------
% classical Gram Schmid
function [q,r] = cGram_Schmidt (A)
% computes the QR factorization of $A$ via
% classical Gram Schmid
%
[n,m] = size(A);
q = A;
for j=1:m
    for i=1:j-1
        r(i,j) = q(:,j)'*q(:,i);
    end
    for i=1:j-1
        q(:,j) = q(:,j) -  r(i,j)*q(:,i);
    end
    t =  norm(q(:,j),2 ) ;
    q(:,j) = q(:,j) / t ;
    r(j,j) = t  ;
end

function M=rot_matrix(D,c)
A=normrnd(0,1,D,D);
P=cGram_Schmidt(A);
A=normrnd(0,1,D,D);
Q=cGram_Schmidt(A);
u=rand(1,D);
D=c.^((u-min(u))./(max(u)-min(u)));
D=diag(D);
M=P*D*Q;
