function [dWx,dWy] = dWx_dp(x, y, varargin)
    x = x(:); y = y(:); % Vectorize everything
    v1 = ones(size(x)); v0 = zeros(size(x));
    % Form the derivative of the warp function (as discussed in
    % class)
    dWx = [ -x,  y, v1, v0,  v0, v0]; 
    dWy = [ v0, v0, v0,  x,  -y, v1]; 
end