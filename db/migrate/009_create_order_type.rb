Sequel.migration do
  up do
    create_table(:order_type) do
      primary_key :menu, type: String
      Int :weight
    end

    DB[:order_type].insert(['menu_individual', 1])
    DB[:order_type].insert(['menu_pareja', 2])
    DB[:order_type].insert(['menu_familiar', 4])
  end

  down do
    drop_table(:order_type)
  end
end
