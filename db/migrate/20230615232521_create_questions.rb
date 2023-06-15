class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.integer :prompt_id
      t.text :answer
      t.text :feed

      t.timestamps
    end
  end
end
