DB.alter_table(:humans) do
  add_column :secret, String
end
