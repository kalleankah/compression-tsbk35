function E = entropy_custom(probability_vector)

E = -nansum(probability_vector .* log2(probability_vector));

end