class AddNotNullToProducts < ActiveRecord::Migration
  def change
    change_column :products, :name, :string, null: false
    change_column :products, :description, :text, null: false
    change_column :products, :price, :float, null: false
  end
end
