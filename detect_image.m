function detect_image(mode)
input = 'photo-0205.jpg'; 

                                                                          % read image from input file
   im=imread(input);
   % load model and parameters 
   [Models,option] = xx_initialize;  
   if strcmpi(mode,'auto') == 1 
       faces = Models.DM{1}.fd_h.detect(im,'MinNeighbors',option.min_neighbors,'ScaleFactor',1.2,'MinSize',[50 50]);
       imshow(im);
       hold on;
       for i = 1:length(faces)
           output = xx_track_detect(Models,im,faces{i},option); 
           if ~isempty(output.pred) 
               plot(output.pred(:,1),output.pred(:,2),'g*','markersize',2);
           end
       end
       hold off
   elseif strcmpi(mode,'interactive') == 1 
       imshow(im); 
       hold on;
       h = imrect;
       position = wait(h); 
       output = xx_track_detect(Models,im,position,option);
       if ~isempty(output.pred) 
           plot(output.pred(:,1),output.pred(:,2),'g*','markersize',2);
       end
       hold off
   else disp(['Unknow mode: ' mode]);
   end
end
