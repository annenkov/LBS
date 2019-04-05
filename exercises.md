In-Class Exercises
==================

Extend the "counter" contract (*)
-----------------------------------

Add a threshold functionality to the ``counter'' contract: if the increment + current stored counter value is grater the a threshold the method invocation should fail. Make threshold a parameter to the init method

Extend the auction contract (**)
--------------------------------
Modify the auction contract (see auction.liq)

Particularly, add the following functionality:

* auction start date;
* if the current date is less then the start date, contract should throw an error;
* an auction owner (use `address` type for this field);
* auction can be canceled by the owner (if there are funds on the contract - they must be refunded);
* if the auction is canceled, contract should throw an error.

NOTE: to test if the cancel method can be called only by the owner (before deployment), you might want to use the following code snippet to determine your current account address (it is different from your real account address, which you can see at the top menu bar to the left from your balance):

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
The idea is to store map (key_hash -> amount) of bidder and corresponding amounts. That would allow to refund on request from a user after the auction ends.
I might get some inspiration from this Solidity tutorial:
https://medium.com/@bryn.bellomy/solidity-tutorial-building-a-simple-auction-contract-fcc918b0878a

Implement the Namecoin contract
-------------------------------

The Namecoin contract is a name registration service:

* allows to register names that are not yet taken (users have to pay a registration fee);
* the contract stores names mapped to owners and some (arbitrary) data; you may choose something like `type name_entry = {owner : address; data : string}`;
* owners can update their entries (users have to pay an update fee);
* the entries can be queried by name.

You might get some inspiration from the Solidity implementation of the Namespace contract (see [NamecoinSolidity](NamecoinSolidity.pdf) - an example by Joseph Bonneau. The promise and peril of smart contracts.)
