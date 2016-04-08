require 'rails_helper'

feature "routes acceptance spec" do
  scenario "user visits root path" do
    visit root_path
    expect(page.status_code).to eql(200)
  end
end
