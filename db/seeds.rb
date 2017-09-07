User.create(
  first_name: "Alex",
  last_name: "Ant",
  email: "alex.ant@email.com",
  password: "password",
  password_confirmation: "password"
)

User.create(
  first_name: "Barry",
  last_name: "Buffalo",
  email: "barry.buffalo@email.com",
  password: "password",
  password_confirmation: "password"
)

Mx::Utilities.import_banks
