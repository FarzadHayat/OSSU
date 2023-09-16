
fun hd xs =
    case xs of
	[] => raise List.Empty
      | x::_ => x;

exception MyUndesirableCondition;

exception MyOtherException of int * int;

fun mydiv (x,y) =
    if y=0
    then raise MyUndesirableCondition
    else x div y;

fun f 0 = raise MyOtherException (1,2)
  | f 1 = raise MyOtherException (3,3)
  | f x = x;

fun g y =
    f y handle MyOtherException (1,2) => ~1
	    |  MyOtherException (a,b) => 5;

val a = g 0;
val b = g 1;
val c = g 2;
