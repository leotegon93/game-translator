require 'spec_helper'

describe GameTranslator::Stat do
  let(:user) { create(:game_translator_user, role: 'translator') }
  let(:user2) { create(:game_translator_user, role: 'translator') }

  before do
    10.times { create(:game_translator_game, status: 'translated') }

    10.times { create(:game_translator_game, status: 'not_translated') }

    10.times { create(:game_translator_game_translation, revised: true, user: user) }

    5.times { create(:game_translator_game_translation, revised: false, user: user2) }
  end

  describe '.total' do
    it 'has a method for count games' do
      GameTranslator::Stat.should respond_to :total
    end

    it 'returns total of games' do
      GameTranslator::Stat.total.should == GameTranslator::Game.count
    end
  end

  describe '.translated' do
    it 'has a method for count translated games' do
      GameTranslator::Stat.should respond_to :translated
    end

    it 'returns total of translated games' do
      GameTranslator::Stat.translated.should == 10
    end
  end

  describe '.revised' do
    it 'has a method for count revised translations' do
      GameTranslator::Stat.should respond_to :revised
    end

    it 'returns total of revised translations' do
      GameTranslator::Stat.revised.should == 10
    end
  end

  describe '.percentage' do
    it 'has a method for get percentage of translated games' do
      GameTranslator::Stat.should respond_to :percentage
    end

    it 'returns percentage of translated games' do
      total = GameTranslator::Game.count
      translated = GameTranslator::Game.translated.count
      percentage = (100 * translated/total.to_f).round
      GameTranslator::Stat.percentage.should == percentage
    end
  end

  describe '.greatest_translator' do
    it 'has a method for get the greatest translator' do
      GameTranslator::Stat.should respond_to :greatest_translator
    end

    it 'returns the user with more translations' do
      GameTranslator::Stat.greatest_translator.should == user
    end
  end

  describe '.count_translations' do
    it 'has a method for count user translations' do
      GameTranslator::Stat.should respond_to :count_translations
    end

    it 'returns total of user translations' do
      GameTranslator::Stat.count_translations(user2).should == 5
    end
  end
end
