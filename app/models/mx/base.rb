class Mx::Base
  include HTTParty

  def credentials
    {
      :"MX-API-Key" => Mx::Config.mx_api_key,
      :"MX-Client-ID" => Mx::Config.mx_client_id,
      :"Accept" => "application/vnd.mx.atrium.v1+json"
    }
  end

  def query(opts)
    method   = opts[:method].to_s.downcase
    response = self.class.send(method, opts[:endpoint], headers: credentials, query: opts[:params])
    data = JSON.parse(response)

    Hashie::Mash.new(data)
  end
end