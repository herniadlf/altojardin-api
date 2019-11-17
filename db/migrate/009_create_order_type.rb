Sequel.migration do
  up do
    create_table(:menu_types) do
      primary_key :menu, type: String
      Int :weight
    end

    DB[:menu_types].insert(['menu_individual', 1])
    DB[:menu_types].insert(['menu_pareja', 2])
    DB[:menu_types].insert(['menu_familiar', 4])
  end

  down do
    drop_table(:menu_types)
  end
end
