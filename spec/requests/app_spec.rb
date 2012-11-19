require_relative '../spec_helper.rb'

describe Preview, :js => true do
  it "shows all elements" do
    visit('/')
    page.should have_selector('#text')
    page.should have_selector('#preview')
  end

  it "shows markdown preview" do
    visit('/')
    fill_in('text', :with => '- hi')
    find('#preview ul li').text.should == "hi"
  end

  context "with submitted text" do
    it "shows submitted text" do
      visit('/?text=%23XXX')
      find('#text').text.should == "#XXX"
    end

    it "parses submitted text" do
      visit('/?text=%23XXX')
      find('#preview h1').text.should == "XXX"
    end

    it "parses submitted text in submitted format" do
      visit('/?text=h1.%20XXX&format=textile')
      find('#preview h1').text.should == "XXX"
    end
  end

  context "escape" do
    it "should not show unexpected tag" do
      visit('/?text=</textarea></td><h1>hogehoge</h1>')
      page.should_not have_selector(:xpath, '//body/h1[text()="hogehoge"]')
      find('#preview h1').text.should == "hogehoge"
    end
  end

  describe "formats" do
    shared_examples_for 'be well formated' do |format, text|
      it "should render specified format" do
        visit('/')
        select(format, :from => 'format')
        fill_in('text', :with => text)
        find('#preview ul li').text.should == "hi"
      end
    end

    context "markdown" do
      it_behaves_like 'be well formated', "markdown",  "- hi"
    end

    context "textile" do
      it_behaves_like 'be well formated', "textile",   "* hi"
    end

    context "rdoc" do
      it_behaves_like 'be well formated', "rdoc",      "- hi"
    end

    context "org" do
      it_behaves_like 'be well formated', "org",       "- hi"
    end

    context "creole" do
      it_behaves_like 'be well formated', "creole",    "* hi"
    end

    context "mediawiki" do
      it_behaves_like 'be well formated', "mediawiki", "* hi"
    end
  end
end
