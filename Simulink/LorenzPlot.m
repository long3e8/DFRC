% This script is used to plot the Lorenz system with data generated by
% Simulink tool.
sim('Lorenz.slx');
plot3(out.simout,out.simout1,out.simout2)
axis equal
xlabel('x(t)')
ylabel('y(t)')
zlabel('z(t)')