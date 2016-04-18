json.array!(@articles) do |article|
  json.extract! article, :id, :source, :title, :datePub, :summary,
                :author, :img, :link
  json.url article_url(article, format: :json)
end
