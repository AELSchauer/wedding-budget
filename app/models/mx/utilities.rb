class Mx::Utilities
  def self.import_banks
    mx = Mx::Base.new
    response = mx.query(
      :endpoint => "/institutions",
      :method   => :GET
    )

    response.institutions.each do |institution|
      Bank.create(
        name: institution["name"],
        url: institution["url"],
        medium_logo_url: institution["medium_logo_url"],
        small_logo_url: institution["small_logo_url"],
        mx_id: institution["code"]
      )
    end
  end
end
