Warm-up Exercises
==================

Use the online Liquidity editor [https://www.liquidity-lang.org/edit/](https://www.liquidity-lang.org/edit/).

See the `Code` folder for the handout code.

See the `Code/ModelSolutions` folder for solutions to the warm-up exercises.

Extend the "counter" contract (*)
-----------------------------------

Add a threshold functionality to the `counter` contract: if the increment + current stored counter value is greater the a threshold the method invocation should fail. Make threshold a parameter to the `init` method.

Extend the auction contract (**)
--------------------------------
Modify the auction contract (see `Code/Auction.liq`)

Particularly, add the following functionality:

* auction start date;
* if the current date is less then the start date, contract should throw an error;
* an auction owner (use `address` type for this field);
* auction can be canceled by the owner (if there are funds on the contract - they must be refunded);
* if the auction is canceled, contract should throw an error.

NOTE: to test if the cancel method can be called only by the owner (before deployment), you might want to use the following code snippet to determine your current account address (it might different from your real account address, which you can see at the top menu bar to the left from your balance):

```
type storage = address

let%entry main () storage =
  let addr = Current.source () in 
  [], addr
```
When deploying the contract you can set the owner to yourself. To do that use the address at the top menu bar to the left from your balance.

Homework
========

Extend the action contract further
----------------------------------
The idea is to store map `(key_hash,amount) map` (or `(address,amount) map`, see note below) of bidders and corresponding amounts. That would allow to refund on request from a user after the auction ends.
I might get some inspiration from this Solidity tutorial:
https://medium.com/@bryn.bellomy/solidity-tutorial-building-a-simple-auction-contract-fcc918b0878a

Note on `key_hash` vs `address`: `key_hash` represents user account that do not contain code, while `address` is for both user accounts and contracts. Transfers `key_hash` never execute any code and cannot run out of gas, but storing `key_hash` makes contracts less general, because this disallows contract addresses. Also note, `Current.sender ()` returns `address` and comparing `key_hash` it would require some manipulations (`address` might not be a user account in general).
Read more [here](https://tezos.stackexchange.com/questions/2311/what-are-the-differences-between-key-key-hash-address-contract-and-signature).

Implement the Namecoin contract
-------------------------------

The Namecoin contract is a name registration service:

* allows to register names that are not yet taken (users have to pay a registration fee);
* the contract stores names mapped to owners and some (arbitrary) data; you may choose something like `type name_entry = {owner : address; data : string}`;
* owners can update their entries (users have to pay an update fee);
* the entries can be queried by name.

You might get some inspiration from the Solidity implementation of the Namespace contract (see [NamecoinSolidity](NamecoinSolidity.pdf) - an example by Joseph Bonneau. The promise and peril of smart contracts.)

Concordium's Midlang
====================

For those of you, who decided to try Midlang.

* download the archive with binaries, exercises and instructions from the LBS course page;
* unpack the archive an follow `Instructions.md`;
* use Elm plugins for syntax highlighting (find more [here](https://github.com/sporto/awesome-elm/blob/master/README.md#editor-plugins));
* do the same exercises as for Liquidity (the hand-out code and model solutions for the warm-up exercises are in the archive);
* currently, the binaries were tested for Mac and Linux, might be possible to use WSL on Windows (more details in `Instructions.md`);
* instead of deploying your contracts (not possible, currently), write unit tests for the main functionality;
* Please send your feedback on your Midlang experience to [fh@concordium.com](fh@concordium.com).
