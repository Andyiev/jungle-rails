require 'rails_helper'

RSpec.feature "Visitor navigates from the home page to a product detail page", type: :feature, js: true do
# SETUP
before :each do
  @category = Category.create! name: 'Apparel'

  10.times do |n|
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    
  end
end
  scenario "They see a product detail page" do
    # ACT
    visit root_path
    # look in the article class="product" the word "Details » ("Details &raquo"), and click on it
    click_link('Details »', match: :first)
    # DEBUG / VERIFY
    #save_screenshot
    expect(page).to have_css '.product-detail'
    save_screenshot
  end

end