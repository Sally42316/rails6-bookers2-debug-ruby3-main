class CommentsController < ApplicationController
    def create
        book = Book.find(params[:book_id])
        comment = current_user.comments.new(comment_params)
        comment.book_id = book.id
        if comment.save
          @comment = comment # @commentに作成したコメントをセット
        end
        # redirect_to request.referer
      end

      def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        @comment = comment # 削除したコメントを@commentにセット
        # redirect_to book_path(params[:book_id])
      end
    
      private
    
      def comment_params
        params.require(:comment).permit(:comment)
      end
end
