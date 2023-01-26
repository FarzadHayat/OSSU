use "hw1.sml";
(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)


val test1_0 = is_older ((1,2,3),(2,3,4)) = true;
val test1_1 = is_older ((1,2,3),(1,2,4)) = true;
val test1_2 = is_older ((1,2,3),(1,3,3)) = true;
val test1_3 = is_older ((1,2,3),(2,2,3)) = true;
val test1_4 = is_older ((1,2,3),(2,0,1)) = true;
val test1_5 = is_older ((1,2,3),(1,2,3)) = false;
val test1_6 = is_older ((1,2,3),(0,1,2)) = false;
val test1_7 = is_older ((1,2,3),(1,2,2)) = false;
val test1_8 = is_older ((1,2,3),(1,1,3)) = false;
val test1_9 = is_older ((1,2,3),(0,2,3)) = false;
val test1_10 = is_older ((1,2,3),(0,3,4)) = false;

val test2_0 = number_in_month ([],2) = 0;
val test2_1 = number_in_month ([(2012,2,28),(2013,12,1)],1) = 0;
val test2_2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1;
val test2_3 = number_in_month ([(2012,5,28),(2013,5,1)],5) = 2;
val test2_4 = number_in_month ([(2012,2,28),(2013,12,1),(2000,12,25),(2000,11,25),(1904,12,1)],12) = 3;

val test3_0 = number_in_months ([],[]) = 0;
val test3_1 = number_in_months ([],[2,3,4]) = 0;
val test3_2 = number_in_months ([(2012,2,28),(2013,12,1)],[]) = 0;
val test3_3 = number_in_months ([(2012,2,28),(2013,12,1)],[2]) = 1;
val test3_4 = number_in_months ([(2012,2,28),(2013,12,1)],[2,12]) = 2;
val test3_5 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3;
val test3_6 = number_in_months ([(2012,2,28),(2013,12,1),(2013,12,2),(2014,12,1),(2011,3,31),(2011,4,28)],[3,12]) = 4;

val test4_0 = dates_in_month ([],2) = [];
val test4_1 = dates_in_month ([(2012,2,28),(2013,12,1)],1) = [];
val test4_2 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)];
val test4_3 = dates_in_month ([(2012,5,28),(2013,5,1)],5) = [(2012,5,28),(2013,5,1)];
val test4_4 = dates_in_month ([(2012,2,28),(2013,12,1),(2000,12,25),(2000,11,25),(1904,12,1)],12) = [(2013,12,1),(2000,12,25),(1904,12,1)];

val test5_0 = dates_in_months ([],[]) = [];
val test5_1 = dates_in_months ([],[2,3,4]) = [];
val test5_2 = dates_in_months ([(2012,2,28),(2013,12,1)],[]) = [];
val test5_3 = dates_in_months ([(2012,2,28),(2013,12,1)],[2]) = [(2012,2,28)];
val test5_4 = dates_in_months ([(2012,2,28),(2013,12,1)],[2,12]) = [(2012,2,28),(2013,12,1)];
val test5_5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)];
val test5_6 = dates_in_months ([(2012,2,28),(2013,12,1),(2013,12,2),(2014,12,1),(2011,3,31),(2011,4,28)],[3,12]) = [(2011,3,31),(2013,12,1),(2013,12,2),(2014,12,1)];

val test6_0 = get_nth (["hi"], 1) = "hi";
val test6_1 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi";
val test6_2 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there";
val test6_3 = get_nth (["hi", "there", "how", "are", "you"], 5) = "you";

val test7_0 = date_to_string (2013, 6, 1) = "June 1, 2013";
val test7_1 = date_to_string (1972, 1, 12) = "January 12, 1972";
val test7_2 = date_to_string (2020, 12, 25) = "December 25, 2020";

val test8_0 = number_before_reaching_sum (1, [1]) = 0;
val test8_1 = number_before_reaching_sum (2, [1,1]) = 1;
val test8_2 = number_before_reaching_sum (19, [0,3,16]) = 2;
val test8_3 = number_before_reaching_sum (5, [1,2,3,4,5]) = 2;
val test8_4 = number_before_reaching_sum (6, [1,2,3,4,5]) = 2;
val test8_5 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3;
val test8_6 = number_before_reaching_sum (11, [1,2,3,4,5]) = 4;
val test8_7 = number_before_reaching_sum (10, [5,4,3,2,1]) = 2;

val test9_0 = what_month 1 = 1;
val test9_1 = what_month 31 = 1;
val test9_2 = what_month 32 = 2;
val test9_3 = what_month 50 = 2;
val test9_4 = what_month 59 = 2;
val test9_5 = what_month 60 = 3;
val test9_6 = what_month 70 = 3;
val test9_7 = what_month 90 = 3;
val test9_8 = what_month 91 = 4;
val test9_9 = what_month 350 = 12;
val test9_10 = what_month 365 = 12;

