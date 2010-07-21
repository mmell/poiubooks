# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_poiubooks_session',
  :secret      => '9e3bf5eda0027ff86f9f15f10156ad8d7c839544af1ed64ee8e830cd41a268faa604c03ef251b47746da490b0bf3413ad8551bdf77db4a21737095cccfd77daa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
