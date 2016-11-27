function min_angle = minimum_crossing_angle_per_voxel(m,n,o)
    
    angle1 = atan2d(norm(cross(m,n)),dot(m,n));
    if (angle1 > 90)
        angle1 = 180 - angle1;
    end

    angle2 = atan2d(norm(cross(m,o)),dot(m,o));
    if (angle2 > 90)
        angle2 = 180 - angle2;
    end
    
    angle3 = atan2d(norm(cross(n,o)),dot(n,o));
    if (angle3 > 90)
        angle3 = 180 - angle3;
    end
    
    angles = [angle1 angle2 angle3];
    min_angle = min(angles(angles>0));
    
    if (isempty(min_angle))
        min_angle = 0;
    end
end