%check: https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles

classdef se3_math
	methods

	function dcm = euler_to_dcm(obj, roll, pitch ,yaw)
		%R = Rz(psi)Ry(theta)Rx(phi)
		cos_phi = cos(double(roll));
		cos_theta = cos(pitch);
		cos_psi = cos(yaw);
		sin_phi = sin(roll);
		sin_theta = sin(pitch);
		sin_psi = sin(yaw);
		dcm11 = cos_theta * cos_psi;
		dcm12 = (-cos_phi * sin_psi) + (sin_phi * sin_theta * cos_psi);
		dcm13 = (sin_phi * sin_psi) + (cos_phi * sin_theta * cos_psi);
		dcm21 = cos_theta * sin_psi; 
		dcm22 = (cos_phi * cos_psi) + (sin_phi * sin_theta * sin_psi);
		dcm23 = (-sin_phi * cos_psi) + (cos_phi * sin_theta * sin_psi);
		dcm31 = -sin_theta;
		dcm32 = sin_phi * cos_theta;
		dcm33 = cos_phi * cos_theta;
		dcm = [dcm11 dcm12 dcm13;
		       dcm21 dcm22 dcm23;
		       dcm31 dcm32 dcm33;]
	end

	function vec=vee_map_3x3(obj, mat)
		vec=[mat(3, 2);
		     mat(1, 3);
		     mat(2, 1)];
	end

	function mat=hat_map_3x3(obj, vec)
		mat=[0.0 -vec(3) +vec(2);
		     +vec(3) 0.0 -vec(1);
		     -vec(2) +vec(1) 0.0];
	end

	end
end
