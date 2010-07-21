User.blueprint do
  full_name { Faker::Internet.user_name }
  login { Faker::Internet.user_name }
  password {'testing'}
  password_confirmation { password }
  email { Faker::Internet.email }
  activation_code { nil }
  activated_at { 5.days.ago }
  state { 'active' }
end