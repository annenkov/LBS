Alphanet
========

To be able to deploy and call your contracts you need to get a an account with some tez on it.

* go to here: https://faucet.tzalpha.net/
* check "I'm not a robot";
* press the "Get alphanet tz" button and save a JSON file;
* got to the "Settings" in try-liquidity (http://www.liquidity-lang.org/edit/);
* select "Alphanet (tzscan)" in the "Tezos Node" area;
* click "Browse" around the "Tezos account" area and select the JSON file saved on the previous steps;
* after selecting the file the "Activate wallet" button should become active - press it. Activation takes some time (couple of minutes or so).

Deploying and calling contracts
==============================

After activating the wallet one can deploy contracts (the "Deploy" tab) and call them using the address given on deployment (the "Call" tab).
The state of the contract (local storage) can be inspected on the "Examine" tab. Note it takes some time for a deployment/call to be included in a block.
