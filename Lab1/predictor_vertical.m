function [PE, huff] = predictor_vertical(img)
% Testar prediktorn P(i,j) = X(i-1,j)
img = int8(padarray(img, [1 0], 128, 'pre'));
width = size(img,2);
height = size(img,1);
n_pixels = width*height;

X = zeros(size(img));
for i = 2:height
    for j = 1:width
        % X innehåller skillnaden mellan prediktion och faktiska värden
        X(i,j) = img(i-1,j) - img(i,j);
    end
end
clear i j

% Räkna förekomst av varje sampelnivå
[N,~] = ihist(X);

% Beräkna sannolikhet för varje nivå
probability_matrix = sum(N,2)./ n_pixels;
% Ta bort nollelement
probability_matrix = probability_matrix(find(probability_matrix));

% Beräkna entropi
PE = entropy_custom(probability_matrix);
huff = huffman(probability_matrix);

end