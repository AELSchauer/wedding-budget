class Credential < ApplicationRecord
  belongs_to :bank

  def html_field_type
    if field_type == "login"
      "text"
    elsif field_type == "password"
      "password"
    else
      puts "credential html type not recognized"
      binding.pry
    end
  end
end
