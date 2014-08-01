class WebVerb < Verb
  WEB_URI = 'http://lager.jackdesert.com'

  def process
    "#{WEB_URI}?secret=#{human.secret}"
  end

  private
  def successor
    CreateVerb
  end

  def appropriate?
    words == ['web']
  end
end
