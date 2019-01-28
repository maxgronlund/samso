class InstallTrigram < ActiveRecord::Migration[5.2]
  def up
    execute "create extension pg_trgm;"
  end
end
