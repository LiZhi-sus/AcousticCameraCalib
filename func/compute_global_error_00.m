% Computes the total error of the graph
function Fx = compute_global_error_00(g)

Fx = 0;

% Loop over all edges
for eid = 1:length(g.edges)
  edge = g.edges(eid);
  % pose-landmark constraint
l(1:3) = g.ref;
for n = 1:(g.M-1)
    % l(3*n+1:3*n+3) = rotationVectorToMatrix(g.wm)*g.x(3*(n-1)+1:3*(n-1)+3)+g.Tm;
    l(3*n+1:3*n+3) = g.x(3*(n-1)+1:3*(n-1)+3);
end
% l = g.x(edge.fromIdx:edge.fromIdx+(3*g.M-1));  % the landmark
x = g.xs(edge.toIdx:edge.toIdx+2);      % the robot pose

% compute the error of the constraint and add it to Fx.
% Use edge.measurement and edge.information to access the
% measurement and the information matrix respectively.
e_il = zeros(g.M-1,1);
for n = 1:(g.M-1)

     e_il(n) = sqrt((l(3*n+1)-x(1))^2 + (l(3*n+2)-x(2))^2 + (l(3*n+3)-x(3))^2)/340 - ...
        sqrt((l(1)-x(1))^2 + (l(2)-x(2))^2 + (l(3)-x(3))^2)/340 ...
         - edge.measurement(n);

end

e_ls_il = e_il' * edge.information * e_il;
Fx = Fx + e_ls_il;

end
