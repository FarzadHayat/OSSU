
fun sum_triple triple =
    case triple of
	(x, y, z) => x + y + z;

fun full_name r =
    case r of
	{first=x, middle=y, last=z} =>
	x ^ " " ^ y ^ " " ^ z;

fun sum_triple_better triple =
    let val (x, y, z) = triple
    in
	x + y + z
    end;

fun full_name_better r =
    let val {first=x, middle=y, last=z} = r
    in
	x ^ " " ^ y ^ " " ^ z
    end;

fun sum_triple_best (x, y, z) =
    x + y + z;

fun full_name_best {first=x, middle=y, last=z} =
    x ^ " " ^ y ^ " " ^ z;
