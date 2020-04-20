class <%= migration_class_name %> < <%= migration_parent %>
  def self.up
    create_table :beta_feature_settings, force: true do |t|
      t.bigint :betable_id, null: false
      t.string :betable_type, null: false
      t.string :betas, array: true, default: [], null: false
      t.timestamps

      t.index [:betable_type, :betable_id], unique: true
    end
  end

  def self.down
    drop_table :beta_feature_settings
  end
end
