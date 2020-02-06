clear
tic
img = double(imread('images/woodgrain.png'));
probability_matrix = zeros(256,1);
width = size(img,2);
height = size(img,1);
n_pixels = width*height;

%for all pixels in the image
for i = 1:height
    for j = 1:width
       %increment the occurances of that pixel value
        probability_matrix(img(i,j)+1) = probability_matrix(img(i,j)+1) + 1;
    end
end

probability_matrix = probability_matrix./n_pixels;
entropy_img = entropy_custom(probability_matrix);
huff_img = huffman(probability_matrix);
clear i j probability_matrix

%% Shannon entropy & betingad entropi

probability_matrix_h = zeros(256);
probability_matrix_v = zeros(256);
% Ber�kna sannolikheter f�r kombinationer av n�rliggande sampel
for i = 1:height
    for j = 1:width-1
        % Radindex �r v�rde p� f�rra sampel, kolumnindex �r v�rde p� f�ljande sampel
        % +1 f�r att f�rskjuta fr�n 0-255 till 1-256
        % J�mf�r med pixeln till h�ger
        probability_matrix_h(img(i,j)+1, img(i,j+1)+1) = probability_matrix_h(img(i,j)+1, img(i,j+1)+1) + 1;
    end
end
clear i

% Ber�kna sannolikheter f�r kombinationer av n�rliggande sampel
for i = 1:height-1
    for j = 1:width
        % Radindex �r v�rde p� f�rra sampel, kolumnindex �r v�rde p� f�ljande sampel
        % +1 f�r att f�rskjuta fr�n 0-255 till 1-256
        % J�mf�r med pixeln till h�ger
        probability_matrix_v(img(i,j)+1, img(i+1,j)+1) = probability_matrix_v(img(i,j)+1, img(i+1,j)+1) + 1;
    end
end
clear i

% probability_matrix inneh�ller alla sannolikheter f�r f�ljande sampel
probability_matrix_h = probability_matrix_h ./ (n_pixels-height);
probability_matrix_v = probability_matrix_v ./ (n_pixels-width);
% Formatera datan till vektor med alla non-zero element
probability_matrix_h = probability_matrix_h(find(probability_matrix_h));
probability_matrix_v = probability_matrix_v(find(probability_matrix_v));

% Ber�kna entropin
entropy_pair_horizontal = entropy_custom(probability_matrix_h);
entropy_pair_vertical = entropy_custom(probability_matrix_v);
entropy_beting_horizontal = entropy_pair_horizontal - entropy_img;
entropy_beting_vertical = entropy_pair_vertical - entropy_img;
entropy_pair_horizontal = entropy_pair_horizontal;
entropy_pair_vertical = entropy_pair_vertical;
% Ber�kna snittl�ngd p� huffmankodord
huff_pair_h = huffman(probability_matrix_h);
huff_pair_v = huffman(probability_matrix_v);

clear i j height width n_pixels probability_matrix_h probability_matrix_v

%% Prediktorer

% Horisontell prediktion P(i,j) = X(i,j-1)
[entropy_predictor_h, huff_predictor_h] = predictor_horizontal(img);
% Vertikal prediktion P(i,j) = X(i-1,j)
[entropy_predictor_v, huff_predictor_v] = predictor_vertical(img);
% Diagonell prediktion P(i,j) = X(i-1,j)+X(i,j-1)-X(i-1,j-1)
[entropy_predictor_d, huff_predictor_d] = predictor_diagonal(img);

clear img
toc