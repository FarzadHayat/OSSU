
exception ListLengthMismatch

(* ([1,2,3],[4,5,6],[7,8,9]) -> [(1,4,7),(2,5,8),(3,6,9)] *)
(* 'a list * 'b list * 'c list -> ('a * 'b * 'c) list *)
fun zip3 list_triple =
    case list_triple of
	([],[],[]) => []
      | (a::l1,b::l2,c::l3) => (a,b,c)::zip3 (l1,l2,l3)
      | _ => raise ListLengthMismatch;

(* [(1,4,7),(2,5,8),(3,6,9)] -> ([1,2,3],[4,5,6],[7,8,9]) *)
(* ('a * 'b * 'c) list -> 'a list * 'b list * 'c list *)
fun unzip3 lst =
    case lst of
	[] => ([],[],[])
      | (a,b,c)::rest => let val (l1,l2,l3) = unzip3 rest
			 in (a::l1,b::l2,c::l3) end;
