class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end


# Reminder -- the params hash structure looks like this:
    # params{"figure"=>{"name"=>"Andrew Kim", "title_ids"=>["2"], "landmark_ids"=>["1"]}}
    # params{"title"=>{"name"=>"Mr."}}
    # params{"landmark"=>{"name"=>"MSG"}}

  post '/figures' do
    puts params
    @figure = Figure.create(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    @figure.save
    # flash[:message] = "Successfully created a new figure."
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save
    # flash[:message] = "Successfully updated figure."
    redirect to "/figures/#{@figure.id}"
  end
end






