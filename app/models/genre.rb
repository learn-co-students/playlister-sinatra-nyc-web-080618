class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres

  has_many :artists, through: :songs

  def slug
    my_slug = Slugifiable.new
    my_slug.slugify(self.name)
  end

  def self.find_by_slug(slug)
    self.all.find do |genre|
      slug == genre.slug
    end
  end
end
