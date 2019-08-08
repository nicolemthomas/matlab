%----------------------------------------------------------------------------
% To solve the ordinary differential equation given as            
%   u''= 1,  0 < x < 5                                                                        
%   u(0) = 0  and  u(5) = 0
% using 8 linear elements
%
% Variable descriptions                                                      
%   k = element matrix                                             
%   f = element vector
%   kk = system matrix                                             
%   ff = system vector                                                 
%   index = a vector containing system dofs associated with each element     
%   bcdof = a vector containing dofs associated with boundary conditions     
%   bcval = a vector containing boundary condition values associated with    
%           the dofs in 'bcdof'                                              
%----------------------------------------------------------------------------            

%------------------------------------
%  input data for control parameters
%------------------------------------
clc
clear
nel=8;                 % number of elements
nnel=2;                 % number of nodes per element
ndof=1;                 % number of dofs per node
nnode=9;                % total number of nodes in system
sdof=nnode*ndof;        % total system dofs  

%-----------------------------------------
%  input data for nodal coordinate values
%-----------------------------------------

gcoord(1)=0.0;  gcoord(2)=.625;  gcoord(3)=1.25;  gcoord(4)=1.875;
gcoord(5)=2.5;   gcoord(6)=3.125;   gcoord(7)=3.75;   gcoord(8)=4.375;   
gcoord(9)=5;   

%-----------------------------------------------------
%  input data for nodal connectivity for each element
%-----------------------------------------------------

nodes(1,1)=1;  nodes(1,2)=2;  nodes(2,1)=2;  nodes(2,2)=3;
nodes(3,1)=3;  nodes(3,2)=4;  nodes(4,1)=4;  nodes(4,2)=5;
nodes(5,1)=5;  nodes(5,2)=6;  nodes(6,1)=6;  nodes(6,2)=7;
nodes(7,1)=7;  nodes(7,2)=8;  nodes(8,1)=8;  nodes(8,2)=9;

%-----------------------------------------
%  input data for coefficients of the ODE
%-----------------------------------------

acoef=1;                % coefficient 'a' of the diff eqn
bcoef=0;               % coefficient 'b' of the diff eqn
ccoef=0;                % coefficient 'c' of the diff eqn    

%-------------------------------------
%  input data for boundary conditions
%-------------------------------------

bcdof(1)=1;             % first node is constrained
bcval(1)=0;             % whose described value is 0 
bcdof(2)=5;             % 5th node is constrained
bcval(2)=0;             % whose described value is 0

%-----------------------------------------
%  initialization of matrices and vectors
%-----------------------------------------

ff=zeros(sdof,1);       % initialization of system force vector
kk=zeros(sdof,sdof);    % initialization of system matrix
index=zeros(nnel*ndof,1);  % initialization of index vector

%-----------------------------------------------------------------
%  computation of element matrices and vectors and their assembly
%-----------------------------------------------------------------

for iel=1:nel           % loop for the total number of elements

nl=nodes(iel,1); nr=nodes(iel,2); % extract nodes for (iel)-th element
xl=gcoord(nl); xr=gcoord(nr);% extract nodal coord values for the element
eleng=xr-xl;            % element length
index=eldof(iel,nnel,ndof);% extract system dofs associated with element

k=elmatrix(acoef,bcoef,ccoef,eleng); % compute element matrix
f=elvector(xl,xr);                     % compute element vector
[kk,ff]=feassemble(kk,ff,k,f,index);  % assemble element matrices and vectors

end

%-----------------------------
%   apply boundary conditions
%-----------------------------

[kk,ff]=BC(kk,ff,bcdof,bcval);

%----------------------------
%  solve the matrix equation
%----------------------------

fsol=kk\ff;   

%---------------------
% exact solution
%---------------------


c1=-5;
c2=0;


% for i=1:nnode
% x=gcoord(i);
% esol(i)=exp(-0.5*x)*(c1*exp(1.5*x)+c2*exp(-1.5*x)); 
% end

dsize=eleng*nel;

x1 = linspace(0,5,100);
esol= x1.^2 - c1.*x1;  
% for i=1:101
% x=dsize/100*(i-1);
% esol(i)=(c1(i) + x1.*c2.*log(x1));
% end
% for i=1:101
% x=dsize/100*(i-1);
% esol(i)=exp(-0.5*x)*(c1*exp(1.5*x)+c2*exp(-1.5*x));  
% end

%------------------------------------
% print both exact and fem solutions
%------------------------------------

num=1:1:sdof;
% store=[num' fsol esol'];

%num=1:1:sdof;
%store=[num' fsol];
%num1=1:1:101;
%store=[num1' esol'];



hold on
plot ((num-1')/nel*dsize, fsol)
plot (x1, esol','r')
%plot ((num1-1')/100*dsize, esol','r')
xlabel ('x')
ylabel ('u')

legend('FEM','exact solution')

%---------------------------------------------------------------

