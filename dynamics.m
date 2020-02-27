classdef dynamics
	properties
	dt = 0 %[sec]
	mass = 0 %[kg]
	
	J = [0 0 0; %inertia matrix [kg*m^2]
	     0 0 0;
	     0 0 0]

	x = [0; 0; 0] %initial position
	v = [0; 0; 0] %initial velocity
	a = [0; 0; 0] %initial acceleration
	W = [0; 0; 0] %intial angular velocity 
	W_dot = [0; 0; 0] %initial angular acceleration

	f = [0; 0; 0]; %control force
	M = [0; 0; 0]; %control moment
	end

	methods
	function set_iterate_time_sec(obj, dt)
		obj.dt = dt;
	end

	function set_mass_value(obj, mass)
		obj.mass = mass;
	end

	function set_inertia_matrix(obj, J)
		obj.J = J;
	end

	function apply_external_moment(obj, M)
		obj.M = M;
	end

	function apply_external_force(obj, f)
		obj.f = f;
	end

	function retW = get_angular_vel(obj)
		retW = obj.W;
	end

	function update(obj)
		%calculate current aungular acceleration from moment
		%calculate current accelration from force
		%calculate angular velocity by integrating angular acceleration
		%calculate velocity by integrating acceleration
		%calculate rotation matrix by intergrating DCM differential equation
		%calculate position by integrating velocity
	end
	end
end
