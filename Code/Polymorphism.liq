(** Polymorphism is supported, but in a limited form. The documentation says "Polymorphic functions are transformed into several monomorphized versions." *)

(** This example does not work: the storage type becomes a unit in Michelson *)

type 'a myty =
  | Blah of 'a
  | Blahblah

type storage = myty nat

let%entry submit_auction
    (parameter : key_hash)
    (storage : storage) =
  ([], Blah 1p)
