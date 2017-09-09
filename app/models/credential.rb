class Credential < OpenStruct
  def html_field_type
    if %w[login text].include?(field_type)
      "text"
    elsif field_type == "password"
      "password"
    else
      puts "credential html type not recognized"
      binding.pry
    end
  end
end
