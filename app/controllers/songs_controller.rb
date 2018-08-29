require "pry"
require "rack-flash"
class SongsController < ApplicationController

  enable :sessions
  use Rack::Flash

  get "/songs" do
    @songs = Song.all

    erb :"/songs/index"

  end

  get "/songs/new" do
    erb :"songs/new"
  end


  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])

    erb :"/songs/show"
  end

  post "/songs" do
    #binding.pry
    artist = Artist.find_or_create_by(name: params[:artist_name])
    song = Song.create(name: params[:song_name], artist_id: artist.id)
    params[:genres].each do |genre|
      SongGenre.create(genre_id: genre, song_id: song.id)

    end
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{song.slug}")

  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])

    erb :"/songs/edit"

  end

  patch "/songs/:slug" do
    song = Song.find_by_slug(params[:slug])
    artist = Artist.find_or_create_by(name: params[:artist_name])
    song.update(artist_id: artist.id)

    song.song_genres.destroy_all

    params[:genres].each do |genre|
      SongGenre.create(genre_id: genre, song_id: song.id)

    end

    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{song.slug}")



  end








end
