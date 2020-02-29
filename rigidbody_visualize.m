function rigidbody_visualize
	iterate_times = 100;
	dt = 0.001;

	rigidbody_pos = [0; 0; 0];
	rigidbody_R = [1; 0; 0;
		       0; 1; 0;
		       0; 0; 1;]

	%create 3d space
	space_len = 5; %[m]

	%define shape of quadrotor
	[x y z] = cylinder([0.2 0.2]);

	%set initial state of the rigidbody
	i11 =  z; i12 = y; i13 = x;
	i21 = -z; i22 = x; i23 = y;
	i31 =  y; i32 = z; i33 = x;
	i41 =  y; i42 =-z; i43 = x;

	p11 = i11; p12 = i12; p13 = i13;
	p21 = i21; p22 = i22; p23 = i23;
	p31 = i31; p32 = i32; p33 = i33;
	p41 = i41; p42 = i42; p43 = i43;

        for i = 1: iterate_times
		axes('XLim',[-space_len space_len],'YLim',[-space_len space_len],'ZLim',[-space_len space_len]);

		rigidbody_pos = [0; 0; 0.1 * i];

		[p11, p12, p13] = transform(i11, i12, i13, rigidbody_pos, rigidbody_R);
		[p21, p22, p23] = transform(i21, i22, i23, rigidbody_pos, rigidbody_R);
		[p31, p32, p33] = transform(i31, i32, i33, rigidbody_pos, rigidbody_R);
		[p41, p42, p43] = transform(i41, i42, i43, rigidbody_pos, rigidbody_R);

		surface(p11, p12, p13, 'FaceColor', 'red');
		surface(p21, p22, p23, 'FaceColor', 'blue');
		surface(p31, p32, p33, 'FaceColor', 'yellow');
		surface(p41, p42, p43, 'FaceColor', 'green');

		%display
		view(3)
		grid on;
		pause(0.01);
		clf;
	end
end

function [ret_p1, ret_p2, ret_p3] = transform(p1, p2, p3, pos, R)
	ret_p1 = p1 + pos(1);
	ret_p2 = p2 + pos(2);
	ret_p3 = p3 + pos(3);
end
