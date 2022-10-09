# Opensea

Simple API service which uses

- HTTP client
- Memory cache

to fetch NFT tokenby contract address and token ID to get information about NFT token

## Installation

- Crystal
- Shards

## Usage

```bash
shards build --static --no-debug --release --production -v
```

## Development

```bash
crystal src/opensea.cr
```


### Benchmarking

I've measured performance of the current implementation against  
https://github.com/Dmdv/opensea-netcore

And `.NETCORE` showed results almost as twice faster compared to `Crystal`

<img width="1248" alt="image" src="https://user-images.githubusercontent.com/805238/194770454-eac0aa3f-a08d-460a-80e2-fbf74c697a66.png">
