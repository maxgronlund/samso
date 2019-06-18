class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  layout false

  # POST /comments
  def create
    @comment = Comment.new(new_comment_params)
    set_state
    if @comment.save
      @comment.weekly_comments.create
      commentable = @comment.commentable
      #update_weekly_comments(commentable)
    else
      render nothing: true
    end
  end

  # PATCH/PUT /comments/1
  def update
    @comment.update(comment_params)
    set_state
  end

  # DELETE /comments/1
  def destroy
    commentable = @comment.commentable
    @comment.destroy
    #update_weekly_comments(commentable)
  end

  private

  def set_state
    return if current_user.name == @comment.author_name
    return unless @comment.default?

    @comment.update(state: 'reported')
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def new_comment_params
    _params = comment_params.dup
    _params[:user_id] = current_user.id if user_signed_in?
    _params
  end

  def update_weekly_comments(commentable)
    #commentable.update_weekly_comments_count! if commentable.is_a?(Admin::BlogPost)
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params
      .require(:comment)
      .permit(
        :comment,
        :user_id,
        :commentable_id,
        :commentable_type,
        :author_name,
        :state
      )
  end
end
