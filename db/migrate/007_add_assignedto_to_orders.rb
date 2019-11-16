Sequel.migration do
  up do
    add_column :orders, :assigned_to, Integer
  end

  down do
    drop_column :orders, :assigned_to
  end
end
