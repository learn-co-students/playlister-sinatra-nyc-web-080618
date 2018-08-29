require 'pry'
class GenresController < ApplicationController

  get "/genres" do
    @genres = Genre.all
    erb :"/genres/index"
  end

  get "/genres/new" do
    erb :"genres/new"
  end

  get "/genres/:slug/edit" do
  end

  post "/genres" do
  end

  get "/genres/:slug" do
    if params[:slug] == "hip-hop"
      @genre = Genre.find_by_slug(params[:slug])
    else
      # genre_name = params[:slug].gsub('-', ' ')
      # @genre = Genre.find_by(name: genre_name)
      @genre = Genre.find_by_slug(params[:slug])
    end
    erb :"genres/show"
  end

  patch "/genres/:slug" do
  end

  delete "/genres/:slug" do
  end




end
