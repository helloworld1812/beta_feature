class CreateBetaFeatureSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :beta_feature_settings, if_not_exists: true do |t|
      t.string :betable_type, null: false
      t.bigint :betable_id, null: false
      t.string :betas, array: true, default: [], null: false
      t.timestamps
      
      t.index [:betable_type, :betable_id], unique: true
    end
  end
end
