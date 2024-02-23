class AddValidatedReviewedToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :validated, :boolean
    add_column :events, :reviewed, :boolean, null: false, default: false
  end
end
