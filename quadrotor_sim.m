function quadrotor_sim
	math = se3_math;

	uav_dynamics = dynamics;    %create uav dynamics object
	uav_dynamics.dt = 0.001;    %set iteration period [sec]
	uav_dynamics.mass = 1;      %set uav mass [kg]
	uav_dynamics.a = [0; 0; 0];
	uav_dynamics.v = [0; 0; 0];
	uav_dynamics.x = [0; 0; 0];
	uav_dynamics.W = [0; 0; 1];
	uav_dynamics.W_dot = [0; 0; 0];
	uav_dynamics.f = [0; 0; 0];
	uav_dynamics.M = [0; 0 ;0];
	uav_dynamics.R = math.euler_to_dcm(deg2rad(0), deg2rad(0), deg2rad(0));

	uav_dynamics.J = [1 0 0;
			  0 1 0;
			  0 0 1];

	for i = 1: 10000
		uav_dynamics = update(uav_dynamics);
	end
end
