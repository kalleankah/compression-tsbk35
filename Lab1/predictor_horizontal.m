function [PE, huff] = predictor_horizontal(img)
% Testar prediktorn P(i,j) = X(i,j-1)
img = padarray(img, [0 1], 0.5, 'pre');
width = size(img,2);
height = size(img,1);
n_pixels = width*height;

X = zeros(size(img));
for i = 1:height
    for j = 2:width
        % X innehåller skillnaden mellan prediktion och faktiska värden
        X(i,j) = img(i,j-1) - img(i,j);
    end
end
clear i j

% Räkna förekomst av varje sampelnivå
[N,~] = ihist(X);

% Beräkna sannolikhet för varje nivå
probability_matrix = sum(N,2)./ n_pixels;

% Beräkna entropi
PE = entropy_custom(probability_matrix);
huff = huffman(probability_matrix);

end