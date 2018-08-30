class Song < ActiveRecord::Base
belongs_to :artist
has_many :song_genres
has_many :genres, through: :song_genres

def slug
  temp = self.name
  temp = temp.downcase
  temp.gsub(/[^abcdefghijklmnopqrstuvwxyz]/,'-')
 
end

def self.find_by_slug(slugg)
  artist = ""
  self.all.each do |eachA|
    if eachA.slug == slugg
      artist = eachA
    end
  end
  artist
end


end
