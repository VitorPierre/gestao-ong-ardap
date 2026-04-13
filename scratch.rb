user = User.find_by(email: 'admin@ardap.org')
puts "User: \#{user.email}"
puts "Digest: \#{user.password_digest}"
puts "Auth password123: \#{user.authenticate('password123').present?}"
puts "Auth wrong: \#{user.authenticate('wrong').present?}"
