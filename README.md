# The [evmgolf](https://github.com/evmgolf/evmgolf) Command Line Interface 

## Install

### Prereqs

- [curl](https://curl.se/download.html)
- [jq](https://stedolan.github.io/jq/download/)
- [foundry](https://github.com/foundry-rs/foundry#installation)
- [ethabi](https://github.com/rust-ethereum/ethabi#installation)

### Install

curl https://raw.githubusercontent.com/evmgolf/evmgolf-cli/master/install.sh | bash

## Guide 

### (Testers) Node

Requirements: evmgolf

Start a local node in a separate shell, noting the address and private key outputted for the next step:

`anvil`

### Setup

Create the initial config:

`evmgolf`

Copy chain configuration to the appropriate dir (eg. `~/.evmgolf/31337/evmgolfrc`):

```bash
#!/usr/bin/env bash
export ETH_PK="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
export ETH_FROM="0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"
export ETH_RPC_URL="http://localhost:8545"
export AUTH="--private-key ${ETH_PK}"
```

### (Admins/Testers) Deploy

Clone the base repository: 

`git clone --recurse-submodules https://github.com/evmgolf/evmgolf`


Initialize the base contracts:

`cd evmgolf`

`evmgolf challenges init`

`evmgolf programs init`

`evmgolf trophies init`

### (Users) Fetch 

Download the base contract addresses:

`evmgolf dl https://raw.githubusercontent.com/evmgolf/evmgolf-data/master`


### Create a challenge 

Deploy the challenge contract:

`evmgolf challenge create TrueChallenge`

```json
{
  "deployedTo": "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512",
  "deployer": "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266",
  "transactionHash": "0x10b2268f887e2cba8b16b189da00761521ea970161385f3c646f645b91f59506"
}
```

Request the challenge to be added, adding a description as the second arg:

`evmgolf challenge request $CHALLENGE 'Create a program that returns true.'`

View the current state of the challenge:

`evmgolf challenge view $CHALLENGE`

```json 
{
  "name": "Challenge 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512",
  "description": "Create a program that returns true.",
  "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0ODAgMTIwIj48dGV4dCB4PSIyMCIgeT0iMjAiPkNoYWxsZW5nZTwvdGV4dD48dGV4dCB4PSIyMCIgeT0iNDAiPkFkZHJlc3M6IDB4ZTdmMTcyNWU3NzM0Y2UyODhmODM2N2UxYmIxNDNlOTBiYjNmMDUxMjwvdGV4dD48dGV4dCB4PSIyMCIgeT0iNjAiPkRlc2NyaXB0aW9uOiBDcmVhdGUgYSBwcm9ncmFtIHRoYXQgcmV0dXJucyBgdHJ1ZWAuPC90ZXh0Pjx0ZXh0IHg9IjIwIiB5PSI4MCI+U3RhdHVzOiBQZW5kaW5nPC90ZXh0Pjwvc3ZnPg==",
  "attributes": [
    {
      "trait_type": "Status",
      "value": "Pending"
    }
  ]
}
```

### (Reviewers/Testers) Review a challenge

Approve the challenge: 

`evmgolf challenge approve $CHALLENGE '✅'`

Or reject the challenge:

`evmgolf challenge reject $CHALLENGE '❌ challenge contains an exploit'`


### Create a Program 

Build the program:

`forge build`

Write the creationCode to Programs noting the created address (last item in topics):

`evmgolf program write out/Program.sol/Program.json`

### Submit a Program 

Submit a solution to the challenge, noting the trophy id (last item in the Transfer topic):

`evmgolf trophy submit $CHALLENGE $PROGRAM`

### View a Trophy

`evmgolf trophy view 0`

```json 
{
  "name": "Trophies #0",
  "description": "Trophies #0",
  "image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0ODAgMTQwIj48dGV4dCB4PSIyMCIgeT0iMjAiPlRyb3BoaWVzICMwPC90ZXh0Pjx0ZXh0IHg9IjIwIiB5PSI0MCI+Q2hhbGxlbmdlOiAweGNmN2VkM2FjY2E1YTQ2N2U5ZTcwNGM3MDNlOGQ4N2Y2MzRmYjBmYzk8L3RleHQ+PHRleHQgeD0iMjAiIHk9IjYwIj5Qcm9ncmFtOiAgIDB4MzdiMGEwZTNlZWI2ZjI1ZjY3ZWVkMDY0OWFjZjVhM2QxMWY3Y2I3ZjwvdGV4dD48dGV4dCB4PSIyMCIgeT0iODAiPlNpemU6IDE4OCDirZA8L3RleHQ+PHRleHQgeD0iMjAiIHk9IjEwMCI+R2FzOiAyMTUxOCDirZA8L3RleHQ+PC9zdmc+",
  "attributes": [
    {
      "trait_type": "Challenge",
      "value": "0xcf7ed3acca5a467e9e704c703e8d87f634fb0fc9"
    },
    {
      "trait_type": "Program",
      "value": "0x37b0a0e3eeb6f25f67eed0649acf5a3d11f7cb7f"
    },
    {
      "trait_type": "Gas",
      "value": 21518
    },
    {
      "trait_type": "Gas Record",
      "value": true
    },
    {
      "trait_type": "Size",
      "value": 188
    },
    {
      "trait_type": "Size Record",
      "value": true
    }
  ]
}
```
