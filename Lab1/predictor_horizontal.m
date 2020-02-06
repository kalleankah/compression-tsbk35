function [PE, huff] = predictor_horizontal(img)
% Testar prediktorn P(i,j) = X(i,j-1)
img = padarray(img, [0 1], 0.5, 'pre');
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
[N,~] = ihist(X);

% Ber�kna sannolikhet f�r varje niv�
probability_matrix = sum(N,2)./ n_pixels;

% Ber�kna entropi
PE = entropy_custom(probability_matrix);
huff = huffman(probability_matrix);

end