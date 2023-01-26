use "extra.sml";

val test1_0 = alternate [] = 0;
val test1_1 = alternate [5] = 5;
val test1_2 = alternate [5,1] = 5 - 1;
val test1_3 = alternate [5,~1] = 5 - ~1;
val test1_4 = alternate [1,2,3] = 1 - 2 + 3;
val test1_5 = alternate [1,2,3,4] = 1 - 2 + 3 - 4;
val test1_6 = alternate [~2,0,10,~5,3] = ~2 - 0 + 10 - ~5 + 3;

val test2_0 = min_max [1] = (1,1);
val test2_1 = min_max [1,2,3,4,5] = (1,5);
val test2_2 = min_max [5,4,3,2,1] = (1,5);
val test2_3 = min_max [~5,5,~10,0,3,~3] = (~10,5);
val test2_4 = min_max [~3,3,5,~5,10,~0] = (~5,10);

val test3_0 = cumsum [] = [];
val test3_1 = cumsum [1] = [1];
val test3_2 = cumsum [1,2,3] = [1,3,6];
val test3_3 = cumsum [1,4,20] = [1,5,25];
val test3_4 = cumsum [~3,0,3] = [~3,~3,0];
val test3_5 = cumsum [0,~5,10,2,~3] = [0,~5,5,7,4];

val test4_0 = greeting NONE = "Hello there, you!";
val test4_1 = greeting (SOME "Joe") = "Hello there, Joe!";

val test5_0 = repeat ([],[]) = [];
val test5_1 = repeat ([1],[]) = [];
val test5_2 = repeat ([],[1]) = [];
val test5_3 = repeat ([1,2,3],[1,2,3]) = [1,2,2,3,3,3];
val test5_4 = repeat ([1,2,3],[4,0,3]) = [1,1,1,1,3,3,3];
val test5_5 = repeat ([~1,2,0,4],[4,0,3]) = [~1,~1,~1,~1,0,0,0];
val test5_6 = repeat ([~1,2,0],[4,0,3,1]) = [~1,~1,~1,~1,0,0,0];

val test6_0 = addOpt (NONE,NONE) = NONE;
val test6_1 = addOpt (SOME 5,NONE) = NONE;
val test6_2 = addOpt (NONE,SOME 5) = NONE;
val test6_3 = addOpt (SOME 3,SOME 5) = SOME 8;
val test6_4 = addOpt (SOME ~4,SOME 0) = SOME ~4;

val test7_0 = addAllOpt [] = NONE;
val test7_1 = addAllOpt [NONE] = NONE;
val test7_2 = addAllOpt [NONE,NONE] = NONE;
val test7_3 = addAllOpt [SOME 0] = SOME 0;
val test7_4 = addAllOpt [SOME 0, NONE, SOME 0] = SOME 0;
val test7_5 = addAllOpt [SOME 5, SOME ~1, NONE, SOME 0] = SOME 4;
val test7_6 = addAllOpt [NONE, SOME 10, SOME ~5, NONE, SOME 2] = SOME 7;

val test8_0 = any [] = false;
val test8_1 = any [false] = false;
val test8_2 = any [false,false,false] = false;
val test8_3 = any [true] = true;
val test8_4 = any [false,true,false] = true;
val test8_5 = any [true,false,true] = true;
val test8_6 = any [true,true,true] = true;

val test9_0 = all [] = true;
val test9_1 = all [false] = false;
val test9_2 = all [false,false,false] = false;
val test9_3 = all [true] = true;
val test9_4 = all [false,true,false] = false;
val test9_5 = all [true,false,true] = false;
val test9_6 = all [true,true,true] = true;

