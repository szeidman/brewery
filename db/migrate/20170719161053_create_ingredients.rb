class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :kind
      t.string :origin

      t.timestamps
    end
  end
end
