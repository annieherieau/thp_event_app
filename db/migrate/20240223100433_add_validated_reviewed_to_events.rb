class AddValidatedReviewedToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :validated, :boolean, null: false, default: false
    add_column :events, :reviewed, :boolean, null: false, default: false
  end
end
