(* A counter contract with a reset option *)
[%%version 1.0]

type storage = nat

let%init storage = 0p

let inc (increment : nat) : storage -> storage =
  fun (s : storage) -> s + increment

(*The first entry point *)
let%entry increment (p : nat) (s : storage) =
  ( [], inc p s)

(* The second entry point *)
let%entry reset (u : unit) (s : storage) = ([], 0p)
