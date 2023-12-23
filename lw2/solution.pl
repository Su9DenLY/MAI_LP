solve(B, K, L, C, S) :- permutation([B, K, L, C, S],[dina, sonya, kolya, roma, misha]),not(contradiction([B, K, L, C, S])), not(K == kolya).

contradiction(V):- data(V,F,A,TF), logicalnot(TF,FT), data(V,F,A,FT).

logicalnot(true,false).
logicalnot(false,true).

data(_, is_male, [X], true) :- data(_, male, V, true), member(X, V).
data(_, is_male, [X], false) :- data(_, male, V, false), member(X, V).
data(_, is_female, [X], true) :- data(_, male, V, false), member(X, V).
data(_, is_female, [X], false) :- data(_, male, V, true), member(X, V).

data([_, K, _, _, _], is_male, [K], true).
data([_, K, _, _, _], is_female, [K], false).

data(_, male, [dina, sonya], false).
data(_, male, [kolya, roma, misha], true).

data(_, same_gender, [dina, sonya], true).
data(_, same_gender, [dina, kolya], false).
data(_, same_gender, [dina, misha], false).
data(_, same_gender, [dina, roma], false).
data(_, same_gender, [sonya, kolya], false).
data(_, same_gender, [sonya, roma], false).
data(_, same_gender, [sonya, misha], false).
data(_, same_gender, [kolya, misha], true).
data(_, same_gender, [kolya, roma], true).
data(_, same_gender, [misha, roma], true).

data([B, _, _, _, S], same_gender, [B, S], true). 
data([B, _, _, _, S], same_gender, [S, B], true).

data([B, _, L, _, _], same_gender, [L, B], false).
data([B, _, L, _, _], same_gender, [B, L], false).

data(_, parents_met, [roma, _], false).
data(_, parents_met, [_, roma], false).

data(_, parents_met, [dina, kolya], false).
data(_, parents_met, [kolya, dina], false).

data([_, K, _, _, S], parents_met, [K, S], true).
data([_, K, _, _, S], parents_met, [S, K], true).

data([_, K, _, _, _], parents_met, [K, kolya], true).
data([_, K, _, _, _], parents_met, [kolya, K], true).

data([B, _, L, _, _], parents_met, [B, L], true).
data([B, _, L, _, _], parents_met, [L, B], true).
