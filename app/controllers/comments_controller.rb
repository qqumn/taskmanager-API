class CommentsController < ApplicationController
  def create
    comment = comments.new(comment_params)
    if comment.save
      render json: comment, status: :ok
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if comment.update(comment_params)
      render json: comment, status: :ok
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment.destroy
    head :ok
  end

  private

  def comment
    @comment ||= comment.find(params[:id])
  end

  def comments
    @comments ||= commentable.comments
  end

  def commentable_id
    params.require(:commentable_id)
  end

  def commentable_type
    params.require(:commentable_type)
  end

  def commentable
    commentable_type.camelize.constantize.find(commentable_id)
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
