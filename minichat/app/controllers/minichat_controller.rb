class MinichatController < ApplicationController
  def index
  	@post = Micropost.all(limit: 10)
  end

  def traitement
  	@micropost = Micropost.create(:author => params[:author], :content => params[:post])
  	unless @micropost.errors.any?
  		flash.now[:success] = "Post created!"
  	end
  	@post = Micropost.all(limit: 10)
  	#redirect_to :back
  	render 'index'
  end
end