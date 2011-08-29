require_relative '../spec_helper.rb'

describe Preview, :js => true do
  it do
    visit('/')
    page.should have_content(:text)
    page.should have_content(:preview)
  end

  it do
    visit('/')
    fill_in('text', :with => '- hi')
    find('#preview ul li').text.should == "hi"
  end
end
