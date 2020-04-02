(* Extended version of the auction contract from https://www.michelson-lang.com/contract-a-day.html *)

type storage = {
  auction_start : timestamp;
  auction_end : timestamp;
  canceled : bool;
  highest_bid : tez;
  owner : address;
  bidder : key_hash option;
}

let%init storage (_start : timestamp) (_end : timestamp )
    (_owner : address) =
  { auction_start = _start;
    auction_end = _end;
    canceled = false;
    highest_bid = 0tz;
    owner = _owner;
    bidder = None
  }

let%entry cancel (p : unit) (s : storage) =
  if Current.source () <> s.owner then
    Current.failwith ("Only owner can cancel", s.owner);
  let new_state = s.canceled <- true in
  match s.bidder with
  | Some _bidder ->
      let refund_to = Account.default _bidder in
      let op = Contract.call refund_to s.highest_bid () in
      ([op], new_state)
  | None -> ([], new_state)

let%entry main
    (parameter : key_hash)
    (storage : storage) =

  (* Check if auction has been canceled *)
  if storage.canceled then Current.failwith "Auction canceled";

  (* Check if auction has ended *)
  if Current.time () < storage.auction_start then Current.failwith ("Auction not started");

  (* Check if auction has ended *)
  if Current.time () > storage.auction_end then Current.failwith ("Auction ended");

  let new_bid = Current.amount () in
  let new_bidder = parameter in
  (* Check if new bid is higher that the last *)
  if new_bid <= storage.highest_bid then Current.failwith ("Your bid is too small :)");

  let previous_bidder = storage.bidder in
  let previous_bid = storage.highest_bid in

  (* Set new highest bid in storage *)
  let storage = storage.highest_bid <- new_bid in
  let storage = storage.bidder <- Some new_bidder in

  (* refund previous bid to previous bidder *)
  if previous_bid > 0tz then
    match previous_bidder with
    | Some _bidder ->
        let refund_to = Account.default _bidder in
        let op = Contract.call refund_to previous_bid () in
        ([op], storage)
    | None -> ([],storage)
  else ([],storage)
