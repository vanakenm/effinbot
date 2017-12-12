class CreateEffinQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :effin_quotes do |t|
      t.string :contents
      t.string :url

      t.timestamps
    end
  end
end
