function [covMatrix] = covariance(x, y, Q, u, H)
  ay = 0.34;  by = 0.82;  az = 0.275; bz = 0.82;  
  sigmay = ay*abs(x).^by .* (x > 0);
  sigmaz = az*abs(x).^bz .* (x > 0);
	
	E_Q_square = Q^2;
	E_Q = Q;
	NodeNum = length(x);
	covMatrix = zeros(NodeNum,NodeNum);
	for i = 1 : NodeNum
		for j = 1 : NodeNum
			% construct the necessary parameters
      if sigmay(i)*sigmay(j) ~= 0
			  k_i = u*sigmay(i); % still have some problems
			  k_j = u*sigmay(j); % still have some problems
			  S_i = (-y(i)^2/(4*k_i));
			  S_j = (-y(j)^2/(4*k_j));
			  t_i = -H^2/(4*k_i);
			  t_j = -H^2/(4*k_j);
			  % compute the covarance matrix
			  covMatrix(i,j) = ...
				    (1/(4*pi^2*k_i*k_j))*exp(u*(S_i+S_j+t_i+t_j))*E_Q_square-...
				    (1/(2*pi*k_i))*exp(u*(S_i+t_i))*...
				    (1/(2*pi*k_j))*exp(u*(S_j+t_j))*...
				    E_Q^2;
        else
            covMatrix(i,j) = 0;
        end

		end
	end
end
