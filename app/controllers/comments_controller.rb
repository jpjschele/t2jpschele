class CommentsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :set_new, only: [:create, :show_comment, :destroy_comment, :update_comment]
	before_action :set_comment, only: [:show_comment, :destroy_comment, :update_comment]

	def show_comment	
		if @new.id == @comment.new_id
			render json: @comment
		else
			render :json => {:error => "not-found"}.to_json, :status => 404
		end
	end

	def create
		@comment = Comment.new(comment_params)
    	@new.comments << @comment
	    if @comment.save
	      render json: @comment, status: :created, location: news_url(@new)
	    else
	      render :json => {:error => "not-found"}.to_json, :status => 404
	    end

	end

	def destroy_comment	
		if @new.id == @comment.new_id
			if @comment.destroy
				render json: @comment
			end
		else
			render :json => {:error => "not-found"}.to_json, :status => 404
		end
	end

	def update_comment
		if @new.id == @comment.new_id
			if @comment.update(comment_params)
				render json: @comment
			else
				render json: { errors: @comment.errors }, status: :unprocessable_entity
			end
		else
			render :json => {:error => "not-found"}.to_json, :status => 404
		end
	end


	private

	def set_new
		@new = New.find(params[:new_id])
	rescue Exception
		render :json => {:error => "not-found"}.to_json, :status => 404
	end

	def set_comment
		@comment = Comment.find(params[:id])
	rescue Exception
		render :json => {:error => "not-found"}.to_json, :status => 404	
	end


	def comment_params
      params.permit(:author, :comment, :new_id)
    end
end