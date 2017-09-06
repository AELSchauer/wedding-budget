RSpec.configure do
  Shoulda::Matchers.configure do |sconfig|
    sconfig.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
