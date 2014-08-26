require 'rails_helper'

RSpec.describe  'authentication' do
  it 'returns 503 if no Realm is created' do
    password = 'Test1234'
    user = create(:user, password: password)
    visit new_user_session_path

    within('form#new_user') do
      fill_in 'user_email',    with: user.email
      fill_in 'user_password', with: password
    end
    click_button 'Anmelden'

    expect(page.status_code).to eq 503
  end

  it 'signs user in if registered' do
    create(:realm)

    password = 'Test1234'
    user = create(:user, password: password)
    visit new_user_session_path

    within('form#new_user') do
      fill_in 'user_email',    with: user.email
      fill_in 'user_password', with: password
    end
    click_button 'Anmelden'

    expect(page).to have_content 'Abmelden'
  end
end