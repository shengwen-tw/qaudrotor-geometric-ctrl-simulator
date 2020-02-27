function quadrotor_sim
	ITERATION_TIMES = 10000

	math = se3_math;

	uav_dynamics = dynamics;    %create uav dynamics object
	uav_dynamics.dt = 0.001;    %set iteration period [sec]
	uav_dynamics.mass = 1;      %set uav mass [kg]
	uav_dynamics.a = [0; 0; 0];
	uav_dynamics.v = [0; 0; 0];
	uav_dynamics.x = [0; 0; 0];
	uav_dynamics.W = [0; 0; 0];
	uav_dynamics.W_dot = [0; 0; 0];
	uav_dynamics.f = [0; 0; 0];
	uav_dynamics.M = [0; 0 ;0];
	uav_dynamics.R = math.euler_to_dcm(deg2rad(0), deg2rad(0), deg2rad(0));

	uav_dynamics.J = [0.01466 0 0;
			  0 0.01466 0;
			  0 0 0.02848];

	%plot datas
	time_arr = zeros(1, ITERATION_TIMES);
	pos_a_arr = zeros(1, ITERATION_TIMES);
	pos_v_arr = zeros(1, ITERATION_TIMES);
	pos_x_arr = zeros(1, ITERATION_TIMES);
	prv_angle_arr = zeros(1, ITERATION_TIMES);

	uav_dynamics.M = [0.01, 0, 0];

	for i = 1: ITERATION_TIMES
		uav_dynamics = update(uav_dynamics);
		
		pos_a_arr(i) = uav_dynamics.a(1);
		pos_v_arr(i) = uav_dynamics.v(1);
		pos_x_arr(i) = uav_dynamics.x(1);
		prv_angle_arr(i) = rad2deg(uav_dynamics.prv_angle);

		time_arr(i) = i * uav_dynamics.dt;
	end

	figure(1);
	plot(time_arr, prv_angle_arr);
	disp("press any button to leave");
	pause;
end
