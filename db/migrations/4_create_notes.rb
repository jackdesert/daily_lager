DB.create_table(:notes) do
  primary_key :id
  Fixnum :human_id
  String :body
  Date :date
end

