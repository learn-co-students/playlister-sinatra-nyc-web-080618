class Song <ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug_name)
    Song.all.find do |song|
      song.slug == slug_name
    end  


  end

end
