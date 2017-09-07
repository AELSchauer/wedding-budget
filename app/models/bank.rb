class Bank < ApplicationRecord
  has_many :credentials
  after_create :define_login_credentials

  def mx
    @mx = Mx::Bank.new(self)
  end

  def define_login_credentials
    response = mx.credentials
    response.credentials.each do |data|
      self.credentials.create(
        field_name: data.field_name,
        field_label: data.label,
        field_type: data.type,
        mx_id: data.guid
      )
    end
  end
end
