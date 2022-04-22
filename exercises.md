Warm-up Exercises
==================

Use the online CameLIGO editor [https://ide.ligolang.org/](https://ide.ligolang.org/).
Pick `CameLIGO` for the editor's language.

See the `Code` folder for the handout code.

See the `Code/ModelSolutions` folder for solutions to the counter exercise.

Extend the "counter" contract (*)
-----------------------------------

Add a threshold functionality to the `counter` contract: if the current stored counter value is greater than the threshold, the method invocation should fail. 
Use records to add a threshold field to the state.

Extend the auction contract (**)
--------------------------------
Modify the auction contract (see `Code/auction.mligo`)

Particularly, add the following functionality:

* auction start date;
* if the current date is less then the start date, contract should throw an error;
* an auction owner (use `address` type for this field);
* auction can be canceled by the owner (if there are funds on the contract - they must be refunded);
* if the auction is canceled, contract should throw an error.

Homework
========

Extend the action contract further
----------------------------------

The idea is to store map `(key_hash,amount) map` (or `(address,amount) map`, see note below) of bidders and corresponding amounts. That would allow to refund on request from a user after the auction ends.
I might get some inspiration from this Solidity tutorial:
https://medium.com/@bryn.bellomy/solidity-tutorial-building-a-simple-auction-contract-fcc918b0878a

Note on `key_hash` vs `address`: `key_hash` represents user account that do not contain code, while `address` is for both user accounts and contracts. Transfers to `key_hash` never execute any code and cannot run out of gas, but storing `key_hash` makes contracts less general, because this disallows contract addresses. 
Read more [here](https://tezos.stackexchange.com/questions/2311/what-are-the-differences-between-key-key-hash-address-contract-and-signature).

Implement the Namecoin contract
-------------------------------

The Namecoin contract is a name registration service:

* allows to register names that are not yet taken (users have to pay a registration fee);
* the contract stores names mapped to owners and some (arbitrary) data; you may choose something like `type name_entry = {owner : address; data : string}`;
* owners can update their entries (users have to pay an update fee);
* the entries can be queried by name.

You might get some inspiration from the Solidity implementation of the Namespace contract (see [NamecoinSolidity](NamecoinSolidity.pdf) - an example by Joseph Bonneau. The promise and peril of smart contracts.)

Concordium's Smart Contracts in Rust
====================================

For those of you, who decided to try Rust.

* install [development tools](https://developer.concordium.software/en/mainnet/smart-contracts/guides/setup-tools.html)
* use your favorite IDE with Rust support
* read an introduction to smart contracts in Rust [here](https://developer.concordium.software/en/mainnet/smart-contracts/general/develop-contracts.html)
* read and run the piggy bank tutorial [here](https://developer.concordium.software/en/testnet/smart-contracts/tutorials/piggy-bank/index.html#piggy-bank), source code [here](https://github.com/Concordium/concordium-rust-smart-contracts/tree/main/examples/piggy-bank)
* explore more examples [here](https://github.com/Concordium/concordium-rust-smart-contracts/tree/main/examples)
* start hacking!
