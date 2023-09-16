
(* (int * int * int) * (int * int * int) -> bool *)
(* return true if first date is older than second date; false otherwise *)
fun is_older (date1 : int * int * int, date2 : int * int * int) =
    let
	val y1 = #1 date1;
	val m1 = #2 date1;
	val d1 = #3 date1;
	val y2 = #1 date2;
	val m2 = #2 date2;
	val d2 = #3 date2;	
    in
	if y1 = y2
	then if m1 = m2
	     then d1 < d2
	     else m1 < m2
	else y1 < y2
    end;

(* (int * int * int) list * int -> int *)
(* produce number of dates in given list that are in the given month *)
fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then 0
    else
	let
	    val rest = number_in_month (tl dates, month);
	in
	    if #2 (hd dates) = month
	    then 1 + rest
	    else rest
	end;

(* (int * int * int) list * int list -> int *)
(* produce number of dates in given list that are in any of the given list of months
   ASSUME: no duplicate months *)
fun number_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then 0
    else number_in_month (dates, hd months) + number_in_months (dates, tl months);
	

(* (int * int * int) list * int -> (int * int * int) list *)
(* produce list of dates in given list that are in the given month *)
fun dates_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then []
    else
	let
	    val rest = dates_in_month (tl dates, month);
	in
	    if #2 (hd dates) = month
	    then (hd dates) :: rest
	    else rest
	end;

(* (int * int * int) list * int list -> (int * int * int) list *)
(* produce list of dates in given list that are in any of the given list of months
   ASSUME: no duplicate months *)
fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months);

(* string list * int -> string *)
(* produce the nth element of the given list where the head of the list is 1st *)
fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth (tl strings, n - 1);

(* (int * int * int) -> string *)
(* given a date, produce string of the form "<month_name> dd, yyyy" *)
fun date_to_string (date : int * int * int) =
    let
	val month_names = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	val year = #1 date;
	val month = #2 date;
	val day = #3 date;
	val year_string = Int.toString year;
	val month_string = get_nth (month_names, month);
	val day_string = Int.toString day;		      
    in
	month_string ^ " " ^ day_string ^ ", " ^ year_string
    end;

(* int * int list -> int *)
(* produce int n such that the first n elements of the list add to less than sum, but the first n+1 elements of the list add to sum or more *)
fun number_before_reaching_sum (sum : int, numbers : int list) =
    let
	val first = hd numbers;
    in
	if sum <= first
	then 0
	else 1 + number_before_reaching_sum (sum - first, tl numbers)
    end;

(* int -> int *)
(* produce int representing the month that the given day of year is in *)
fun what_month (day : int) =
    let
	val month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    in
	1 + number_before_reaching_sum (day, month_days)
    end;

(* int * int -> int list *)
(* produce list containing what month every day in the range[day1,day2] is in *)
fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month day1 :: month_range (day1 + 1, day2);

(* (int * int * int) list -> (int * int * int) option *)
(* produce SOME d for d is oldest date in list, or NONE if list is empty *)
fun oldest (dates : (int * int * int) list) =
    if null dates
    then NONE
    else
	let
	    val first = hd dates;
	    val rest = oldest (tl dates);
	    fun older (date1 : int * int * int, date2 : int * int * int) =
		if is_older (date1, date2)
		then date1
		else date2; 
	in
	    if rest = NONE
	    then SOME first
	    else SOME (older (first, valOf rest))
	end;


(* int list -> int list *)
(* produce list with only the first occurence of each number in list *)
fun unique_only (numbers : int list) =
    let
	fun contains (ns : int list, n) =
	    not (null ns) andalso ((hd ns) = n orelse contains (tl ns, n));
	fun helper (numbers : int list, rsf : int list) =
	    if null numbers
	    then rsf
	    else
		if contains (rsf, hd numbers)
		then helper (tl numbers, rsf)
		else helper (tl numbers, rsf @ ((hd numbers) :: []));
    in
	helper(numbers, [])
    end;

(* (int * int * int) list * int list -> int *)
(* produce number of dates in given list that are in any of the given list of months *)
fun number_in_months_challenge (dates : (int * int * int) list, months : int list) =
    number_in_months (dates, unique_only months);

(* (int * int * int) list * int list -> (int * int * int) list *)
(* produce list of dates in given list that are in any of the given list of months *)
fun dates_in_months_challenge (dates : (int * int * int) list, months : int list) =
    dates_in_months (dates, unique_only months);

(* (int * int * int) -> bool *)
(* produce true if the given date is a real date in the common era *)
(* A “real date” has:
 - A positive year (year 0 did not exist)
 - A month between 1 and 12
 - A day appropriate for the month (February includes the 29th on leap years);
   Leap years are years that are either divisible by 400 or divisible by 4
   but not divisible by 100. *)
fun reasonable_date (date : int * int * int) =
    let
	val year = #1 date;
	val month = #2 date;
	val day = #3 date;
	val real_year = year > 0;
	val real_month = 1 <= month andalso month <= 12;
	val leap_year = (year mod 400 = 0) orelse
			(year mod 4 = 0 andalso year mod 100 <> 0);
	val days_in_feb = if leap_year then 29 else 28
	val month_days = [31, days_in_feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	fun get_nth (nums : int list, n : int) =
	    if n = 1
	    then hd nums
	    else get_nth (tl nums, n - 1);
	val real_day = real_month andalso
		       1 <= day andalso day <= get_nth (month_days, month);
    in
	real_year andalso real_month andalso real_day
    end;
