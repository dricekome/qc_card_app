class CreateQuestCards < ActiveRecord::Migration[8.0]
  def change
    create_table :quest_cards do |t|
      t.string :name
      t.string :color
      t.boolean :used

      t.timestamps
    end
  end
end
