class SongsController < ApplicationController



  get "/songs" do
    @songs = Song.all
    erb :"songs/index"
  end
  get "/songs/new" do
    erb :"songs/new"
  end
  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    #binding.pry
    erb :"songs/show"
  end
  post "/songs" do
    @song=Song.create(name: params[:song_name])
    @artists_arr = []
    Artist.all.each do |artist|
      @artists_arr << artist.name
    end

    if @artists_arr.include? params[:artist_name]
      @artist= Artist.all.find_by(name: params[:artist_name])
    else
      @artist=Artist.create(name: params[:artist_name])
    end
      @artist.songs << @song
    @artist.save
    params[:song][:genre_ids].each do |genre_id|
        genre_id = genre_id.to_i
        genre = Genre.all.find(genre_id)
        @song.genres << genre
        @song.save
    end
    redirect "/songs/#{@song.slug}"
  end
end
