class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.all
    erb :"artists/index"
  end # all artists

  get '/artists/new' do
    erb :"artists/new"
  end

  post '/artists' do
    @artist = Artist.create(name: params[:artist][:name])

    erb :"/artists/index"
  end

  get '/artists/:slug/edit' do
    # artist_name = params[:slug].gsub('-',' ')
    @artist = Artist.find_by_slug(params[:slug])
    erb :"artists/edit"
  end

  patch '/artists/:slug' do
    # artist_name = params[:slug].gsub('-',' ')
    # @artist = Artist.find_by(name: artist_name)
    @artist = Artist.find_by_slug(params[:slug])
    @artist.name = params[:artist][:name]
    @artist.songs = params[:artist][:songs]
    @artist.genres = params[:artist][:genres]
    @artist.save

    redirect :"/artists/#{params[:slug]}"
  end


  get '/artists/:slug' do
    # artist_name = params[:slug].gsub('-',' ')
    # @artist = Artist.find_by(name: artist_name)
    @artist = Artist.find_by_slug(params[:slug])
    erb :"artists/show"
  end

end
