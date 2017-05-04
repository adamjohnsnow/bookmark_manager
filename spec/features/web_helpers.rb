def sign_up
  visit '/'
  click_button('Sign Up')
  fill_in('email', with: 'test@test.com')
  fill_in('first_name', with: 'Testy')
  fill_in('surname', with: 'McTestyface')
  fill_in('password', with: 'password')
  fill_in('verify_password', with: 'password')
  click_button('Sign Up')
end

def sign_in
  visit '/'
  fill_in('email', with: 'test@test.com')
  fill_in('password', with: 'password')
  click_button('Sign In')
end
