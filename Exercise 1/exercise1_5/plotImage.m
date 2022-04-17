function plotImage(dImage)
   
     colormap(gray);
     image(dImage);
     [arat, start_height, start_width, end_height, end_width] = computeAspectRatio(dImage);
     hold on;
     
     rectangle('Position',[start_width , start_height , end_width-start_width, end_height-start_height],'EdgeColor','r','LineWidth',5);
     title(sprintf('Aspect ratio = %0.2f',arat));
     hold off;
end