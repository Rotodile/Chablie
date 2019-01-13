User.create!(name:  "Chablie Example",
    email: "example@chablie.com",
    password:              "123456",
    password_confirmation: "123456",
    username: "ExampleOfChablie",
    admin:     true,
    activated: true,
    activated_at: Time.zone.now)
