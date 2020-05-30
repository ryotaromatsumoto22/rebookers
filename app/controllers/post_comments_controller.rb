class PostCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		book = Book.find(params[:book_id])
		comment = PostComment.new(post_comment_params)
		comment.user_id = current_user.id
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end

	def destroy
		comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
		comment.destroy
		redirect_to book_path(params[:book_id])
	end

	private
	def post_comment_params
		params.require(:post_comment).permit(:comment, :user_id, :book_id)
	end
end
