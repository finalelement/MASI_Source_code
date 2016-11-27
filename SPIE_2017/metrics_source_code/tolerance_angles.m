function gold_error = tolerance_angles(m,n,o,j,k,l)

    angle_error1 = atan2d(norm(cross(m,j)),dot(m,j));
    if (angle_error1 > 90)
        angle_error1 = 180 - angle_error1;
    end
                            
    angle_error2 = atan2d(norm(cross(m,k)),dot(m,k));
    if (angle_error2 > 90)
        angle_error2 = 180 - angle_error2;
    end
    
    angle_error3 = atan2d(norm(cross(m,l)),dot(m,l));
    if (angle_error3 > 90)
        angle_error3 = 180 - angle_error3;
    end
    
    angle_error4 = atan2d(norm(cross(n,j)),dot(n,j));
    if (angle_error4 > 90)
        angle_error4 = 180 - angle_error4;
    end
    
    angle_error5 = atan2d(norm(cross(n,k)),dot(n,k));
    if (angle_error5 > 90)
        angle_error5 = 180 - angle_error5;
    end
    
    angle_error6 = atan2d(norm(cross(n,l)),dot(n,l));
    if (angle_error6 > 90)
        angle_error6 = 180 - angle_error6;
    end
    
    angle_error7 = atan2d(norm(cross(o,j)),dot(o,j));
    if (angle_error7 > 90)
        angle_error7 = 180 - angle_error7;
    end
    
    angle_error8 = atan2d(norm(cross(o,k)),dot(o,k));
    if (angle_error8 > 90)
        angle_error8 = 180 - angle_error8;
    end
    
    angle_error9 = atan2d(norm(cross(o,l)),dot(o,l));
    if (angle_error9 > 90)
        angle_error9 = 180 - angle_error9;
    end
    
    angy = [angle_error1 angle_error2 angle_error3; ...
            angle_error4 angle_error5 angle_error6; ... 
            angle_error7 angle_error8 angle_error9];

    gold_error = [];

    error1 = min(angy(angy>0));
    TF = isempty(error1);
    if (TF == 0)
        p = find(angy == error1);
        [prow,pcol] = ind2sub(size(angy),p);
        angy(prow,:) = [];
        angy(:,pcol) = [];
    else
        error1 = 0;
    end

    error2 = min(angy(angy>0));
    TF = isempty(error2);
    if (TF == 0)
        q = find(angy == error2);
        [qrow,qcol] = ind2sub(size(angy),q);
        angy(qrow,:) = [];
        angy(:,qcol) = [];

    else
        error2 = 0;
    end

    error3 = min(angy(angy>0));

    if (error1 ~= 0)
        gold_error = [gold_error,error1];
    else
        gold_error = gold_error;
    end

    if (error2 ~= 0)
        gold_error = [gold_error,error2];
    else
        gold_error = gold_error;
    end

    if (error3 ~= 0)
        gold_error = [gold_error,error3];
    else
        gold_error = gold_error;
    end
end