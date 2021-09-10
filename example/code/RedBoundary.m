function [recog_pic] = RedBoundary(detec_gray,proc_pic)
    MAX_FACE = 1000;
    queue = [];
    cursor_x = 0;
    cursor_y = 0;
    search_mode = 0;
    queue_top = 1;
    queue_end = 1;
    face_cnt = 0;
    [height,width] = size(detec_gray);
    visit_flag = zeros(height,width);               %1 for visit 
                                                    %0 for not visit yet
    red_boundary_mat = zeros(4,MAX_FACE);           %dim 1: top limit
                                                    %dim 2: bottom limit
                                                    %dim 3: left limit
                                                    %dim 4: right limit
    red_area_mat = zeros(1,MAX_FACE);
    face_size_mat = zeros(1,MAX_FACE);
    for i = 1 : 1 : height
        for j = 1 : 1 : width
            if (detec_gray(i,j) == 255)&&(~visit_flag(i,j))
                face_cnt = face_cnt + 1;
                face_size_mat(face_cnt) = face_size_mat(face_cnt) + 1;
                red_boundary_mat(1:2,face_cnt) = [i;i];
                red_boundary_mat(3:4,face_cnt) = [j;j];
                search_mode = 1;
                queue = [i;j];
                queue_top = 1;
                queue_end = 2;
                visit_flag(i,j) = 1;
            end
            if search_mode == 1
                while queue_top ~= queue_end 
                    cursor_x = queue(1,queue_top);
                    cursor_y = queue(2,queue_top);
                    queue_top = queue_top + 1;
                    for delta_x = -1 : 1 : 1
                        for delta_y = -1 : 1 : 1
                            if (detec_gray(cursor_x + delta_x,cursor_y + delta_y) == 255)&&(~visit_flag(cursor_x + delta_x,cursor_y + delta_y))
                                visit_flag(cursor_x + delta_x,cursor_y + delta_y) = 1;
                                queue(1,queue_end) = cursor_x + delta_x;
                                queue(2,queue_end) = cursor_y + delta_y;
                                queue_end = queue_end + 1;
                                face_size_mat(face_cnt) = face_size_mat(face_cnt) + 1;
                                red_boundary_mat(1,face_cnt) = min(cursor_x+delta_x,red_boundary_mat(1,face_cnt));
                                red_boundary_mat(2,face_cnt) = max(cursor_x+delta_x,red_boundary_mat(2,face_cnt));
                                red_boundary_mat(3,face_cnt) = min(cursor_y+delta_y,red_boundary_mat(3,face_cnt));
                                red_boundary_mat(4,face_cnt) = max(cursor_y+delta_y,red_boundary_mat(4,face_cnt));
                            end
                        end
                    end
                end
                red_area_mat(face_cnt) = (red_boundary_mat(2,face_cnt) - red_boundary_mat(1,face_cnt) + 1)*(red_boundary_mat(4,face_cnt) - red_boundary_mat(3,face_cnt) + 1);
                queue = [];
                queue_top = 1;
                queue_end = 1;
                search_mode = 0;
            else
                continue;
            end
        end
    end
    cnt_th = 0.25*max(face_size_mat);
    ratio_th = 0.6;
    lw_ratio_th = 0.55;
    for i = 1 : 1 : face_cnt
        if(red_area_mat(i)/face_size_mat(i) > ratio_th)&&(face_size_mat(i)>cnt_th)&&((red_boundary_mat(2,i)-red_boundary_mat(1,i))/(red_boundary_mat(4,i)-red_boundary_mat(3,i))>lw_ratio_th)
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(1,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(4,i),1) = 255;
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(1,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(4,i),2) = 0;
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(1,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(4,i),3) = 0;         %top boundary
            proc_pic(8*(red_boundary_mat(2,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(4,i),1) = 255;
            proc_pic(8*(red_boundary_mat(2,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(4,i),2) = 0;
            proc_pic(8*(red_boundary_mat(2,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(4,i),3) = 0;         %top boundary
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(3,i),1) = 255;
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(3,i),2) = 0;
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(3,i)-1)+1:8*red_boundary_mat(3,i),3) = 0;         %left boundary
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(4,i)-1)+1:8*red_boundary_mat(4,i),1) = 255;
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(4,i)-1)+1:8*red_boundary_mat(4,i),2) = 0;
            proc_pic(8*(red_boundary_mat(1,i)-1)+1:8*red_boundary_mat(2,i),8*(red_boundary_mat(4,i)-1)+1:8*red_boundary_mat(4,i),3) = 0;         %right boundary
        end
    end
    recog_pic = proc_pic;
end

