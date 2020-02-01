function [PE, huff] = predictor_1(a1)
% Testar prediktorn Pi = Xi-1

% X innehåller skillnaden mellan prediktion och faktiska värden
X = zeros(size(a1));
for i=1:length(a1)-1
    X(i) = a1(i+1)-a1(i);
end

% Räkna förekomst av varje sampelnivå
probability_matrix = zeros(256,1);
X = X - min(X) + 1;
for i = 1:length(X)
    probability_matrix(X(i)) = probability_matrix(X(i)) + 1;
end
clear i

% Beräkna sannolikhet för varje nivå
probability_matrix = probability_matrix./length(X);
% Ta bort nollelement
probability_matrix = probability_matrix(find(probability_matrix));

% Beräkna entropi
PE = entropy_custom(probability_matrix);
huff = huffman(probability_matrix);

end