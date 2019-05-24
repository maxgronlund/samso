class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  layout false

  # POST /comments
  def create
    if comment_params[:comment].present? && user_signed_in?
      comment_params[:user_id] = current_user.id
      @comment = Comment.create(comment_params)
    else
      render nothing: true
    end
  end

  # PATCH/PUT /comments/1
  def update
    @comment.update(comment_params)
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params
      .require(:comment)
      .permit(
        :comment,
        :user_id,
        :commentable_id,
        :commentable_type
      )
  end
end
