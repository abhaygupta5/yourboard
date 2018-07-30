class CommentsController < ApplicationController
	before_action :find_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user_id = current_user.id
      if params[:post_id]
        @comment.post_id = params[:post_id]
      else
        @comment.post_id = Comment.where(commentable_id: @commentable.commentable_id).first.post_id
      end
      if @comment.save
        flash[:notice]= 'Your comment was successfully posted!'
        Post.find_by_id(@comment.post_id).decrement!(:count)
        redirect_back fallback_location: root_path
      else
      	flash[:notice]= "Your comment wasn't posted!"
        redirect_back fallback_location: root_path
      end
      Notification.create(recipient: Post.find_by_id(@comment.post_id).user, actor: current_user, action: 'posted', notifiable: Post.find_by_id(@comment.post_id))
    end

  def destroy
		@comment=Comment.find(params[:id])
    Post.find_by_id(@comment.post_id).decrement!(:count)
    @comment.destroy

    redirect_back fallback_location: root_path
	end

    private

    def comment_params
      params.require(:comment).permit(:body,:user_id,:post_id)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end
end
