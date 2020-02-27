function main
	m = se3_math;
	R = m.euler_to_dcm(rad2deg(0.0), rad2deg(0.0), rad2deg(0.0));
	V = m.vee_map_3x3(R)
	M = m.hat_map_3x3(V)
end
