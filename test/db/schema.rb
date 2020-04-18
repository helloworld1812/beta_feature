ActiveRecord::Schema.define do
  create_table :beta_feature_settings, force: true do |t|
    t.integer :betable_id
    t.string :betable_type
    t.string :betas, array: true, default: []
    t.timestamps
  end

  add_index :beta_feature_settings, [:betable_type, :betable_id], unique: true


  create_table :users, force: true do |t|
    t.string :first_name
    t.string :last_name
    t.integer :age
    t.timestamps
  end

  create_table :company, force: true do |t|
    t.string :name
    t.string :website
    t.timestamps
  end

  create_table :stores, force: true do |t|
    t.string :name
    t.string :location
    t.timestamps
  end

  create_table :groups, force: true do |t|
    t.string :name
    t.text   :description
    t.timestamps
  end

end