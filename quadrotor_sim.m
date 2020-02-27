function quadrotor_sim
	uav_dynamics = dynamics;

	for i = 1: 10000
		uav_dynamics.update();
	end
end
