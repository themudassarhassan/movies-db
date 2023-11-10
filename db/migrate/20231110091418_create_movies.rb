# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.datetime :release_date, null: false
      t.text :overview, null: false
      t.string :poster_path, null: false

      t.timestamps
    end
  end
end
