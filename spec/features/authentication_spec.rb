require 'rails_helper'

describe  'authentication' do
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

  context 'with existing realms' do
    let!(:realm) { create(:realm) }

    it 'does not sign user in if not valid' do
      password = 'Test1234'
      user = create(:user, password: 'Hallo Welt')
      visit new_user_session_path

      within('form#new_user') do
        fill_in 'user_email',    with: user.email
        fill_in 'user_password', with: password
      end
      click_button 'Anmelden'

      expect(page).to have_content 'E-Mail-Adresse oder Passwort ungültig.'
    end

    it 'signs user in if valid' do
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
end