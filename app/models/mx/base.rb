class Mx::Base
  include HTTParty

  def app_credentials
    {
      :"MX-API-Key" => Mx::Config.mx_api_key,
      :"MX-Client-ID" => Mx::Config.mx_client_id
    }
  end

  def query(opts)
    method   = opts[:method].to_s.downcase
    response = self.class.send(
      method, opts[:endpoint],
      headers: app_credentials, query: opts[:params]
    )

    data = response_handler
    log_query(opts.merge(response: data, code: response.code))
    Hashie::Mash.new(data)
  end

  def log_query(opts)
    Log.create!(
      :method        => opts[:method],
      :endpoint      => opts[:endpoint],
      :params        => opts[:params].to_json,
      :response      => opts[:response].to_json,
      :response_code => opts[:code]
    )
  end

  def response_handler
    if response.nil?
      { status: response.code, success: response.success? }
    elsif response["error"].nil?
      JSON.parse(response)
    else
      response
    end
  end
end
