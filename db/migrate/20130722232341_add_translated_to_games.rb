class AddTranslatedToGames < ActiveRecord::Migration
  def change
  	add_column :games, :translated, :integer, default: 0
  end
end
