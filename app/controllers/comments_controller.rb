class CommentsController < ApplicationController
	before_action :find_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user_id = current_user.id
      if @comment.save
      	flash[:notice]= 'Your comment was successfully posted!'
        redirect_back fallback_location: root_path
      else
      	flash[:notice]= "Your comment wasn't posted!"
        redirect_back fallback_location: root_path
      end
    end

    def destroy
		@comment=Comment.find(params[:id])
		@comment.destroy
		redirect_back fallback_location: root_path
	end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end
end
