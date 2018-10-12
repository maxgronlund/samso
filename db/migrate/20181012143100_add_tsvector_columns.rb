class AddTsvectorColumns < ActiveRecord::Migration[5.2]
  def up
    add_column :admin_blog_posts, :tsv, :tsvector
    add_index :admin_blog_posts, :tsv, using: "gin"

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON admin_blog_posts FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv, 'pg_catalog.english', title, body, subtitle, signature
      );
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE admin_blog_posts SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON admin_blog_posts
    SQL

    remove_index :admin_blog_posts, :tsv
    remove_column :admin_blog_posts, :tsv
  end
end
