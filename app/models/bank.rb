class Bank < ApplicationRecord
  def mx
    @mx = Mx::Bank.new(self)
  end

  def credentials
    response = mx.credentials
    response.credentials.map do |data|
      Credential.new(
        field_name: data.field_name,
        field_label: data.label,
        field_type: data.type.downcase,
        mx_id: data.guid
      )
    end
  end

  def self.fuzzy_search_by_name(search_name)
    where("lower(name) like ?", "%#{search_name.downcase}%").order(:name)
  end
end
