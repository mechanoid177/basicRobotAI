%% Net for movement across circular trajectory
clc; clear; close all;
tic

%% Forming of training pairs
% Generating translational angular speed using normal distribution
V = normalDist(0.4, 0.7, 270);
omega = normalDist(-0.7, 0.7, 270);

t = 1;
tetaCircular = zeros(1, 60);
xCircular = zeros(1, 60);
yCircular = zeros(1, 60);
omegaCircular = zeros(1, 60);
a = 1;
for i=1:59
    xCircular(i+1) = xCircular(i) + V(a) * cos(omega(a) * t * pi / 180);
    yCircular(i+1) = yCircular(i) + V(a) * sin(omega(a) * t * pi / 180);
    omega(a+1) = omega(a) - 6;
    omegaCircular(i) = omega(a+1);
    tetaCircular(i+1) = tetaCircular(i) + omega(a) * t;
    a = a + 1;
end

figure('Name','Circular trajectory')
plot(xCircular,yCircular,'Marker','o','MarkerFaceColor','red')
title('Circular trajectory')
xlabel('X') 
ylabel('Y')

input = ([xCircular; yCircular; tetaCircular]);
output = ([V(211:270); omegaCircular]);

%% Net forming
% Feedforward artificial neural network
% Name: netCircular
% Type: feedforward artificial neural network with backpropagation
% algorithm with one hidden layer with 8 neurons
% Transfer function: Log-sigmoid transfer function (tansig)
% Training algorithm: Levenberg–Marquardt algorithm (trainlm)
% Learning function: Gradient descent with momentum weight and bias 
% learning function (learngdm)

netCircular = newff(input, output, [12], {'logsig'}, 'trainlm', 'learngdm');

%% Net parameter settings
% Epochs between displays
netCircular.trainParam.show = 50;

% Learning rate
netCircular.trainParam.lr = 0.2;

% Parameter for Hessian matrix
netCircular.trainParam.mu = 0.5;

% Max number of iterations
netCircular.trainParam.epochs = 1000000;

% Error
netCircular.trainParam.goal = 1e-12;

% Allowed number of misses
netCircular.trainParam.max_fail = 400;

%% Net training
netCircular = train(netCircular, input, output)

%% Net simulation
z = sim(netCircular, input)

rezultati = [z' output' input'];
xCircularNet = zeros(1, 60);
yCircularNet = zeros(1, 60);
tetaCircularNet = zeros(1, 60);
VNet = z(1, :);
omegaNet = z(2, :);
for i=1:59
    xCircularNet(i+1) = xCircularNet(i) + VNet(i) * cos(omegaNet(i) * t * pi / 180);
    yCircularNet(i+1) = yCircularNet(i) + VNet(i) * sin(omegaNet(i) * t * pi / 180);
    tetaCircularNet(i+1) = tetaCircularNet(i) + omegaNet(i) * t;
end
figure(2),
plot(xCircular, yCircular, '-or')
hold on
plot(xCircularNet, yCircularNet, '-b*')
grid on
xlabel('Net input')
ylabel('Net output')
title('Graph of simulation results')
legend('Function', 'Net')


% cuvanje mreze
save mrezakrt



