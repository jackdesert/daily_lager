DB.create_table(:things) do
  primary_key :id
  Fixnum :human_id
  String :name
  Fixnum :default_value
end

