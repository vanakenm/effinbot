class EffinQuote < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_word, against: [ :contents ]

  def self.find_by_word(word)
    search_by_word(word).first
  end
end
