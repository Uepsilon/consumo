require 'rails_helper'

describe 'order item' do
  let(:user) { create :user }
  let!(:delivery) { create :delivery }

  before(:each) { login_as user }

  it 'checks if product is available' do
    visit root_path
    expect(page).to have_content 'Test Product'
    expect(page).to have_content "Bestand: #{delivery.quantity}"
  end

  it 'orders a product' do
    visit root_path

    within('#new_order_item') do
      click_button 'Test Product'
    end

    expect(page).to have_content "Bestand: #{delivery.quantity-1}"
    expect(page).to have_content "Consumo sagt, #{delivery.product.name} gebucht. Hai!"
  end

  # it 'returns 503 if no Realm is created' do
  #   password = 'Test1234'
  #   user = create(:user, password: password)
  #   visit new_user_session_path

  #   within('form#new_user') do
  #     fill_in 'user_email',    with: user.email
  #     fill_in 'user_password', with: password
  #   end
  #   click_button 'Anmelden'

  #   expect(page.status_code).to eq 503
  # end

  # context 'with existing realms' do
  #   before(:each) { create(:realm) }

  #   it 'does not sign user in if not valid' do
  #     password = 'Test1234'
  #     user = create(:user, password: 'Hallo Welt')
  #     visit new_user_session_path

  #     within('form#new_user') do
  #       fill_in 'user_email',    with: user.email
  #       fill_in 'user_password', with: password
  #     end
  #     click_button 'Anmelden'

  #     expect(page).to have_content 'E-Mail-Adresse oder Passwort ungültig.'
  #   end

  #   it 'signs user in if valid' do
  #     password = 'Test1234'
  #     user = create(:user, password: password)
  #     visit new_user_session_path

  #     within('form#new_user') do
  #       fill_in 'user_email',    with: user.email
  #       fill_in 'user_password', with: password
  #     end
  #     click_button 'Anmelden'

  #     expect(page).to have_content 'Abmelden'
  #   end
  # end
end