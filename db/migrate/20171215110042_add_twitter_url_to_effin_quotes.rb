class AddTwitterUrlToEffinQuotes < ActiveRecord::Migration[5.1]
  def change
    add_column :effin_quotes, :twitter_url, :string
  end
end
