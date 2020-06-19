require 'rails_helper'

describe Tag do
  context 'validations' do

    context 'with title' do
      subject { build(:tag) }
      it { is_expected.to be_valid }
    end

    context 'without title' do
      subject { build(:tag, title: '') }
      it { is_expected.not_to be_valid }
    end

  end

  it 'creates a code out of the title' do
    expect(create(:tag, title: 'New Tag').code).to eq('new_tag')
  end
end

