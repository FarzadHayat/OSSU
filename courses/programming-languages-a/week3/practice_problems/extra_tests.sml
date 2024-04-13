use "extra.sml";

val test1 = pass_or_fail {id = 1, grade = NONE} = fail;
val test1 = pass_or_fail {id = 1, grade = SOME 74} = fail;
val test1 = pass_or_fail {id = 1, grade = SOME 75} = pass;

val test2 = has_passed {id = 1, grade = NONE} = false;
val test2 = has_passed {id = 1, grade = SOME 74} = false;
val test2 = has_passed {id = 1, grade = SOME 75} = true;

val test3 = number_passed [] = 0;
val test3 = number_passed [{id = 1, grade = NONE}, {id = 1, grade = SOME 74}] = 0;
val test3 = number_passed [{id = 1, grade = NONE}, {id = 1, grade = SOME 74}, {id = 1, grade = SOME 75}] = 1;
val test3 = number_passed [{id = 1, grade = NONE}, {id = 1, grade = SOME 75}, {id = 1, grade = SOME 100}] = 2;

val test4 = number_misgraded [] = 0;
val test4 = number_misgraded [(fail, {id = 1, grade = NONE}), (fail, {id = 1, grade = SOME 74})] = 0;
val test4 = number_misgraded [(fail, {id = 1, grade = NONE}), (pass, {id = 1, grade = SOME 74})] = 1;
val test4 = number_misgraded [(fail, {id = 1, grade = NONE}), (pass, {id = 1, grade = SOME 74}), (pass, {id = 1, grade = SOME 75})] = 1;
val test4 = number_misgraded [(fail, {id = 1, grade = NONE}), (fail, {id = 1, grade = SOME 75}), (fail, {id = 1, grade = SOME 100})] = 2;

val test5 = tree_height leaf = 0;
val test5 = tree_height (node {left=leaf, right=leaf, value=1}) = 1;
val test5 = tree_height (node {left=node {left=leaf, right=leaf, value=2}, right=leaf, value=1}) = 2;
val test5 = tree_height (node {left=node {left=leaf, right=leaf, value=2}, right=node {left=leaf, right=leaf, value=3}, value=1}) = 2;
val test5 = tree_height (node {left=node {left=node {left=leaf, right=leaf, value=3}, right=leaf, value=2}, right=node {left=leaf, right=leaf, value=4}, value=1}) = 3;
val test5 = tree_height (node {left=node {left=leaf, right=leaf, value=2}, right=node {left=leaf, right=node {left=node {left=leaf, right=leaf, value=5}, right=leaf, value=4}, value=3}, value=1}) = 4;

val test6 = sum_tree leaf = 0;
val test6 = sum_tree (node {left=leaf, right=leaf, value=1}) = 1;
val test6 = sum_tree (node {left=node {left=leaf, right=leaf, value=2}, right=leaf, value=1}) = 3;
val test6 = sum_tree (node {left=node {left=leaf, right=leaf, value=2}, right=node {left=leaf, right=leaf, value=3}, value=1}) = 6;
val test6 = sum_tree (node {left=node {left=node {left=leaf, right=leaf, value=3}, right=leaf, value=2}, right=node {left=leaf, right=leaf, value=4}, value=1}) = 10;
val test6 = sum_tree (node {left=node {left=leaf, right=leaf, value=2}, right=node {left=leaf, right=node {left=node {left=leaf, right=leaf, value=5}, right=leaf, value=4}, value=3}, value=1}) = 15;

val test7 = gardener leaf = leaf;
val test7 = gardener (node {left=leaf, right=leaf, value=leave_me_alone}) = node {left=leaf, right=leaf, value=leave_me_alone};
val test7 = gardener (node {left=leaf, right=leaf, value=prune_me}) = leaf;
val test7 = gardener (node {left=node {left=leaf, right=leaf, value=prune_me}, right=leaf, value=leave_me_alone}) = node {left=leaf, right=leaf, value=leave_me_alone};

val test8_1 = last [] = NONE;
val test8_1 = last [1] = SOME 1;
val test8_1 = last [1, 2] = SOME 2;
val test8_1 = last [1, 2, 3] = SOME 3;

val test8_2 = take ([1], 0) = 1;
val test8_2 = take ([1, 2, 3], 0) = 1;
val test8_2 = take ([1, 2, 3], 1) = 2;
val test8_2 = take ([1, 2, 3], 2) = 3;