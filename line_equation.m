function y = line_equation(point1, point2, x)
    
    slope = (point2(2) - point1(2))/(point2(1) - point1(1));
    intercept = point1(2) - slope*point1(1);
    
    y = slope*x + intercept;
end