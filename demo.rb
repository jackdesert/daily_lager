Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each { |f| require(f) }

require 'curses'
require 'pry'


class Demo
  include Curses
  attr_accessor :queue, :awin

  def initialize
    init_screen
    reset_cursor
    addstr("Hit any key")
    @queue = []
  end

  def add(item)
    queue.unshift(item)
  end

  def first_up
    queue[0]
  end

  def second_up
    queue[1]
  end

  def show_both_messages
    spacing = 5
    queue.inject(0) do |total_offset, current_message|

      spacing + total_offset + show_message(current_message, total_offset)
    end
  end

  def show_message(message, offset=0)
    return if message.nil?
    message_height = message.count "\n"

    height = 5
    width = 30 #message.length + 6
    top = (lines - 5) / 2 -offset - 5

    if top >= 0
      left = (cols - width) / 2
      awin ||= Window.new(height, width,
                   top, left)
      awin.box(?|, ?-)
      awin.setpos(2, 3)
      awin.addstr(message)
      awin.refresh
    end
    message_height
  end

  def exit
    close_screen
  end

  def get_string
    getstr
  end

  def display_input(input)
    refresh
    reset_cursor
    deleteln
    add(input)
    show_both_messages
    refresh
    reset_cursor
  end

  def reset_cursor
    setpos((lines - 5), (cols - 10) / 2)
  end
end

begin
  human = Human.new
  demo = Demo.new

  demo.display_input "Welcome to the Interactive SMLogger Demo"
  sleep 1
  demo.display_input "To see a list of available methods, enter 'help' (without the quotes) and press ENTER."
  sleep 1
  demo.display_input "To close the demo, CTRL-C"
  while true
    input = demo.get_string
    output = Verb.new(input, human).receive
    demo.display_input(output)
  end
ensure
  demo.exit
end