val test10_0 = zip ([],[]) = [];
val test10_1 = zip ([1],[]) = [];
val test10_2 = zip ([],[4]) = [];
val test10_3 = zip ([1,2,3],[]) = [];
val test10_4 = zip ([],[4,5,6]) = [];
val test10_5 = zip ([1],[4]) = [(1,4)];
val test10_6 = zip ([1,2,3],[4,5,6]) = [(1,4),(2,5),(3,6)];
val test10_7 = zip ([1,2,3],[4,5]) = [(1,4),(2,5)];
val test10_8 = zip ([2,3],[4,5,6]) = [(2,4),(3,5)];
val test10_9 = zip ([1,2,3],[4]) = [(1,4)];
val test10_10 = zip ([1],[4,5,6]) = [(1,4)];

val test11_0 = zipRecycle ([],[]) = [];
val test11_1 = zipRecycle ([1],[]) = [];
val test11_2 = zipRecycle ([],[4]) = [];
val test11_3 = zipRecycle ([1,2,3],[]) = [];
val test11_4 = zipRecycle ([],[4,5,6]) = [];
val test11_5 = zipRecycle ([1],[4]) = [(1,4)];
val test11_6 = zipRecycle ([1,2,3],[4,5,6]) = [(1,4),(2,5),(3,6)];
val test11_7 = zipRecycle ([1,2,3],[4,5]) = [(1,4),(2,5),(3,4)];
val test11_8 = zipRecycle ([2,3],[4,5,6]) = [(2,4),(3,5),(2,6)];
val test11_9 = zipRecycle ([1,2,3],[4]) = [(1,4),(2,4),(3,4)];
val test11_10 = zipRecycle ([1],[4,5,6]) = [(1,4),(1,5),(1,6)];
val test11_11 = zipRecycle ([1,2,3],[1,2,3,4,5,6,7]) = [(1,1),(2,2),(3,3),(1,4),(2,5),(3,6),(1,7)];
val test11_11 = zipRecycle ([7,6,5,4,3,2,1],[1,2,3]) = [(7,1),(6,2),(5,3),(4,1),(3,2),(2,3),(1,1)];

val test12_0 = zipOpt ([],[]) = SOME [];
val test12_1 = zipOpt ([1],[]) = NONE;
val test12_2 = zipOpt ([],[4]) = NONE;
val test12_3 = zipOpt ([1,2,3],[]) = NONE;
val test12_4 = zipOpt ([],[4,5,6]) = NONE;
val test12_5 = zipOpt ([1],[4]) = SOME [(1,4)];
val test12_6 = zipOpt ([1,2,3],[4,5,6]) = SOME [(1,4),(2,5),(3,6)];
val test12_7 = zipOpt ([1,2,3],[4,5]) = NONE;
val test12_8 = zipOpt ([2,3],[4,5,6]) = NONE;
val test12_9 = zipOpt ([1,2,3],[4]) = NONE;
val test12_10 = zipOpt ([1],[4,5,6]) = NONE;

val test13_0 = lookup ([], "") = NONE;
val test13_1 = lookup ([], "first") = NONE;
val test13_2 = lookup ([("first",1),("second",2),("third",3)], "") = NONE;
val test13_3 = lookup ([("first",1),("second",2),("third",3)], "fir") = NONE;
val test13_4 = lookup ([("first",1),("second",2),("third",3)], "first") = SOME 1;
val test13_5 = lookup ([("first",1),("second",2),("third",3)], "second") = SOME 2;
val test13_6 = lookup ([("first",1),("second",2),("third",3)], "third") = SOME 3;
val test13_7 = lookup ([("first",1),("second",2),("third",3)], "fourth") = NONE;

val test14_0 = splitup [] = ([],[]);
val test14_1 = splitup [1] = ([1],[]);
val test14_2 = splitup [0] = ([0],[]);
val test14_3 = splitup [~1] = ([],[~1]);
val test14_4 = splitup [1,0,5] = ([1,0,5],[]);
val test14_5 = splitup [~1,~4,~10] = ([],[~1,~4,~10]);
val test14_6 = splitup [1,0,5,~1,~4,~10] = ([1,0,5],[~1,~4,~10]);
val test14_7 = splitup [~1,~4,~10,1,0,5] = ([1,0,5],[~1,~4,~10]);
val test14_8 = splitup [0,~1,~4,~10,1,~2,6,20,0,~9,5,~13] = ([0,1,6,20,0,5],[~1,~4,~10,~2,~9,~13]);

