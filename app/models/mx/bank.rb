class Mx::Bank < Mx::Base
  attr_reader :bank
  def initialize(bank)
    @bank = bank
  end

  def metadata
    query(
      :endpoint => "/institutions/#{bank.mx_id}",
      :method   => :GET
    )
  end

  def credentials
    query(
      :endpoint => "/institutions/#{bank.mx_id}/credentials",
      :method   => :GET
    )
  end
end
