%% Lab 1 - Entropier och Distortionsfri kodning
clear
tic
% L�s in filer
[audio, ~] = audioread("audio/nuit04_8bit.wav");
% Skala om till 0:256
audio = (audio .* 128) + 128;

%% Ber�kna sannolikhetsf�rdelning H(Xi)
% R�kna f�rekomst av varje sampelniv�
probability_vector = ihist(audio);
probability_vector = probability_vector./length(audio);

% Ber�kna entropin
entropy_audio = entropy_custom(probability_vector);

% Ber�kna snittl�ngd p� huffmankodord
huff_audio = huffman(probability_vector);

%% Ber�kna parentropi och betingad entropi H(Xi,Xi+1)

probability_matrix = zeros(256);
% Ber�kna sannolikheter f�r kombinationer av n�rliggande sampel
for i = 1:(length(audio)-1)
    % Radindex �r v�rde p� f�rra sampel, kolumnindex �r v�rde p� f�ljande sampel
    % Tex. v�rdet i [126, 128] �r antalet g�nger som v�rdena 126 och 128
    % kommer efter varandra.
    probability_matrix(audio(i), audio(i+1)) = probability_matrix(audio(i), audio(i+1)) + 1;
end
clear i

% probability_matrix inneh�ller alla sannolikheter f�r f�ljande sampel
probability_matrix = probability_matrix ./ (length(audio)-1);
% Formatera datan till vektor med alla non-zero element
probability_vector = probability_matrix(find(probability_matrix));

% Ber�kna entropin
entropy_pair = entropy_custom(probability_vector);
entropy_beting = entropy_pair - entropy_audio;
entropy_pair = entropy_pair/2;
% Ber�kna snittl�ngd p� huffmankodord
huff_pair = huffman(probability_vector)/2;
clear probability_matrix probability_vector

%% Prediktiv kodning med Huffman

% Testar prediktorn Pi = Xi-1
[entropy_predictor_1, huff_predictor_1] = predictor_1(audio);

% Testar prediktorn Pi = 2*Xi-1 - Xi-2 
[entropy_predictor_2, huff_predictor_2] = predictor_2(audio);
clear audio
toc