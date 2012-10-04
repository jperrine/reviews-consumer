class Show < ActiveRecord::Base
  attr_accessible :name, :description, :widget_key

  def reviews
    conn = Faraday.new(url: 'http://hack-reviews.herokuapp.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get('reviews.json', key: self.widget_key)

    if response
      reviews = []
      JSON.parse(response.body).each do |review|
        reviews << Review.new(review['title'], review['description'])
      end
      reviews
    else
      []
    end
  end
end
