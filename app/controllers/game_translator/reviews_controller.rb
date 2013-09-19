# encoding: UTF-8
class GameTranslator::ReviewsController < ApplicationController
  load_and_authorize_resource

  def index
    GameTranslator::Review.to_review
    @reviews = GameTranslator::Review.where(status: 'pending').paginate(page: params[:page])
  end

  def edit
    @review = GameTranslator::Review.find(params[:id])
    @sample = @review.translations.sample
    @game = @sample.game
  end

  def update
    if params[:delete]
      reject
    else
      accept
    end
  end

  def accept
    @review = GameTranslator::Review.find(params[:id])

    set_revised(@review.translations, 'accepted')

    @review.update_attribute(:status, 'accepted')

    flash[:success] = t('controllers.reviews.accepted')

    redirect_to review_path
  end

  def reject
    @review = GameTranslator::Review.find(params[:id])

    set_revised(@review.translations, 'rejected')

    @review.update_attribute(:status, 'rejected')

    flash[:success] = t('controllers.reviews.rejected')

    redirect_to review_path
  end

  private

  def set_revised(translations, status)
    translations.map do |translation|
      translation.update_attribute(:revised, true)
      translation.game.update_attribute(:status, 'not_translated') if status == 'rejected'
    end
  end
end