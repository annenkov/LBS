// A simple auction

(* The auction uses `key_hash` to store the previuos bidder.
   Note that key_hash is a special type of address. Such addresses are called implicit accounts.
   Implicit account do not contain assocuated smart contract code, they are "user accounts"
   Sending money to such account doesn't involve code execution.
   Using `address` could lead to a problem: refund can fail, because the receving smart contract fails.
   In this case it is not possible to overbid the previuos bid.
   Using 'key_hash' makes this less general, but more safe. *)


type storage = {
  auction_end : timestamp;
  highest_bid : tez;
  bidder : key_hash option; // hash of the previuos bidder's public key, or nothing

}

// Messages
type parameter = key_hash // hash of a new bidder's public key

// Type alias for the return type
type return = operation list * storage


let inital_storage (_end : timestamp ) =
  { auction_end = _end;
    highest_bid = 0tez;
    bidder = None
  }

let main (bidder, store : parameter * storage) : return =
  (* Check if auction has ended *)
  if Tezos.now > store.auction_end then failwith ("Auction ended")
    else
    let new_bid = Tezos.amount in
    let new_bidder = bidder in
  (* Check if new bid is higher that the last *)
    if new_bid <= store.highest_bid then failwith ("Bid is too small :)")
    else
    let previous_bidder = store.bidder in
    let previous_bid = store.highest_bid in

  (* Set new highest bid in storage *)
    let storage = {store with highest_bid = new_bid; bidder = Some new_bidder} in

  (* refund previous bid to the previous bidder *)
    match previous_bidder with
    | Some pbidder ->
        let refund_to = Tezos.implicit_account pbidder in
        let op = Tezos.transaction () previous_bid refund_to in
        ([op], store)
    | None -> ([], store)
