Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each { |f| require(f) }

require 'pry'
def clear_screen
  `clear`
end

clear_screen

puts "Welcome to the Interactive SMLogger Demo"
sleep 1
puts "To see a list of available methods, enter 'help' (without the quotes) and press ENTER."
sleep 1
puts "To close the demo, CTRL-C"
human = Human.new
while true
  text = gets.chomp
  binding.pry
  clear_screen
  Verb.new(text, human).receive
end
