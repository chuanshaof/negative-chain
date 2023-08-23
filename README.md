# Negative Chain
This L3 chain is an blockchain deployed on [Arbitrum Orbit Chain](https://docs.arbitrum.io/launch-orbit-chain/orbit-gentle-introduction).

At the point of this writing, this chain runs locally due to the infancy of the platform. 

This is a project intended for the purpose the bounty for Arbitrum, under Encode Club's Future of Blockchain University Hackathon.

## Introduction
The goal of the blockchain is simulate a private decentralized insurance. 

### How it works
Negative Chain works similarly to an escrow. 

Users are allowed to deposit currencies in exchange for $NEG which buys them a stake in Negative Chain, and offers them a chance to be able to make claims for insurance purposes if should something arise.

Withdrawal of funds will not be allowed as similar to how an insurance works.

### Voting
User voting rights are determined by their amount of stake in the system. A user with more stake will have more voting rights to determine the outcome of the vote.

A time block of 7 days is set for all users to vote if there should be a payout.

### Automated Payouts
Upon expiration of the ballot, the smart contract will automatically activate to pay out a certain amount to the user.

### To be worked on
1. How does this fund not go to red? Need further planning
2. Problems with alturism, people may keep voting no
3. Problems with majority shareholders
4. This chain have not been tested, please do not use it for commercial purposes




# orbit-setup-script

These scripts will help you fund newly generated batch-poster and validator addresses, configure an Orbit chain, and deploy bridge contracts on both L2 and L3 chains.

## Instructions

Once you’ve downloaded both config files from the [Orbit Deployment UI](https://orbit.arbitrum.io/), please follow the steps below to complete local deployment of your Orbit chain. For more details and step-by-step instructions, check out the [documentation](https://developer.arbitrum.io/launch-orbit-chain/orbit-quickstart).

1. Clone the https://github.com/OffchainLabs/orbit-setup-script repository, and run `yarn install`. Then, move the both the `nodeConfig.json` and `orbitSetupScriptConfig.json` files into the `config` directory within the cloned repository
2. Launch Docker, and in the base directory, run `docker-compose up -d`. This will launch the node with a Public RPC reachable at http://localhost:8449/  and a corresponding BlockScout explorer instance, viewable at http://localhost:4000/
3. Then, add the private key for the wallet you used to deploy the rollup contracts earlier in the following command, and run it: `PRIVATE_KEY="0xYourPrivateKey" L2_RPC_URL="<https://goerli-rollup.arbitrum.io/rpc>" L3_RPC_URL="<[http://localhost:8449](http://localhost:8449/)>" yarn run setup`
4. The Orbit chain is now setup. You can find all information about the newly deployed chain in the `outputInfo.json` file which is created on the main directory of script folder.
5. Optionally, to track logs, run the following command within the base directory: `docker-compose logs -f nitro`
