class AddImgurlToPrompts < ActiveRecord::Migration[6.0]
  def change
    add_column :prompts, :img, :text
  end
end
