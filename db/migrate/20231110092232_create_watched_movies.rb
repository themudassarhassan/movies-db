class CreateWatchedMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :watched_movies do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :movie, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
