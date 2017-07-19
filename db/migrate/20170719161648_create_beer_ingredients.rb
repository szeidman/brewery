class CreateBeerIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :beer_ingredients do |t|
      t.integer :beer_id
      t.integer :ingredient_id
      t.integer :amount

      t.timestamps
    end
  end
end
