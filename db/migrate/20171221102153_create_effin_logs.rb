class CreateEffinLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :effin_logs do |t|
      t.references :effin_quote, foreign_key: true
      t.string :text
      t.boolean :random
      t.string :team_doman

      t.timestamps
    end
  end
end
