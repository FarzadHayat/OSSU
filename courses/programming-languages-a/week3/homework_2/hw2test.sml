use "hw2.sml";

val test1 = all_except_option ("string", []) = NONE;
val test1 = all_except_option ("string", ["string"]) = SOME [];
val test1 = all_except_option ("string", ["first", "second", "third"]) = NONE;
val test1 = all_except_option ("first", ["first", "second", "third"]) = SOME ["second", "third"];
val test1 = all_except_option ("second", ["first", "second", "third"]) = SOME ["first", "third"];
val test1 = all_except_option ("third", ["first", "second", "third"]) = SOME ["first", "second"];

val test2 = get_substitutions1 ([], "foo") = [];
val test2 = get_substitutions1 ([["foo"]], "foo") = [];
val test2 = get_substitutions1 ([["foo"]], "bar") = [];
val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = [];
val test2 = get_substitutions1 ([["foo"],["there"]], "bar") = [];
val test2 = get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Freddie") = ["Fred","F"];
val test2 = get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];
val test2 = get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Elizabeth") = ["Betty"];
val test2 = get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Billy") = [];
val test2 = get_substitutions1 ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"];

val test3 = get_substitutions2 ([], "foo") = [];
val test3 = get_substitutions2 ([["foo"]], "foo") = [];
val test3 = get_substitutions2 ([["foo"]], "bar") = [];
val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = [];
val test3 = get_substitutions2 ([["foo"],["there"]], "bar") = [];
val test3 = get_substitutions2 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Freddie") = ["Fred","F"];
val test3 = get_substitutions2 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];
val test3 = get_substitutions2 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Elizabeth") = ["Betty"];
val test3 = get_substitutions2 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Billy") = [];
val test3 = get_substitutions2 ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"];

val test4 = similar_names ([], {first="First", middle="Middle", last="Last"}) = [{first="First", middle="Middle", last="Last"}];
val test4 = similar_names ([["Fred"],["Elizabeth","Betty"]], {first="First", middle="Middle", last="Last"}) = [{first="First", middle="Middle", last="Last"}];
val test4 = similar_names ([["First","Second"]], {first="First", middle="Middle", last="Last"}) = [{first="First", middle="Middle", last="Last"},{first="Second", middle="Middle", last="Last"}];
val test4 = similar_names ([["Zeroth","First"],["Freddy","F"],["Zeroth","First","Second"]], {first="First", middle="Middle", last="Last"}) = [{first="First", middle="Middle", last="Last"},{first="Zeroth", middle="Middle", last="Last"},{first="Zeroth", middle="Middle", last="Last"},{first="Second", middle="Middle", last="Last"}];
val test4 = similar_names ([["Betty"],["Freddy","F"],["Zeroth","Second"]], {first="First", middle="Middle", last="Last"}) = [{first="First", middle="Middle", last="Last"}];
val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}];

val test5 = card_color (Clubs, Num 2) = Black;
val test5 = card_color (Spades, Jack) = Black;
val test5 = card_color (Diamonds, Num 10) = Red;
val test5 = card_color (Hearts, Ace) = Red;

val test6 = card_value (Clubs, Num 2) = 2;
val test6 = card_value (Clubs, Num 5) = 5;
val test6 = card_value (Clubs, Num 10) = 10;
val test6 = card_value (Clubs, Jack) = 10;
val test6 = card_value (Clubs, Queen) = 10;
val test6 = card_value (Clubs, King) = 10;
val test6 = card_value (Clubs, Ace) = 11;

val test7 = (remove_card ([], (Hearts, Ace), IllegalMove) handle IllegalMove => []) = [];
val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = [];
val test7 = remove_card ([(Hearts, Ace),(Spades, Num 10),(Diamonds, Num 2)], (Hearts, Ace), IllegalMove) = [(Spades, Num 10),(Diamonds, Num 2)];
val test7 = remove_card ([(Hearts, Ace),(Spades, Num 10),(Diamonds, Num 2)], (Spades, Num 10), IllegalMove) = [(Hearts, Ace),(Diamonds, Num 2)];
val test7 = remove_card ([(Hearts, Ace),(Diamonds, Num 2),(Diamonds, Num 2)], (Diamonds, Num 2), IllegalMove) = [(Hearts, Ace),(Diamonds, Num 2)];
val test7 = (remove_card ([(Hearts, Ace),(Spades, Num 10),(Diamonds, Num 2)], (Clubs, Num 10), IllegalMove) handle IllegalMove => []) = [];

