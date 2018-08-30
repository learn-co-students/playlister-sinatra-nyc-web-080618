class Slugifiable
  def slugify(word)
    slugified = word.split(' ').join('-').downcase
  end
end
