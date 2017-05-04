feature 'accounts' do

  scenario 'register user' do
    DatabaseCleaner.clean
    sign_up
    expect(page).to have_content('Welcome Testy')
  end

  scenario 'user count increased' do
    users = User.all
    expect(users.count).to eq 1
  end

  scenario 'sign in' do
    sign_in
    expect(page).to have_content('Welcome Testy')
  end
end

feature 'Testing links' do

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
