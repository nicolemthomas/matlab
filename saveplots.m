function [  ] = saveplots( item, name )
%   This function automates saving a .fig and .png (or .jpg) of a plot.
%   I used this to save time in post processing when I had to save data.
    saveas(item, strcat(name, '.fig'), 'fig');
%     saveas(item, strcat(name, '.png'), 'png');
    saveas(item, strcat(name, '.jpg'), 'jpg');

end

