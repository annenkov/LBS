// A counter contract
// Based on LIGO examples

type storage = int

// Messages
type parameter =
  Increment of int
| Decrement of int
| Reset

// Type alias for the return type
type return = operation list * storage

let add (store, delta : storage * int) : storage = store + delta
let sub (store, delta : storage * int) : storage = store - delta

// Main access point that dispatches to the entrypoints according to the smart contract parameter.
let main (action, store : parameter * storage) : return =
  let ops = ([] : operation list) in
  match action with
    Increment (n) -> (ops, add (store, n))
  | Decrement (n) -> (ops, sub (store, n))
  | Reset         -> (ops, 0)