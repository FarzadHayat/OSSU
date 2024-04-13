type student_id = int
type grade = int (* must be in 0 to 100 range *)
type final_grade = { id : student_id, grade : grade option }
datatype pass_fail = pass | fail

(* 1. return pass_fail to determine if the grade has passed or failed *)
fun pass_or_fail {grade : int option, id : 'a} =
    case grade of
        NONE => fail
        | SOME x => if x >= 75 then pass else fail;

(* 2. return true if the grade has passed *)
fun has_passed {grade : int option, id : 'a} =
    case pass_or_fail {grade = grade, id = id} of
        pass => true
        | fail => false;

(* 3. return how many grades in the list have passed *)
fun number_passed (grades : final_grade list) =
    case grades of
        [] => 0
        | x::xs => if has_passed x then 1 + number_passed xs else number_passed xs;

(* 4. return number of misgraded grades *)
fun number_misgraded (assigned_grades : (pass_fail * final_grade) list) =
    case assigned_grades of
        [] => 0
        | (x, y)::xs => if x = pass_or_fail y then number_misgraded xs else 1 + number_misgraded xs;

datatype 'a tree = leaf 
                 | node of { value : 'a, left : 'a tree, right : 'a tree }
datatype flag = leave_me_alone | prune_me

(* 5. returns the height of a tree *)
fun tree_height (t : 'a tree) =
    case t of
        leaf => 0
        | node {value = v, left = l, right = r} => 1 + Int.max(tree_height l, tree_height r);

(* 6. returns sum of all values in the tree nodes *)
fun sum_tree (t : int tree) =
    case t of
        leaf => 0
        | node {value = v, left = l, right = r} => v + sum_tree l + sum_tree r;

(* 7. returns tree with all nodes marked with prune_me replaced with leaves *)
fun gardener (t : flag tree) =
    case t of
        leaf => leaf
        | node {value = v, left = l, right = r} =>
            case v of prune_me => leaf
                    | leave_me_alone => node {value = v, left = gardener l, right = gardener r};

(* 8. Re-implementing various functions provided in the SML standard libraries for lists and options. *)
fun last (lst : 'a list) =
    case lst of
        [] => NONE
        | [x] => SOME x
        | x::xs => last xs;

fun take (lst : 'a list, i : int) =
    case lst of
        [] => raise Subscript
        | x::xs => if i = 0 then x else take (xs, i - 1);

