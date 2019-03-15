# format stuff related to comments nicely
module CommentsHelper
  def commentable_page_path(comment)
    commentable = comment.commentable
    return if commentable.nil?

    link_to commentable.title, commentable_path(commentable)
  end

  def show_comment(comment)
    commentable = comment.commentable
    return if commentable.nil?

    link_to 'Vis', commentable_path(commentable), class: 'btn btn-sm btn-light'
  end

  private

  def commentable_path(commentable)
    case commentable.class.name
    when 'Admin::BlogPost'
      return page_post_path(commentable.show_page, commentable)
    end
    root_path
  end
end
