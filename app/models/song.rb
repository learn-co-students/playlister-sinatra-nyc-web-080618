class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    my_slug = Slugifiable.new
    my_slug.slugify(self.name)
  end

  def self.find_by_slug(slug)
    my_song = self.all.find do |song|
      slug == song.slug
    end
  end
end
