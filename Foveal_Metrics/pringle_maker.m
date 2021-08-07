 function [ outputmask ] = pringle_maker( im_mask, im_actual)
% Robert Cooper
%   This function takes in a mask and an actual image and makes a form
%   fitting plane between the upper and lower rows of the image.
% im=im_orig;
i=1;
im_pringle_mask=zeros(size(im_mask));
for j=1:size(im_mask,2) % Did this instead of simple derivative because I need 
                   % Column/Row values

    tmp=find(im_mask(:,j)>0,1,'first');
    if ~isempty(tmp) % If there is a first, there is a last
        
        toprow(i)=tmp;
        
        bottomrow(i)=find(im_mask(:,j)>0,1,'last');
        
        % Use this commented section for debugging...
%         im_mask(:,j)=0; 
%         im_mask([toprow(i) bottomrow(i)],j)=1;
%         
%         imshow(im_mask)
        
        
        dist=toprow(i)-bottomrow(i); % Distance in pixels between the points
        
        topval(i)=im_actual(toprow(i),j);
        bottomval(i)=im_actual(bottomrow(i),j);
        
        slope(i)=(topval(i)-bottomval(i))./(dist);
        
        line=0:1:abs(dist);
        
        im_pringle_mask(toprow(i):bottomrow(i),j)=slope(i).*line+topval(i);
        i=i+1;
    end
    
end

outputmask=im_pringle_mask;

 end

