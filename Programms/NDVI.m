infa = imread('infa.TIF'); 
krasniy = imread('krasny.TIF'); 
ndvi = (infa - krasniy) ./ (infa + krasniy); 
barnaul =(imread('barnaul.TIF')); 
barnaul = (barnaul + (barnaul .* ndvi)); 
im = barnaul; 
red = im; 
green = im; 
blue = im; 
out_image = cat(3, red, green, blue); 
for i =1:8191 
for j=1:8101 
if barnaul(i,j)>40000 
out_image(i,j,1) = 0; 
out_image(i,j,2) = 45535; 
out_image(i,j,3) = 0; 
end 
end 
end 
imshow(out_image);
