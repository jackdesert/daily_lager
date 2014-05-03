require 'spec_helper'

describe NoteVerb do


  describe '#process' do
    let(:human) { create(:human) }

    subject { described_class.new(words, human) }

    before do
      stub(human).backfill
    end

    context 'when there are no words' do
      let(:words) { 'note' }


      it 'does not add a note' do
        subject.send(:process)
        human.notes.length.should == 0
      end

      it 'returns a message' do
        subject.send(:process).should == "Please include words in your note."
      end

    end

    context 'when there are words' do
      let(:words) { 'note the time' }


      it 'adds a Note to the human' do
        subject.send(:process)
        human.notes.length.should == 1
        human.notes.first.body.should == 'the time'
      end

      it 'returns a message' do
        subject.send(:process).should == "Noted: 'the time'"
      end

    end


    describe '#appropriate?' do
      yesses = [
        ['note', 'amazing #322^&)'],
        ['note', '34590mp3'],
      ]


      verify_appropriateness_of(yesses, described_class)
    end
  end
end
