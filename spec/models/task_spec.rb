require 'rails_helper'

describe Task do
  context 'validations' do

    context 'with title' do
      subject { build(:task) }
      it { is_expected.to be_valid }
    end

    context 'without title' do
      subject { build(:task, title: '') }
      it { is_expected.not_to be_valid }
    end

  end
end

