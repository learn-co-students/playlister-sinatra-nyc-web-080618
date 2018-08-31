class Artist < ActiveRecord::Base
  has_many :songs

  has_many :genres, through: :songs

  def slug
    slug_name = self.name.gsub(" ", "-")
    slug_name.downcase
  end

  def self.find_by_slug(slug_name)
    Artist.all.find do |artist|
      artist.slug == slug_name
    end
  end
end
