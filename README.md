Daily Lager
===========

"It's good for you", she said. 

"How good for me? *Measureably* good?"

Daily Lager allows you to quickly log the day's events, as they
happen, either via SMS, from a terminal, or via email. 
Once you acquire enough data, you can answer that last 
question for yourself.



The DSL
-------
  Available commands:
        MENU
        LIST
        TODAY
        YESTERDAY
        CREATE <thing> [DEFAULT <integer>]
        RENAME <thing_name> <new_name>
        DELETE <thing>


    MENU 
      # Displays the help screen

    LIST 
      # Shows a list of things you are tracking

    CREATE <thing> [DEFAULT <integer>]

    DELETE <thing> 
      # Deletes a thing you're tracking

    TODAY 
      # Shows all the things you've logged today

    YESTERDAY 
      # Shows all the things you logged yesterday

    UPDATE DEFAULT <thing> <new_name>
      # Update the default value of something you're tracking

    RENAME <thing> <new_name>
      # Change the name (and hence the DSL) of something you're tracking

    <integer> <thing_name> 
      # Logs a single piece of data for today's date


Examples
--------
Let's say you want to log how many miles you walk, how many days
you take your B vitamins, and how much you sleep.

Create a thing called 'walk':
  CREATE walk 
    => 'walk' created

Create a thing called 'sleep':
  CREATE sleep
    => 'sleep' created

Create a thing called 'vitamins' with a default value of 1:
  CREATE vitamin DEFAULT 1
    => 'vitamin' created with a default value of 1

Ask what things are loaded:
  LIST
    => Things you're tracking:
       sleep
       vitamin (default 1)
       walk 

Log that you walked two (miles) today:
  2 walk
    => Logged 2 walk(s) 

Log that you slept 6 hours today:
  6 sleep
    => Logged 6 sleep(s)

Log that you walked six more miles (still the same day)
  6 walk
    => Logged 6 walk(s), total today: 8

Ask what's been logged today:
  TODAY
    =>  Today's totals:
        6 sleep
        1 vitamin
        8 walk

A Note About UPPERCASE
----------------------

Uppercase letters are used to better highlight which words are keywords. 
However, you can enter them as either upper or lower case (or a mixture of both).

Interactive Demo
---------------------------------------

Try out the Demo. It's an ncurses simulation of Daily Lager being run over SMS. 

First install Ruby 2.x, then run:

    bundle exec ruby demo.rb

It looks like this:

        ┌-------------------------------------------┐
        |                                           |
        |  Welcome to the Daily Lager Demo

        Available commands:
        MENU
        LIST
        TODAY
        YESTERDAY
        CREATE <thing> [DEFAULT <integer>]
        RENAME <thing_name> <new_name>
        DELETE <thing>

        Full docs: http://to_be_determined

        To close the demo, CTRL-C                   |
        |                                           |
        └-------------------------------------------┘

You can use the DSL to create categories and log them.

        ┌-------------------------------------------┐
        |                                           |
        |  create carrots                           |
        |                                           |
        └-------------------------------------------┘
        ┌-------------------------------------------┐
        |                                           |
        |  Category 'carrots' created.              |
        |                                           |
        └-------------------------------------------┘


What Data is Logged
-------------------

Each category gets a default entry for each day. If you 
don't set a default value, then the default value is 0.
Whenever you log something using the DSL, it creates
an additional entry for that category, with the value
you provided. When you ask for your daily totals, it
adds them up for you. 


Negative Numbers
----------------

All things that you log are additive. For example, if your 
default value for a category is 10 but today you want to record
'8' instead, just log '-2'. That will set the day's totals to 8.


Data Mining
-----------

Once you have enough data, you can determine whether those green 
vegetables you've started eating are really decreasing the 
frequency of your hiccups when you train for your marathon.

Some simple queries are available through the DSL, such as
TODAY and YESTERDAY. But Daily Lager is primariy intended to
the the method of logging the data. You will need to use your
SQL hackery yourself to intelligently interpret the data.


Roadmap
--------------

Completed:

  * Chain of Responsibility pattern to determine which subclass of Verb is appropriate for a given input
  * Human model corresponds to a user
  * Thing model corresponds to a category
  * Occurrence model corresponds to a single piece of data logged
  * Textual output for each subclass of Verb is unit tested
  * Demo (demo.rb) lets you interact with the DSL without a server
  * Before logging new data, it backlogs any days with no data 
    with the default values

Backlog:

  * Design and implement the durable storage mechanism (probably a 
    relational database)
  * Connect to Twilio via Sinatra for a single user

Icebox:
  
  * Allow multiple users to access the same Sinatra instance, 
    identified by phone number 
  * Graphical representation of data
  * Add verbs for WEEK, LAST WEEK, MONTH, LAST MONTH, YEAR, and <year>


