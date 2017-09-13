class Credential < OpenStruct
  def html_field_type
    if %w[login text].include?(field_type)
      "text"
    else
      field_type
    end
  end

  def captcha_image
    directory = "../../directory"
    new_file = File.new("captcha-#{member_id}.gif", 'wb')
    new_file.write(Base64.decode64(image_data))
  end
end
