%% Lab 1 - Entropier och Distortionsfri kodning
clear
tic
% Läs in filer
[audio, ~] = audioread("audio/nuit04_8bit.wav");
% Skala om till 0:256
audio = (audio .* 128) + 128;

%% Beräkna sannolikhetsfördelning H(Xi)
% Räkna förekomst av varje sampelnivå
probability_vector = ihist(audio);
probability_vector = probability_vector./length(audio);

% Beräkna entropin
entropy_audio = entropy_custom(probability_vector);

% Beräkna snittlängd på huffmankodord
huff_audio = huffman(probability_vector);

%% Beräkna parentropi och betingad entropi H(Xi,Xi+1)

probability_matrix = zeros(256);
% Beräkna sannolikheter för kombinationer av närliggande sampel
for i = 1:(length(audio)-1)
    % Radindex är värde på förra sampel, kolumnindex är värde på följande sampel
    % Tex. värdet i [126, 128] är antalet gånger som värdena 126 och 128
    % kommer efter varandra.
    probability_matrix(audio(i), audio(i+1)) = probability_matrix(audio(i), audio(i+1)) + 1;
end
clear i

% probability_matrix innehåller alla sannolikheter för följande sampel
probability_matrix = probability_matrix ./ (length(audio)-1);
% Formatera datan till vektor med alla non-zero element
probability_vector = probability_matrix(find(probability_matrix));

% Beräkna entropin
entropy_pair = entropy_custom(probability_vector);
entropy_beting = entropy_pair - entropy_audio;
entropy_pair = entropy_pair/2;
% Beräkna snittlängd på huffmankodord
huff_pair = huffman(probability_vector)/2;
clear probability_matrix probability_vector

%% Prediktiv kodning med Huffman

% Testar prediktorn Pi = Xi-1
[entropy_predictor_1, huff_predictor_1] = predictor_1(audio);

% Testar prediktorn Pi = 2*Xi-1 - Xi-2 
[entropy_predictor_2, huff_predictor_2] = predictor_2(audio);
clear audio
toc