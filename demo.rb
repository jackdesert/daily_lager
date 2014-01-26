Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each { |f| require(f) }

require 'curses'
require 'pry'


class Demo
  attr_accessor :queue, :awin

  MESSAGE_WIDTH = 45

  def initialize
    Curses.init_screen
    reset_cursor
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

    height = 5 + message_height
    top = (Curses.lines - 5) / 2 - offset + 15 - message_height

    if top >= 0
      left = (Curses.cols - MESSAGE_WIDTH) / 2
      window = Curses::Window.new(height, MESSAGE_WIDTH,
                   top, left)
      window.box(?|, ?-)
      window.setpos(2, 3)
      window.addstr(message)
      window.refresh
    end
    message_height
  end

  def exit
    Curses.close_screen
  end

  def get_string
    Curses.getstr
  end

  def display_input(input)
    Curses.refresh
    reset_cursor
    Curses.deleteln
    add(input)
    show_both_messages
    Curses.refresh
    reset_cursor
  end

  def reset_cursor
    y = Curses.lines - 5
    x = (Curses.cols - MESSAGE_WIDTH) / 2 + 3
    Curses.setpos(y, x)
  end
end

def sec
  sleep 0.3
end

begin
  human = Human.new
  demo = Demo.new

  intro = "Welcome to the Daily Lager Demo"
  menu_response = Verb.new('menu', human).responder.response
  intro += menu_response
  intro += "\n\nTo close the demo, CTRL-C"
  demo.display_input intro

  while true
    input = demo.get_string
    demo.display_input(input)
    sec
    responder = Verb.new(input, human).responder
    demo.display_input(responder.response)
  end
ensure
  demo.exit
end
