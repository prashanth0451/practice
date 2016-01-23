class Blogs::CommentsController < AuthenticatedController

	def create
		@blog = Blog.find(params[:id])
		@comment = Blogs::Comment.new(comment_params)
		@comment.user = current_user
		@comment.save
		if @comment.errors.count > 0
			flash[:alert] = @comment.errors.full_messages.join(', ')
		end
		if @comment.save
			@comment.blog = @blog
			@comment.save
			redirect_to blog_path(@blog)
		else
			render '/blogs/show'
		end
	end

	def destroy
		@comment = Blogs::Comment.find(params[:id])
		raise_error
		@blog = @comment.blog
		@comment.destroy
		redirect_to @blog
	end

	def raise_error
		if @comment.user != current_user
		  raise "You are not authorized to do this operation. Incident will pe reported with IP."
		end
	end

	def comment_params
		params.require(:blogs_comment).permit(:comment, :author)
	end

end