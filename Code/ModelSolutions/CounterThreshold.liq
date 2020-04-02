(* A counter contract with a threshold *)
[%%version 2.0]

type storage = {counter : nat; threshold : nat}


let%init storage (threshold : nat) = {counter = 0p; threshold = threshold}

let inc (increment : nat) =
  fun (s : storage) ->
    let curr = s.counter in
    s.counter <- curr + increment

(* The first entry point *)
let%entry increment (p : nat) (s : storage) =
  if s.counter + p <= s.threshold then
    ( [], inc p s)
  else
    Current.failwith ("Threshold exceeded", s.threshold, s.counter+p)

(* The second entry point *)
let%entry reset (u : unit) (s : storage) = ([], s.counter <- 0p)
