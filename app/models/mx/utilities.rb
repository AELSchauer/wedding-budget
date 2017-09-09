class Mx::Utilities
  def self.import_banks
    mx = Mx::Base.new
    response = mx.query(
      :endpoint => "/institutions",
      :method   => :GET
    )

    response.institutions.each do |institution|
      ::Bank.create(
        name: institution["name"],
        url: institution["url"],
        medium_logo_url: institution["medium_logo_url"],
        small_logo_url: institution["small_logo_url"],
        mx_id: institution["code"]
      )
    end
  end

  def self.reset_users
    response = user_list
    total_entries = response.pagination.total_entries
    while total_entries > 0
      response.users.each do |user|
        delete_user(user.guid)
      end
      response = user_list
      total_entries = response.pagination.total_entries
    end
  end

  def self.user_list
    mx = Mx::Base.new
    mx.query(
      :endpoint => "/users",
      :method   => :GET
    )
  end

  def self.delete_user(user_mx_id)
    mx = Mx::Base.new
    mx.query(
      :endpoint => "/users/#{user_mx_id}",
      :method   => :DELETE
    )
  end
end
