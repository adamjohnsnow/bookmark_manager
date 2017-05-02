# As a user
# So that I can find my favourite URL's faster
# I want to be able to see a list of my favourite URLs

# As a user
# So that I can add new URL's to my favourites
# I want to be able to add a new URL to my favourites

# As a user
# So that I can see what type of URL's it is
# I want to be able to tag the URL with a label

# As a user
# So that I can find similar URL's faster
# I want to be able to filter my favourites by their tags

feature 'Testing links' do
    DatabaseCleaner.clean
  scenario 'can click on link' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ol#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end

feature 'adding links' do
  scenario 'can add a link' do
    visit '/new'
    fill_in('title', with: 'YouTube')
    fill_in('url', with: 'http://www.youtube.com')
    click_button('save')
    within 'ol#links' do
      expect(page).to have_content('YouTube')
    end
  end
end
