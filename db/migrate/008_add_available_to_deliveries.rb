Sequel.migration do
  up do
    add_column :deliveries, :available, TrueClass, default: true
  end

  down do
    drop_column :deliveries, :available
  end
end
