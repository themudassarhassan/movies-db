# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  subject(:movie) { build(:movie) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:release_date) }
  it { is_expected.to validate_presence_of(:overview) }
  it { is_expected.to validate_presence_of(:poster_path) }

  it do
    expect(movie).to have_many(:comments).dependent(:destroy)
  end
end
