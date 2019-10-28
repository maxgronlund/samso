class AddSearchIndex < ActiveRecord::Migration[5.2]
  def up
    execute(<<-'eosql'.strip)
      CREATE index admin_blog_posts_fts_idx
      ON admin_blog_posts
      USING gin(
        (setweight(to_tsvector('danish', coalesce("admin_blog_posts"."title", '')), 'A') ||
        ' ' ||
        setweight(to_tsvector('danish', coalesce("admin_blog_posts"."subtitle",'')), 'B')||
        ' ' ||
        setweight(to_tsvector('danish', coalesce("admin_blog_posts"."body",'')), 'C')
        )
      )
    eosql
  end

  def down
    remove_index :admin_blog_posts, name: :admin_blog_posts_fts_idx
  end
end
