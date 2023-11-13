# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment do
  subject(:comment) { build(:comment) }

  it { is_expected.to validate_presence_of(:body) }

  it do
    expect(comment).to belong_to(:movie)
  end

  it do
    expect(comment).to belong_to(:user)
  end
end
