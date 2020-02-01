function [PE, huff] = predictor_1(a1)
% Testar prediktorn Pi = Xi-1

% X inneh�ller skillnaden mellan prediktion och faktiska v�rden
X = zeros(size(a1));
for i=1:length(a1)-1
    X(i) = a1(i+1)-a1(i);
end

% R�kna f�rekomst av varje sampelniv�
probability_matrix = zeros(256,1);
X = X - min(X) + 1;
for i = 1:length(X)
    probability_matrix(X(i)) = probability_matrix(X(i)) + 1;
end
clear i

% Ber�kna sannolikhet f�r varje niv�
probability_matrix = probability_matrix./length(X);
% Ta bort nollelement
probability_matrix = probability_matrix(find(probability_matrix));

% Ber�kna entropi
PE = entropy_custom(probability_matrix);
huff = huffman(probability_matrix);

end