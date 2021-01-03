class CreateBetaFeatureSettings < ActiveRecord::Migration[5.1]
  def up
    if !ActiveRecord::Base.connection.data_source_exists? 'beta_feature_settings'
      create_table :beta_feature_settings, if_not_exists: true do |t|
        t.bigint :betable_id,   null: false
        t.string :betable_type, null: false
        t.string :betas, array: true, default: [], null: false
        t.timestamps

        t.index [:betable_type, :betable_id], unique: true
      end
    end
  end

  def down
    drop_table :beta_feature_settings if ActiveRecord::Base.connection.data_source_exists? 'beta_feature_settings'
  end
end
