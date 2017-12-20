class EffinQuote < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_word, against: [ :contents ]

  def complete?
    url && twitter_url && contents
  end

  def autocomplete
    require "google/cloud/vision"
    vision = Google::Cloud::Vision.new(project_id: "effin-bot")
    image = vision.image(url)
    text = image.text.to_s
    text = text.gsub("\n", " ").downcase

    self.contents = text
    save
  end

  def self.complete
    where("url is not null and twitter_url is not null and contents is not null")
  end

  def self.incomplete
    where("url is null or twitter_url is null or contents is null")
  end

  def self.find_by_word(word)
    complete.search_by_word(word).first
  end
end