val test10_0 = month_range (1, 3) = [1,1,1];
val test10_1 = month_range (31, 31) = [1];
val test10_2 = month_range (32, 32) = [2];
val test10_3 = month_range (31, 32) = [1,2];
val test10_4 = month_range (31, 34) = [1,2,2,2];
val test10_5 = month_range (30, 61) = [1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3];
val test10_6 = month_range (363, 365) = [12,12,12];

val test11_0 = oldest([]) = NONE;
val test11_1 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31);
val test11_2 = oldest([(2000,3,28),(2000,3,29),(2000,3,30)]) = SOME (2000,3,28);
val test11_3 = oldest([(2000,3,29),(2000,3,28),(2000,3,30)]) = SOME (2000,3,28);
val test11_4 = oldest([(2000,3,30),(2000,3,29),(2000,3,28)]) = SOME (2000,3,28);
val test11_5 = oldest([(2000,1,5),(2000,1,25),(2000,1,5)]) = SOME (2000,1,5);

val test_unique_only_0 = unique_only [] = [];
val test_unique_only_1 = unique_only [1] = [1];
val test_unique_only_2 = unique_only [1,1,1] = [1];
val test_unique_only_3 = unique_only [1,2,3,4] = [1,2,3,4];
val test_unique_only_4 = unique_only [1,1,2,2,3,3,4,4] = [1,2,3,4];
val test_unique_only_5 = unique_only [1,2,1,3,2,4,3] = [1,2,3,4];
val test_unique_only_6 = unique_only [3,6,5,4,3,3] = [3,6,5,4];

val test12a_0 = number_in_months_challenge ([],[]) = 0;
val test12a_1 = number_in_months_challenge ([],[2,3,4,3]) = 0;
val test12a_2 = number_in_months_challenge ([(2012,2,28),(2013,12,1)],[]) = 0;
val test12a_3 = number_in_months_challenge ([(2012,2,28),(2013,12,1)],[2,2]) = 1;
val test12a_4 = number_in_months_challenge ([(2012,2,28),(2013,12,1)],[2,12,12,2]) = 2;
val test12a_5 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,3,2]) = 3;
val test12a_6 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2013,12,2),(2014,12,1),(2011,3,31),(2011,4,28)],[3,12,3,12]) = 4;

val test12b_0 = dates_in_months_challenge ([],[]) = [];
val test12b_1 = dates_in_months_challenge ([],[2,3,4,3]) = [];
val test12b_2 = dates_in_months_challenge ([(2012,2,28),(2013,12,1)],[]) = [];
val test12b_3 = dates_in_months_challenge ([(2012,2,28),(2013,12,1)],[2,2]) = [(2012,2,28)];
val test12b_4 = dates_in_months_challenge ([(2012,2,28),(2013,12,1)],[2,12,12,2]) = [(2012,2,28),(2013,12,1)];
val test12b_5 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,3,2]) = [(2012,2,28),(2011,3,31),(2011,4,28)];
val test12b_6 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2013,12,2),(2014,12,1),(2011,3,31),(2011,4,28)],[3,12,3,12]) = [(2011,3,31),(2013,12,1),(2013,12,2),(2014,12,1)];

val test13_0 = reasonable_date (1,1,1) = true;
val test13_1 = reasonable_date (1,2,28) = true;
val test13_2 = reasonable_date (1,12,31) = true;
val test13_3 = reasonable_date (2000,11,30) = true;
val test13_4 = reasonable_date (4,2,28) = true;
val test13_5 = reasonable_date (4,2,29) = true;
val test13_6 = reasonable_date (8,2,29) = true;
val test13_7 = reasonable_date (400,2,29) = true;
val test13_8 = reasonable_date (2000,2,29) = true;
val test13_9 = reasonable_date (2024,2,29) = true;
val test13_10 = reasonable_date (0,1,1) = false;
val test13_11 = reasonable_date (1,0,1) = false;
val test13_12 = reasonable_date (1,13,1) = false;
val test13_13 = reasonable_date (1,1,0) = false;
val test13_14 = reasonable_date (1,1,32) = false;
val test13_15 = reasonable_date (1,2,29) = false;
val test13_16 = reasonable_date (1,12,32) = false;
val test13_17 = reasonable_date (2000,13,31) = false;
val test13_18 = reasonable_date (2,2,29) = false;
val test13_19 = reasonable_date (5,2,29) = false;
val test13_20 = reasonable_date (10,2,29) = false;
val test13_21 = reasonable_date (100,2,29) = false;
val test13_22 = reasonable_date (200,2,29) = false;
val test13_23 = reasonable_date (2021,2,29) = false;
val test13_24 = reasonable_date (4,2,30) = false;
val test13_25 = reasonable_date (2024,2,30) = false;
