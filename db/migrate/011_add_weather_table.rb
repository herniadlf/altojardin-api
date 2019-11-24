Sequel.migration do
  up do
    create_table(:weather) do
      primary_key :id
      Date :date
      bool :rain
    end
  end

  down do
    drop_table(:weather)
  end
end
