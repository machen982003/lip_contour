function p = fitInit(src, dst)
            [dWx,dWy] = dWx_dp(src(1,:),src(2,:));
            J = [dWx;dWy]; % Jacobian matrix
            % Get the error between dst and src
            err_x = dst(1,:) - src(1,:); 
            err_y = dst(2,:) - src(2,:);
            % Now solve for p using "backslash"!!!!
            p = J\[err_x,err_y]'; 
end 