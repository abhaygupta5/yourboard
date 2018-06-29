class CommentsController < ApplicationController
	before_action :find_comment, only: [:destroy]
	def index
		@comments=Comment.all.order('created_at DESC').paginate(:page=> params[:page], :per_page=> 7)
	end

	def new
		@comment=current_user.comments.build
	end

	def create
		#@post=Post.find(params[:post_id])
		#@comment=@post.comments.create(params[:comment].permit(:body))
		@comment=current_user.comments.build(comment_params)
		@comment.user_id = current_user.id
		@comment.save
		flash[:notice] = "Thanks for feedback"
		redirect_to root_path

	end

	#def edit
	#end

	#def update
	#end

	#def show
	#end

	def destroy
		#@post=Post.find(params[:post_id])
		#@comment=@post.comments.find(params[:id])
		#@comment.destroy
		#redirect_to post_path(@post)
		@comment.destroy
		redirect_to feedbacks_path
	end

	private
		def find_comment
			@comment = Comment.find(params[:id])
		end

		def comment_params
			params.require(:comment).permit(:body)
		end

	
end
