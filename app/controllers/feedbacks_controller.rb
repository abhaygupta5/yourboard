class FeedbacksController < ApplicationController
	before_action :find_feedback, only: [:destroy]
	
	def index
		@feedbacks=Feedback.all.order('created_at DESC').paginate(:page=> params[:page], :per_page=> 7)
	end

	def new
		@feedback=current_user.feedbacks.build
	end

	def create
		#@post=Post.find(params[:post_id])
		#@feedback=@post.feedbacks.create(params[:feedback].permit(:body))
		@feedback=current_user.feedbacks.build(feedback_params)
		@feedback.user_id = current_user.id
		@feedback.save
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
		#@feedback=@post.feedbacks.find(params[:id])
		#@feedback.destroy
		#redirect_to post_path(@post)
		@feedback.destroy
		redirect_to feedbacks_path
	end

	private
		def find_feedback
			@feedback = Feedback.find(params[:id])
		end

		def feedback_params
			params.require(:feedback).permit(:body)
		end	
end
