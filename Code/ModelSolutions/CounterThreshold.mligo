// A counter contract with a threshold

type storage = {count : int; threshold : int}

// Messages
type parameter =
  Increment of int
| Decrement of int
| Reset

// Type alias for the return type
type return = operation list * storage

let init : storage = {count = 0; threshold = 2}

let add (store, delta : storage * int) : storage = {store with count = store.count + delta}
let sub (store, delta : storage * int) : storage = {store with count = store.count - delta}

// Main access point that dispatches to the entrypoints according to the smart contract parameter.
let main (action, store : parameter * storage) : return =
  let ops = ([] : operation list) in
  if store.count > store.threshold then failwith "Threshold reached"
  else
  match action with
    Increment (n) -> (ops, add (store, n))
  | Decrement (n) -> (ops, sub (store, n))
  | Reset         -> (ops, {store with count = 0})