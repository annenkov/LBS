(* Slightly modified Auction contract from https://www.michelson-lang.com/contract-a-day.html *)


type storage = {
  auction_end : timestamp;
  highest_bid : tez;
  bidder : key_hash option;
}

let%init storage (_end : timestamp ) =
  { auction_end = _end; 
    highest_bid = 0DUN; 
    bidder = None
  }


let%entry submit_auction
    (parameter : key_hash)
    (storage : storage) =

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

  (* refund previous bid to the previous bidder *) 
  match previous_bidder with
  | Some _bidder ->
      let refund_to = Account.default _bidder in
      let op = Contract.call refund_to previous_bid () in
      ([op], storage)
  | None -> ([],storage)

