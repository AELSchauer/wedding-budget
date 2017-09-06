class Mx::Config
  class_attribute :base_url, :mx_client_id, :mx_api_key

  YAML.load_file("#{Rails.root}/config/mx.yml")[Rails.env].each do |key, value|
    self.send("#{key}=", value)
  end

  Mx::Base.base_uri base_url
end