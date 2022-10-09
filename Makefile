export API-KEY = YOUR-KEY

debug:
	crystal src/opensea.cr

build-static:
	@shards build --static --no-debug --release --production -v

build-release:
	@shards build --no-debug --release --production -v

run: build-release
	@bin/opensea