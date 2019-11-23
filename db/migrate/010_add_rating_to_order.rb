Sequel.migration do
  up do
    add_column :orders, :rating, Integer
  end

  down do
    drop_column :orders, :rating
  end
end