val test15_0 = splitup [] = ([],[]);
val test15_1 = splitup [1] = ([1],[]);
val test15_2 = splitup [0] = ([0],[]);
val test15_3 = splitup [~1] = ([],[~1]);
val test15_4 = splitup [1,0,5] = ([1,0,5],[]);
val test15_5 = splitup [~1,~4,~10] = ([],[~1,~4,~10]);
val test15_6 = splitup [1,0,5,~1,~4,~10] = ([1,0,5],[~1,~4,~10]);
val test15_7 = splitup [~1,~4,~10,1,0,5] = ([1,0,5],[~1,~4,~10]);
val test15_8 = splitup [0,~1,~4,~10,1,~2,6,20,0,~9,5,~13] = ([0,1,6,20,0,5],[~1,~4,~10,~2,~9,~13]);

val test15_0 = splitAt ([], 0) = ([],[]);
val test15_1 = splitAt ([1], 0) = ([1],[]);
val test15_2 = splitAt ([0], 0) = ([0],[]);
val test15_3 = splitAt ([~1], 0) = ([],[~1]);
val test15_4 = splitAt ([1,0,5], 0) = ([1,0,5],[]);
val test15_5 = splitAt ([~1,~4,~10], 0) = ([],[~1,~4,~10]);
val test15_6 = splitAt ([1,0,5,~1,~4,~10], 0) = ([1,0,5],[~1,~4,~10]);
val test15_7 = splitAt ([~1,~4,~10,1,0,5], 0) = ([1,0,5],[~1,~4,~10]);
val test15_8 = splitAt ([0,~1,~4,~10,1,~2,6,20,0,~9,5,~13], 0) = ([0,1,6,20,0,5],[~1,~4,~10,~2,~9,~13]);
val test15_9 = splitAt ([1], 1) = ([1],[]);
val test15_10 = splitAt ([0], 1) = ([],[0]);
val test15_11 = splitAt ([~1], ~1) = ([~1],[]);
val test15_12 = splitAt ([1,0,5], 2) = ([5],[1,0]);
val test15_13 = splitAt ([~1,~4,~10], ~2) = ([~1],[~4,~10]);
val test15_14 = splitAt ([1,0,5,~1,~4,~10], ~4) = ([1,0,5,~1,~4],[~10]);
val test15_15 = splitAt ([~1,~4,~10,1,0,5], ~4) = ([~1,~4,1,0,5],[~10]);
val test15_16 = splitAt ([0,~1,~4,~10,1,~2,6,20,0,~9,5,~13], ~10) = ([0,~1,~4,~10,1,~2,6,20,0,~9,5],[~13]);
val test15_17 = splitAt ([0,~1,~4,~10,1,~2,6,20,0,~9,5,~13], 6) = ([6,20],[0,~1,~4,~10,1,~2,0,~9,5,~13]);

val test16_0 = isSorted [] = true;
val test16_1 = isSorted [0] = true;
val test16_2 = isSorted [1,2,3,4,5] = true;
val test16_3 = isSorted [~5,~2,~2,0,0,1,4,4,9] = true;
val test16_4 = isSorted [1,0] = false;
val test16_5 = isSorted [5,1,1,0,~2,~2] = false;
val test16_6 = isSorted [9,~2,1,0,~2,4,~5] = false;

val test17_0 = isAnySorted [] = true;
val test17_1 = isAnySorted [0] = true;
val test17_2 = isAnySorted [1,2,3,4,5] = true;
val test17_3 = isAnySorted [~5,~2,~2,0,0,1,4,4,9] = true;
val test17_4 = isAnySorted [1,0] = true;
val test17_5 = isAnySorted [5,1,1,0,~2,~2] = true;
val test17_6 = isAnySorted [9,~2,1,0,~2,4,~5] = false;
