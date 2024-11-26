# require "sinatra"
require "dotenv/load"
require "net/http"
require "json"

CLIENT_ID = ENV.fetch("CLIENT_ID")
CLIENT_SECRET = ENV.fetch("CLIENT_SECRET")

def parse_response(response)
  case response
  when Net::HTTPOK
    JSON.parse(response.body)
  else
    puts response
    puts response.body
    {}
  end
end

def exchange_code(code)
  params = {
    "client_id" => CLIENT_ID,
    "client_secret" => CLIENT_SECRET,
    "code" => code
  }
  result = Net::HTTP.post(
    URI("https://github.com/login/oauth/access_token"),
    URI.encode_www_form(params),
    {"Accept" => "application/json"}
  )

  response = parse_response(result)
  token = response["access_token"]

  # Stockez le token dans l'utilisateur
  user_info = user_info(token)
  user = User.find_or_create_by(github_id: user_info["id"])
  user.update(github_token: token)

  response
end

def user_info(token)
  uri = URI("https://api.github.com/user")

  result = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
    headers = {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{token}"
    }

    http.get(uri.path, headers)
  end

  parse_response(result)
end

get "/" do
  link = '<a href="https://github.com/login/oauth/authorize?client_id=<%= CLIENT_ID %>">Login with GitHub</a>'
  erb link
end

get "CALLBACK_URL" do
  code = params["code"]

  token_data = exchange_code(code)

  if token_data.key?("access_token")
    token = token_data["access_token"]

    user_info = user_info(token)
    handle = user_info["login"]
    name = user_info["name"]

    render = "Successfully authorized! Welcome, #{name} (#{handle})."
    erb render
  else
    render = "Authorized, but unable to exchange code #{code} for token."
    erb render
  end
end
