Sequel.migration do
  up do
    add_column :users, :username, String
  end

  down do
    drop_column :users, :username
  end
end
