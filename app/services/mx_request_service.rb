class MxRequestService

  def initialize
    @config = YAML.load_file("#{Rails.root}/config/mx.yml")[Rails.env]
  end

  def create_user
    request_url = "#{@config['base_url']}/users"
    params = { user: {identifier: "woohoo"} }
    header = {
      "MX-API-Key" => @config["api_key"],
      "MX-Client-ID" => @config["client_id"]
    }
    binding.pry
    # HTTParty.post(request_url, headers: header, body: params)
    HTTParty.get(request_url, headers: header)
  end

end