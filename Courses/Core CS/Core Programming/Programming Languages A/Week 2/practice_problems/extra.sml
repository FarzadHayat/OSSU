
(* int list -> int *)
(* 1. adds integers in list with alternating sign starting with subtract *)
fun alternate (nums : int list) =
    let
	fun helper (nums : int list, is_negative : bool) =
	    if null nums
	    then 0
	    else if is_negative
	    then helper (tl nums, false) - hd nums
	    else helper (tl nums, true) + hd nums;
    in
	helper (nums, false)
    end;

(* 2. given non-empty list, produce pair (min, max)
   of the minimum and maximum of the numbers in the list *)
fun min_max (nums : int list) =
    let
	fun smaller (first : int, second : int) =
	    if first < second
	    then first
	    else second;
	fun bigger (first : int, second : int) =
	    if first > second
	    then first
	    else second;
	fun helper (nums : int list, min : int, max : int) =
	    if null nums
	    then (min, max)
	    else helper (tl nums,
			 smaller(hd nums, min),
			 bigger(hd nums, max));
    in
	helper (tl nums, hd nums, hd nums)
    end;
			     
(* int list -> int list *)
(* 3. returns list of partial sums of numbers in list *)
fun cumsum (nums : int list) =
    let
	fun helper (nums : int list, sum : int) =
	    if null nums
	    then []
	    else sum + hd nums :: helper (tl nums, sum + hd nums);
    in
	helper (nums, 0)
    end;

(* string option -> string *)
(* 4. return string "Hello there, ...!" where dots is the value of name
   if name is SOME; or "you" if name is NONE *)
fun greeting (name : string option) =
    let
	val name_string = if isSome name then valOf name else "you";
    in
	"Hello there, " ^ name_string ^ "!"
    end;

(* int list * int list -> int list *)
(* 5. repeat the integers in the lst1 according to the numbers indicated in lst2
   ASSUME: lst2 contains only non-negative integers *)
fun repeat (lst1 : int list, lst2 : int list) =
    let
	fun repeat_n_times (num : int, n : int) =
	    if n = 0
	    then []
	    else num :: repeat_n_times (num, n - 1);
    in
	if null lst1 orelse null lst2
	then []
	else repeat_n_times (hd lst1, hd lst2) @ repeat (tl lst1, tl lst2)
    end;

(* int option * int option -> int option *)
(* 6. return sum option of two int options if both are present;
   or NONE if at least one of the two arguments is NONE *)
fun addOpt (num1 : int option, num2 : int option) =
    if isSome num1 andalso isSome num2
    then SOME (valOf num1 + valOf num2)
    else NONE;

(* int option list -> int option *)
(* 7. returns sum of adding all the integer values in option list
   If list does not contain any SOME in it (they are all NONE or
   list is empty), then return NONE *)
fun addAllOpt (nums : int option list) =
    let
	fun helper (nums : int option list) =
	    if null nums
	    then 0
	    else if isSome (hd nums)
	    then valOf (hd nums) + helper (tl nums)
	    else helper (tl nums);
	fun all_none_or_empty (nums : int option list) =
	    null nums orelse (hd nums = NONE andalso all_none_or_empty (tl nums));
    in
	if all_none_or_empty (nums)
	then NONE
	else SOME (helper nums)
    end;

(* bool list -> bool *)
(* 8. return true if there is at least one true in the list; otherwise return false *)
(* if empty then return false because there is no true *)
fun any (lst : bool list) =
    if null lst
    then false
    else hd lst orelse any (tl lst);

(* bool list -> bool *)
(* 9. return true if all bools in list are true; otherwise return false *)
(* if empty then return true because there is no false *)
fun all (lst : bool list) =
    if null lst
    then true
    else hd lst andalso all (tl lst);

(* int list * int list -> int * int *)
(* 10. given two lists of integers creates consecutive pairs; stop when one list is empty *)
fun zip (lst1 : int list, lst2 : int list) =
    if null lst1 orelse null lst2
    then []
    else (hd lst1, hd lst2) :: zip (tl lst1, tl lst2);

(* int list * int list -> int * int *)
(* 11. given two lists of integers creates consecutive pairs *)
(* when one list is empty start recycling from its start until the other list completes *)
fun zipRecycle (lst1 : int list, lst2 : int list) =
    let
	fun max (num1 : int, num2 : int) =
	    if num1 > num2
	    then num1
	    else num2;

	fun get (n : int, lst : int list) =
	    if n = 0
	    then hd lst
	    else get (n - 1, tl lst);
	
	fun helper (lst1 : int list, lst2 : int list, i : int, stop : int) =
	    let
		val first = get (i mod (length lst1), lst1);
		val second = get (i mod (length lst2), lst2);
		val pair = (first, second);
	    in
		if i = stop
		then []
		else pair :: helper (lst1, lst2, i + 1, stop)
	    end;
    in
	if null lst1 orelse null lst2
	then []
	else helper (lst1, lst2, 0, max(length lst1, length lst2))
    end;

(* int list * int list -> (int * int) list option *)
(* 12. if lists are the same length return SOME option
   of their consecutive pairs otherwise return NONE *)
fun zipOpt (lst1 : int list, lst2 : int list) =
    if length lst1 = length lst2
    then SOME (zip (lst1, lst2))
    else NONE;

(* (string * int) list * string -> int option *)
(* 13. if phrase is the first of an element in list of pairs, then return SOME
   option of the second of that element; otherwise return the NONE option *)
fun lookup (pairs : (string * int) list, phrase : string) =
    if null pairs
    then NONE
    else if #1 (hd pairs) = phrase
    then SOME (#2 (hd pairs))
    else lookup (tl pairs, phrase);

(* int list -> int list * int list *)
(* 14. return list separated into two lists:
   non-negatives integers and negative integers;
   keep relative order from original list *)
fun splitup (lst : int list) =
    let
	fun helper (lst : int list, naturals : int list, negatives : int list) =
	    if null lst
	    then (naturals, negatives)
	    else if hd lst < 0
	    then helper (tl lst, naturals, negatives @ [hd lst])
	    else helper (tl lst, naturals @ [hd lst], negatives);
    in
	helper (lst, [], [])
    end;

(* int list * int -> int list * int list *)
(* 15. return list separated into two lists:
   more than or equal to n and numbers less than n
   keep relative order from original list *)
fun splitAt (lst : int list, n : int) =
    let
	fun helper (lst : int list, naturals : int list, negatives : int list) =
	    if null lst
	    then (naturals, negatives)
	    else if hd lst < n
	    then helper (tl lst, naturals, negatives @ [hd lst])
	    else helper (tl lst, naturals @ [hd lst], negatives);
    in
	helper (lst, [], [])
    end;

(* int list -> bool *)
(* 16. return true if list is sorted in increasing order; otherwise return false *)
fun isSorted (lst : int list) =
    if null lst orelse null (tl lst)
    then true
    else hd lst <= hd (tl lst) andalso isSorted (tl lst);
		     
(* int list -> bool *)
(* 17. return true if list is sorted in either increasing or decreasing order;
   otherwise return false *)
fun isAnySorted (lst : int list) =
    let
	fun reverse (lst : int list) =
	    if null lst
	    then []
	    else reverse (tl lst) @ [hd lst];
    in
	isSorted lst orelse isSorted (reverse lst)
    end;

(* 18 ... 25 *)