val test8 = all_same_color [] = true;
val test8 = all_same_color [(Hearts, Ace)] = true;
val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true;
val test8 = all_same_color [(Hearts, Ace), (Diamonds, Jack), (Hearts, Ace), (Spades, Num 10)] = false;
val test8 = all_same_color [(Diamonds, Num 5), (Diamonds, Jack), (Hearts, Ace), (Spades, Num 10)] = false;
val test8 = all_same_color [(Diamonds, Num 5), (Hearts, Num 10), (Diamonds, Jack), (Hearts, Ace)] = true;
val test8 = all_same_color [(Clubs, Num 5), (Clubs, Jack), (Spades, Ace), (Hearts, Num 10)] = false;
val test8 = all_same_color [(Spades, Num 5), (Spades, Num 10), (Spades, Jack), (Clubs, Ace)] = true;

val test9 = sum_cards [] = 0;
val test9 = sum_cards [(Clubs, Num 2)] = 2;
val test9 = sum_cards [(Clubs, King)] = 10;
val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4;
val test9 = sum_cards [(Clubs, Num 5),(Clubs, Jack),(Hearts, Ace)] = 26;
val test9 = sum_cards [(Spades, Num 2),(Clubs, Jack),(Spades, Num 3),(Diamonds, Queen)] = 25;

val test10 = score ([(Hearts, Num 7),(Clubs, Num 4)],10) = 3;
val test10 = score ([(Hearts, Num 4),(Clubs, Num 6)],10) = 0;
val test10 = score ([(Hearts, Num 7),(Diamonds, Num 4)],10) = 1;
val test10 = score ([(Spades, Num 4),(Clubs, Num 6)],10) = 0;
val test10 = score ([(Hearts, Ace),(Clubs, Ace)],20) = 6;
val test10 = score ([(Hearts, Queen),(Clubs, Num 10)],20) = 0;
val test10 = score ([(Hearts, Queen),(Clubs, Num 5)],20) = 5;
val test10 = score ([(Clubs, Ace),(Clubs, Ace)],20) = 3;
val test10 = score ([(Clubs, King),(Clubs, Ace)],20) = 1;
val test10 = score ([(Hearts, Queen),(Hearts, Num 10)],20) = 0;
val test10 = score ([(Hearts, Queen),(Hearts, Num 5)],20) = 2;

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6;
val test11 = officiate ([(Clubs,Num 9),(Spades,Jack),(Clubs,Num 9),(Spades,Jack),(Spades,Jack)],
                        [Draw,Draw,Discard(Spades,Jack),Draw,Draw,Draw],
                        40)
             = 1;

val test12 = officiate ([(Spades,Ace),(Diamonds,Ace),(Hearts,Num 10)],
                        [Draw,Draw,Draw],
                        32)
             = 0;
val test12 = officiate ([(Clubs,Ace),(Clubs,Ace),(Spades,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Discard(Clubs,Ace),Draw,Draw,Discard(Spades,Ace),Draw,Draw,Draw],
                        42)
             = 3;

val test13 = ((officiate([], [Discard(Hearts,Jack)], 0);
	       false) 
              handle IllegalMove => true);
val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true);

val test14 = score_challenge ([(Diamonds, Num 7),(Spades,Ace),(Spades,Ace)],10) = 1;
val test14 = score_challenge ([(Diamonds, Num 8),(Spades,Ace),(Spades,Ace)],10) = 0;
val test14 = score_challenge ([(Diamonds, Num 9),(Spades,Ace),(Spades,Ace)],10) = 3;
val test14 = score_challenge ([(Spades,Ace),(Clubs, Num 1),(Spades,Ace)],12) = 0;
val test14 = score_challenge ([(Spades,Ace),(Clubs, Num 1),(Spades,Ace)],13) = 0;
val test14 = score_challenge ([(Spades,Ace),(Clubs, Num 1),(Spades,Ace)],14) = 1;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],26) = 1;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],27) = 0;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],28) = 3;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],21) = 4;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],22) = 5;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],23) = 6;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],24) = 7;
val test14 = score_challenge ([(Clubs,Ace),(Spades,Ace),(Hearts, Num 5)],25) = 6;
