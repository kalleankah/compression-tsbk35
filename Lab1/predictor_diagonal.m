function [PE, huff] = predictor_diagonal(img)
% Testar prediktorn P(i,j) = X(i,j-1)
img = int8(padarray(img, [1 1], 128));
width = size(img,2);
height = size(img,1);
n_pixels = width*height;

X = zeros(size(img));
for i = 2:height
    for j = 2:width
        % X inneh�ller skillnaden mellan prediktion och faktiska v�rden
        X(i,j) = img(i-1,j) + img(i,j-1) - img(i-1,j-1) - img(i,j);
    end
end
clear i j

% R�kna f�rekomst av varje sampelniv�
[N,~] = ihist(X);

% Ber�kna sannolikhet f�r varje niv�
probability_matrix = sum(N,2)./ n_pixels;
% Ta bort nollelement
probability_matrix = probability_matrix(find(probability_matrix));

% Ber�kna entropi
PE = entropy_custom(probability_matrix);
huff = huffman(probability_matrix);

end