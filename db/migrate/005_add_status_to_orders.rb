Sequel.migration do
  up do
    add_column :orders, :status, Integer
  end

  down do
    drop_column :orders, :status
  end
end
