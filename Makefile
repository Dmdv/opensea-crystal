debug:
	crystal src/opensea.cr

build-static:
	@shards build --static --no-debug --release --production -v

build:
	@shards build --no-debug --release --production -v