module GameTranslator
  class Review < ActiveRecord::Base
    # relationship
    belongs_to :user
    has_many :games
    has_many :game_translations, through: :game

    # validates
    validates :status, presence: true, inclusion: { in: %w(pending accepted rejected) }

    def self.to_review
      GameTranslator::User.translators.map do |user|
        if user.game_translations.not_revised.count >= 100
          review = GameTranslator::Review.create(user: user, status: 'pending')
          user.game_translations.not_revised.first(100).map { |t| t.update_attribute(:review, review) }
        end
      end
    end
  end
end