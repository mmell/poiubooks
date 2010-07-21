Factory.sequence :full_name do |n|
  "Name #{n}"
end

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.sequence :email do |n|
  "example#{n.to_s.rjust(4, '0')}@example.com"
end

Factory.define :user do |f|
  f.full_name { Factory.next(:full_name) }
  f.login { Factory.next(:login) }
  f.password { 'password' }
  f.password_confirmation { 'password' }
  f.email { Factory.next(:email) }
  f.is_admin false
end
