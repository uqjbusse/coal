%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INBUILT MATLAB FUNCTION
%Problem here is that this function works with nodes, so first the binary
%matrix needs to be reduced to the nodes that represent the end points of
%each fracture. This can be achieved by defining them having just one
%neighbour

% Programme  : Maths for Systems
% Date       : 2011-05-11
% Session    : Optimisation
% Exercise   : SHORTEST PATH PROBLEM
% By         : Richard Craig
%
% Description:
% This program generates a matrix representing connections between nodes.
% Values for the NodeID(Source), NodeID(Destination) and weight of the
% connection (ie Distance) are given. The shortest route through the node
% network is found using the Bioinformatics Toolbox™ function
% graphshortestpath that provides the path and overall connection value.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Close figures and clear all previous variables
clc;close;clear;

%% Create a node matrix [NodeSource,NodeDestination,ConnectionWeight]

% mNodes = [...
% 1,2,14;       1,3,1;      2,7,15;     2,5,8;      3,4,7;      3,6,10;
% 4,8,20;       5,7,10;     5,6,10;     6,9,15;     7,10,13;    7,9,14;
% 8,11,7;       9,13,12;    9,11,14;   10,14,15;   10,12,8;    11,15,16;
% 11,16,14;    12,14,10;   12,13,6;    13,15,7;    14,19,14;   15,17,17;
% 15,18,25;    16,18,5;    17,19,6;    17,18,7;    18,19,8;    19,20,2;
% ];

%% Generate a matrix
% N-by-N sparse matrix that represents a graph. Nonzero entries in matrix G
% represent the weights of the edges.
% SizeX = SizeY = Number of Nodes


jpgFilename= ['StructurePre296.jpg'];
I= imread(jpgFilename); %707 x 733 pixel   
I = I (1:700,1:700);
I = im2bw (I, 0.9)

% nNet = sparse(nSource,nDestination,nWeight,SizeX,SizeY);
nNet = sparse (I);


%% Find the shortest path via a MATLAB function
% Using the Bioinformatics Toolbox™ function graphshortestpath the shortest
% path between [S = Starting Node] and [T = Final Node] can be found using
%[dist, path, pred] = graphshortestpath(G, S, T)
[dist, path, pred] = graphshortestpath(nNet,1,20);

%% Plot the Result
% Create the biograph object
bnNet = biograph(nNet,[],'ShowWeights','on');
% Create a graphics handle from the biograph object
h = view(bnNet);

% Mark the nodes and edges of the shortest path by colouring them red and
% increasing the line width.
set(h.Nodes(path),'Color',[1 0.5 0.5]); % Update Nodes(on the path) with a colour
edges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));%Get edge nodesID
set(edges,'LineColor',[1 0 0]); % Change line colour
set(edges,'LineWidth',1.5);     % Change line with

%% Display the Results
clc;%Clear the cmd window
disp(['Shortest path is via nodes ' num2str(path)]);
disp(['Distance of the shortest path is ' num2str(dist)]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

