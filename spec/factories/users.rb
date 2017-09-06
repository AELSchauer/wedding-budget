FactoryGirl.define do
  factory :user do
    first_name "Terry"
    last_name "Turtle"
    sequence :email { |n| "Terry.Turtle#{n}@email.com" }
    password "password"
    password_confirmation "password"
  end
end
