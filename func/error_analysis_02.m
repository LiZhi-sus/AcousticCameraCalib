function MSE = error_analysis_02(g)
m = 0;
mx = 0;
my = 0;
mz = 0;
for i = 1:3:3*(g.M-1)
    m_x = (g.x(i)-g.x_gt(i))^2;
    m_y = (g.x(i+1)-g.x_gt(i+1))^2;
    m_z = (g.x(i+2)-g.x_gt(i+2))^2;
    m = m + m_x+m_y+m_z;
    mx = mx + m_x;
    my = my + m_y;
    mz = mz + m_z;
end
MSE = [mx,my,mz,m]/g.M;
end