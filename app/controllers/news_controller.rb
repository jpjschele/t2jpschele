class NewsController < ApplicationController
	skip_before_action :verify_authenticity_token 
  before_action :set_new, only: [:show,:destroy,:update]
  before_action :set_new_2, only: [:comments]

	def index
      render json: New.all
    end

    def show
	 
	  if stale?(last_modified: @new.updated_at)
	    render json: @new
	  end
	end

    def create
      @new = New.new(new_params)
      if @new.save
        render json: @new, status: :created, location: news_url(@new)
      else
        render json: { errors: @new.errors }, status: :unprocessable_entity
      end
    end

    def destroy
		if @new.destroy
			render json: @new
		end
	end

	def update
    	if @new.update(new_params) 
    		render json: @new
    	else
    		render json: { errors: @new.errors }, status: :unprocessable_entity
    	end

    end

	def comments
		render json: @new.comments
	end

  private

  def new_params
      params.require(:news).permit(:title, :body, :subtitle)
  end

  def set_new
    @new = New.find(params[:id])
  rescue Exception
    render :json => {:error => "not-found"}.to_json, :status => 404
  end

  def set_new_2
    @new = New.find(params[:news_id])
  rescue Exception
    render :json => {:error => "not-found"}.to_json, :status => 404 
  end
end