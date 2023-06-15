class CreateSentences < ActiveRecord::Migration[6.0]
  def change
    create_table :sentences do |t|
      t.text :content
      t.string :kind
      t.integer :prompt_id

      t.timestamps
    end
  end
end
