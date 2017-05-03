describe Link do
  DatabaseCleaner.clean
  link = Link.create(title: 'Test', url: 'www.test.com')

  it 'has a title' do
    expect(link.title).to eq 'Test'
  end
  it 'has a url' do
    expect(link.url).to be_a Addressable::URI
  end
end
