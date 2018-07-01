class PagesController < ApplicationController
	def about
		
	end

	def userlist
		@userlist = User.all.paginate(:page=> params[:page], :per_page=> 10)
		@post = Post.all
		@comment = Comment.all
	end
end
