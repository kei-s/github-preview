require_relative '../spec_helper.rb'

describe Preview, js: true do
  it 'shows all elements' do
    visit('/')
    expect(page).to have_selector('#text')
    expect(page).to have_selector('#preview')
  end

  it 'shows markdown preview' do
    visit('/')
    fill_in('text', with: '- hi')
    expect(find('#preview ul li').text).to eq('hi')
    leave
  end

  context 'with submitted text' do
    it 'shows submitted text' do
      visit('/?text=%23XXX')
      expect(find('#text').text).to eq('#XXX')
    end

    it 'parses submitted text' do
      visit('/?text=%23XXX')
      expect(find('#preview h1').text).to eq('XXX')
    end

    it 'parses submitted text in submitted format' do
      visit('/?text=h1.%20XXX&format=textile')
      expect(find('#preview h1').text).to eq('XXX')
    end
  end

  context 'escape' do
    it 'should not show unexpected tag' do
      visit("/?text=#{URI.escape('</textarea></td><h1>hogehoge</h1>')}")
      expect(page).not_to have_selector(:xpath, '//body/h1[text()="hogehoge"]')
      expect(find('#preview h1').text).to eq('hogehoge')
    end
  end

  describe 'formats' do
    shared_examples_for 'be well formated' do |format, text|
      it 'should render specified format' do
        visit('/')
        select(format, from: 'format')
        fill_in('text', with: text)
        expect(find('#preview ul li').text).to eq('hi')
        leave
      end
    end

    context 'markdown' do
      it_behaves_like 'be well formated', 'markdown',  '- hi'
    end

    context 'textile' do
      it_behaves_like 'be well formated', 'textile',   '* hi'
    end

    context 'rdoc' do
      it_behaves_like 'be well formated', 'rdoc',      '- hi'
    end

    context 'org' do
      it_behaves_like 'be well formated', 'org',       '- hi'
    end

    context 'creole' do
      it_behaves_like 'be well formated', 'creole',    '* hi'
    end

    context 'mediawiki' do
      it_behaves_like 'be well formated', 'mediawiki', '* hi'
    end
  end

  context 'confirmation after editing' do
    before do
      visit('/')
      fill_in('text', with: '- hi')
    end

    it 'should show when leaving' do
      leave
      expect(page.driver.browser.modal_message).not_to be_nil
      correct_leaving_destination?
    end

    it 'should not show when leaving just after copy text with clippy' do
      click_clippy
      leave
      correct_leaving_destination?
    end
  end

  private
  def leave
    visit('/help/markdown') # use as destination for other page
  end

  def correct_leaving_destination?
    expect(page).to have_selector('h1')
  end

  def click_clippy
    page.execute_script('window.getText();')
  end

end
