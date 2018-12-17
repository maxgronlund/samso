# format stuff related to comments nicely
module CommentsHelper
  def commentable_page_path(comment)
    commentable = comment.commentable
    page        = comment_page(commentable)
    return if page.nil?

    link_to commentable.title, page_post_path(page, commentable, anchor: dom_id(comment))
  end

  def show_comment(comment)
    commentable = comment.commentable
    page        = comment_page(commentable)
    return if page.nil?

    link_to 'Vis', page_post_path(page, commentable, anchor: dom_id(comment))
  end

  private

  def comment_page(commentable)
    return if commentable.nil?

    case commentable.class.name
    when 'Admin::BlogPost'
      return Page.find_by(id: commentable.post_page_id)
    end
  end
end
