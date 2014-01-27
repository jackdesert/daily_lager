class Database
  def self.sqlite
    @sqlite ||= Sequel.sqlite
  end
end
