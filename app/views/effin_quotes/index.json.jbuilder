json.array! @quotes do |quote|
  json.extract! quote, :id, :contents, :url
end
