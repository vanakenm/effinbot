class EffinQuote < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_word, against: [:contents]

  def self.find_by_word(word)
    complete.search_by_word(word).first
  end

  def self.words
    words = Hash.new(0)
    complete.each do |quote|
      quote.words.each do |word|
        words[word.downcase] += 1
      end
    end

    words
  end

  def self.everywords
    complete.map(&:words).flatten
  end

  def words
    contents.split(" ")
  end

  def self.find_or_random(text)
    quote = EffinQuote.find_by_word(text)
    quote ? [quote, false] : [EffinQuote.complete.sample, true]
  end

  def self.complete
    where('url is not null and twitter_url is not null and contents is not null')
  end

  def complete?
    url && twitter_url && contents
  end

  def self.incomplete
    where('url is null or twitter_url is null or contents is null')
  end
end
