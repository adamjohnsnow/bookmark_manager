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
  scenario 'has links' do
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
    fill_in('tag', with: 'video')
    click_button('Save')
    within 'ol#links' do
      expect(page).to have_content('YouTube')
    end
  end
end

  feature 'Adding tags' do
    scenario 'I can add a single tag to a new link' do
      DatabaseCleaner.clean
      visit '/new'
      fill_in 'url',   with: 'http://www.makersacademy.com/'
      fill_in 'title', with: 'Makers Academy'
      fill_in 'tag',  with: 'education'
      click_button 'Save'
      link = Link.first
      expect(link.tags.map(&:name)).to include('education')
    end

    scenario 'filter for bubbles' do
      visit '/new'
      fill_in 'url',   with: 'http://www.bubbles.com/'
      fill_in 'title', with: 'Bubbles'
      fill_in 'tag',  with: 'bubbles'
      click_button 'Save'
      visit '/tags/bubbles'
      expect(page).to have_content 'www.bubbles.com'
    end

    scenario 'multiple tags' do
      visit '/new'
      fill_in 'url',   with: 'http://www.multiple.com'
      fill_in 'title', with: 'Multitag'
      fill_in 'tag',  with: 'multi, test, flobzy, pepsi man'
      click_button 'Save'
      expect(page).to have_content 'http://www.multiple.com Tags: multi | test'
    end
end
