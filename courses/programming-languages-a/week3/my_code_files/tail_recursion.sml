
fun fact n =
    if n=0
    then 1
    else n*fact(n-1);

fun fact_better n =
    let fun aux (n,acc) =
	    if n=0
	    then acc
	    else aux(n-1,n*acc);
    in
	aux (n,1)
    end;
