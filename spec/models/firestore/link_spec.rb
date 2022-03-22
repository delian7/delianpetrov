require 'rails_helper'

RSpec.describe Firestore::Link, type: :model do
  subject { described_class.new(name: 'example', url: 'example.com') }

  context 'validations' do
    it 'does not save when there is no name present' do
      subject.name = nil
      expect(subject.save).to be_falsey
    end

    it 'does not save when there is no url present' do
      subject.url = nil

      expect(subject.save).to be_falsey
    end
  end

  describe '#all' do
    before do
      allow(Firestore::Client).to receive(:call).and_return(double('firestore::base'))
    end

    it 'returns an array of Firestore::Links', :vcr do
      links = described_class.all
      expect(links).to be_an(Array)
      expect(links.first).to be_a(Firestore::Link)
    end
  end

  describe '#find_by_name' do
    context 'when there is a match' do
      it 'returns the link' do
        link = described_class.find_by_name('aspiration')

        expect(link).to be_a(described_class)
        expect(link.name).to eq('aspiration')
      end
    end

    context 'when there is no match' do
      it 'returns nil' do
        link = described_class.find_by_name('not-found')

        expect(link).to be_nil
      end
    end
  end
end
