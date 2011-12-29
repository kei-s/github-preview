require_relative '../spec_helper.rb'

describe Preview, :js => true do
  it "shows all elements" do
    visit('/')
    page.should have_content(:text)
    page.should have_content(:preview)
  end

  it "shows markdown preview" do
    visit('/')
    fill_in('text', :with => '- hi')
    find('#preview ul li').text.should == "hi"
  end

  context "with submitted text" do
    before do
      visit('/?text=%23XXX')
    end

    it "shows submitted text" do
      find('#text').text.should == "#XXX"
    end

    it "parses submitted text" do
      find('#preview h1').text.should == "XXX"
    end
  end
end
