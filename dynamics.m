classdef dynamics
	properties
	dt;      %[sec]
	mass;    %[kg]

	g = 9.8; %gravitational acceleration
	
	J;       %inertia matrix [kg*m^2]

	x;       %initial position
	v;       %initial velocity
	a;       %initial acceleration
	W;       %intial angular velocity 
	W_dot;   %initial angular acceleration

	R;       %attitude, direction cosine matrix
	R_det;

	prv_angle;

	f;       %control force
	M;       %control moment
	end

	methods
	function f_next = integrator(obj, f_now, f_dot, dt)
		%euler method
		f_next = [f_now(1) + (f_dot(1) * dt);
			  f_now(2) + (f_dot(2) * dt);
			  f_now(3) + (f_dot(3) * dt)];
	end

	function ret_obj = update(obj)
		math = se3_math;

		%calculate angular velocity by integrating angular acceleration
		obj.W = obj.integrator(obj.W, obj.W_dot, obj.dt);

		%calculate velocity by integrating acceleration
		obj.v = obj.integrator(obj.v, obj.a, obj.dt);

		%calculate rotation matrix by intergrating DCM differential equation
		%read "Direction Cosine Matrix IMU: Theory" for detailed explanation
		R_dot = obj.R * math.hat_map_3x3(obj.W);
		I = eye(3);
		Wdt = [obj.W(1) * obj.dt; obj.W(2) * obj.dt; obj.W(3) * obj.dt];
		dR = math.hat_map_3x3(Wdt) + I;
		%according to definition of SO(3), to rotate R by dR, the correct way
		%to do is multiplication rather than addition, since SO(3) is not closed
		%under addition
		obj.R = obj.R * dR;
		%maintain the orthonomal properties of DCM
		obj.R = math.dcm_orthonormalize(obj.R);
		%obj.R_det = det(obj.R);
		%disp(obj.R_det)

		%calculate the angle of principle rotation vector
		obj.prv_angle = math.get_prv_angle(obj.R);

		%calculate position by integrating velocity
		obj.x = obj.integrator(obj.x, obj.v, obj.dt);

		%calculate current accelration from force
		e3 = [0; 0; 1];
		f = 1; %FIXME
		mv_dot = (obj.mass * obj.g * e3) - (f * (obj.R * e3));
		obj.a = mv_dot / obj.mass;

		%calculate current aungular acceleration from moment
		JW = obj.J * obj.W;
		WJW = cross(obj.W, JW);
		JW_dot = obj.M - WJW;

		ret_obj = obj;
	end
	end
end
