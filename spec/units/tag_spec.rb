describe Tag do

  tag = Tag.create(name: 'Test')

  it 'has a title' do
    expect(tag.name).to eq 'Test'
  end

end
