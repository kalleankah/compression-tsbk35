function [PE, huff] = predictor_horizontal(img)
% Testar prediktorn P(i,j) = X(i,j-1)
img = int8(padarray(img, [1 1], 128));
width = size(img,2);
height = size(img,1);
n_pixels = width*height;

X = zeros(size(img));
for i = 1:height
    for j = 2:width
        % X inneh�ller skillnaden mellan prediktion och faktiska v�rden
        X(i,j) = img(i,j-1) - img(i,j);
    end
end
clear i j

% R�kna f�rekomst av varje sampelniv�
probability_matrix = zeros(256,1);
X = X - min(min(X)) + 1;
for i = 1:height
    for j = 1:width
        probability_matrix(X(i,j)) = probability_matrix(X(i,j)) + 1;
    end
end
clear i

% Ber�kna sannolikhet f�r varje niv�
probability_matrix = probability_matrix./n_pixels;
% Ta bort nollelement
probability_matrix = probability_matrix(find(probability_matrix));

% Ber�kna entropi
PE = entropy_custom(probability_matrix);
huff = huffman(probability_matrix);

end