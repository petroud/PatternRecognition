function [aRatio, start_height, start_width, end_height, end_width] = computeAspectRatio(image)
   %[num_rows, num_cols] = size(image)
      
   num_rows = sum(image,2);
   num_cols = sum(image,1);
   
   start_height = find(num_rows,1) - 0.5;
   end_height = find(num_rows,1,'last') + 0.5;
   
   start_width = find(num_cols,1)- 0.5;
   end_width = find(num_cols,1,'last') + 0.5;
   
   width = end_width-start_width;
   height = end_height-start_height;
   
   aRatio = width/height;

    
end

