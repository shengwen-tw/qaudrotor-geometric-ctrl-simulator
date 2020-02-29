%plot_size: size of the 3d space to plot, i.e., [size_x; size_y; size_z]
%rigidbody_pos: array of rigidbody's position went before
%rigidbody_R: array of rigidbody's attitude (DCM) tilted before
%iteration_times: total count of the rigidbodys pose
%sleep_time: the time to sleep after every iteration of visualization
%skip_cnt: skip count of the visualization since it is too slow
function rigidbody_visualize(plot_size, rigidbody_pos, rigidbody_R, iterate_times, sleep_time, skip_cnt)
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

	disp('Start timing the elsapsed time of rigibody visualization:');
	tic();
        for i = 1: skip_cnt: iterate_times
		sx = plot_size(1);
		sy = plot_size(2);
		sz = plot_size(3);
		axes('XLim',[-sx sx],'YLim',[-sy sy],'ZLim',[-sz sz]);

		[p11, p12, p13] = cylinder_transform(i11, i12, i13, rigidbody_pos(:, i), rigidbody_R(:, :, i));
		[p21, p22, p23] = cylinder_transform(i21, i22, i23, rigidbody_pos(:, i), rigidbody_R(:, :, i));
		[p31, p32, p33] = cylinder_transform(i31, i32, i33, rigidbody_pos(:, i), rigidbody_R(:, :, i));
		[p41, p42, p43] = cylinder_transform(i41, i42, i43, rigidbody_pos(:, i), rigidbody_R(:, :, i));

		surface(p11, p12, p13, 'FaceColor', 'red');
		surface(p21, p22, p23, 'FaceColor', 'blue');
		surface(p31, p32, p33, 'FaceColor', 'yellow');
		surface(p41, p42, p43, 'FaceColor', 'green');

		%display
		view(3)
		grid on;
		pause(sleep_time);
		clf;
	end
	toc();
end

function [ret_px, ret_py ret_pz] = cylinder_transform(px, py, pz, pos, R)
	ring1_old = [px(1,:)', py(1,:)', pz(1,:)'];
	ring2_old = [px(2,:)', py(2,:)', pz(2,:)'];
	ring1_rotated = ring1_old * R;
	ring2_rotated = ring2_old * R;

	rotated_x = [ring1_rotated(:,1), ring2_rotated(:,1)];
	rotated_y = [ring1_rotated(:,2), ring2_rotated(:,2)];
	rotated_z = [ring1_rotated(:,3), ring2_rotated(:,3)];

	ret_px = rotated_x + pos(1);
	ret_py = rotated_y + pos(2);
	ret_pz = rotated_z - pos(3); %input z is in NED frame, convert to sea level height
end
