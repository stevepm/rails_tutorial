require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'returns the origin title' do
    expect(full_title).to eq("Ruby on Rails Tutorial Sample App")
  end

  it 'returns the original title with the new title passed in' do
    expect(full_title("Help")).to eq("Help | Ruby on Rails Tutorial Sample App")
  end
end