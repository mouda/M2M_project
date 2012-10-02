function myplot(x, y, z, droped)
    figure
    plot3([x(1);x(1)], [y(1);y(1)], [0;z(1)]);
    hold on
    grid on
    for i = 2:length(x)
        plot3([x(i);x(i)], [y(i);y(i)], [0;z(i)]);
    end
    scatter3(x(droped), y(droped), z(droped), 30, [1, 0, 0], 'filled');
    scatter3(x(~droped), y(~droped), z(~droped), 30, [0, 0, 1], 'filled');
    hold off
end