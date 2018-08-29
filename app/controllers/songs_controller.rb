class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'songs/new'
  end

  post '/songs' do
    @song = Song.create(name: params[:song][:name])
    if !params[:song][:artist][:name].empty?
      artist = Artist.find_by(name: params[:song][:artist][:name])
      if artist == nil
        @song.artist = Artist.create(name: params[:song][:artist][:name])
      else
        @song.artist = artist
      end
    end
    if !params[:song][:genre_ids].empty?
      params[:song][:genre_ids].each do |genre_id|
        @song.genres << Genre.find(genre_id)
      end
    end
    @song.save


    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save
    
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

  delete 'songs/:slug' do
    song_name = params[:slug].gsub('-',' ')
    @song = Song.find_by(name: song_name)
    @song.delete

    redirect "/songs"
  end




end
