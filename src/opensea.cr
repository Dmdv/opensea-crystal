require "kemal"
require "json"
require "http/client"
require "cache"

cache = Cache::MemoryStore(String, String).new(expires_in: 10.minute)

uri = URI.parse("https://api.opensea.io/api/v1/asset")
headers = HTTP::Headers{"X-API-KEY" => "YOUR-CODE-HERE"}
opensea_client = HTTP::Client.new(uri)
start_time = Time.utc

# You can easily access the context and set content_type like 'application/json'.
# Look how easy to build a JSON serving API.
get "/" do |env|
  env.response.content_type = "application/json"
  Log.info {"General info"}
  {start_time: start_time}.to_json
end

get "/token/:contract_address/:token_id" do |env|
  env.response.content_type = "application/json"

  address = env.params.url["contract_address"]
  token_id = env.params.url["token_id"]

  Log.info {"contract_address " + address}
  Log.info {"token_id " + token_id}

  if !cache.read(address + token_id)
    Log.info { "Missing in cache, fetching from Opensea" }
    response = opensea_client.get("#{uri}/#{address}/#{token_id}/", headers)
    Log.info { response.status_code }
    cache.write(address + token_id, response.body)
  end

  cache.read(address + token_id)

end

Kemal.run
