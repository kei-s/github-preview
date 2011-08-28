require_relative '../spec_helper.rb'
require_relative '../../app.rb'

Capybara.app = Preview

describe Preview, :js => true do
  it do
    visit('/')
    page.should have_selector('#text')
  end

  it do
    visit('/')
    fill_in('text', :with => '- hi')
    find('#preview').text.should == "<ul><li>hi</li></ul>"
  end
end
