
class Note < Sequel::Model


  many_to_one :human

  private

  def before_validation
    self.date ||= Util.current_date_in_california
  end

  def validate
    super
    errors.add(:date, 'Must be a Date') unless date.kind_of? Date
    errors.add(:body, 'Must be present') unless body.is_a?(String) && (body.length > 0)
  end

end
