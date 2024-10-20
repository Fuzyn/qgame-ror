require 'rails_helper'

RSpec.describe Alliance, type: :model do
  subject { build(:alliance) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:short) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_uniqueness_of(:short).case_insensitive }
  it { should validate_length_of(:short).is_at_most(6) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a short name' do
    subject.short = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid if short name is longer than 6 characters' do
    subject.short = 'TOO_LONG'
    expect(subject).not_to be_valid
  end
end
