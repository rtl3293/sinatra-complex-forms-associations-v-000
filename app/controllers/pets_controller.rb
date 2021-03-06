class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet"]["name"])
    if params["owner_name"].empty?
      #
      @owner = Owner.find(params["pet"][":owner_id"][0])
    else
      # binding.pry
      @owner = Owner.create(name: params["owner_name"])
    end

    @pet.owner = @owner
    # binding.pry
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    # binding.pry
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if params["owner_name"].empty?
      @pet.owner = Owner.find_by(name: params["owner"]["name"])
    else
      # binding.pry
      @pet.owner = Owner.create(name: params["owner_name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
