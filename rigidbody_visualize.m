function rigidbody_visualize
	%create 3d space
	space_length = 5; %[m]
	axes('XLim',[-space_length space_length],'YLim',[-space_length space_length],'ZLim',[-space_length space_length]);

	%define shape of quadrotor
	[x y z] = cylinder([0.2 0.2]);
	h(1) = surface(z, x, y, 'FaceColor', 'red')
	h(2) = surface(-z, x, y, 'FaceColor', 'blue')
	h(3) = surface(y, z, x, 'FaceColor', 'yellow')
	h(4) = surface(y, -z, x, 'FaceColor', 'green')

	%display
	view(3)
	grid on;

	pause;
end
