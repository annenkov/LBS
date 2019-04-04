(* A counter contract *)
[%%version 1.0]

type storage = nat

let%init storage = 0p

(* state trasforming function, applied to a concrete
   increment has type [storge -> storage] *)
let inc  (increment : nat) : storage -> storage =
  fun (s : storage) -> s + increment

(* entry point takes two arguments *)
let%entry counter_entry (p : nat) (s : storage) =
  ( [], inc p s)
