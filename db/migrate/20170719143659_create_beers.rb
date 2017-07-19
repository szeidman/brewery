class CreateBeers < ActiveRecord::Migration[5.1]
  def change
    create_table :beers do |t|
      t.string :name
      t.integer :user_id
      t.string :style
      t.float :abv
      t.float :ibu
      t.float :srm

      t.timestamps
    end
  end
end
