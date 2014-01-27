DB.create_table(:occurrences) do
  primary_key :id
  Fixnum :thing_id
  Date :date
  Fixnum :value
end
