# frozen_string_literal: true

class CreateEPaperTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :e_paper_tokens do |t|
      t.belongs_to :user, foreign_key: true
      t.string :secret

      t.timestamps
    end
    add_column :users, :e_paper_tokens_count, :integer
  end
end
