# frozen_string_literal: true

require "rails_helper"

describe "home/index.html.haml" do
  it "displays welcome message" do
    render
    # Test only first character
    # because accented words not well displayed in rendered content
    expect(safe_join([raw(rendered)])).to include(I18n.t(:"home.index.title").first)
  end
end
