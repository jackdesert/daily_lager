SMLogger
========

"It's good for you", she said. 

"How good for me? Measureably good?"

To find out, you need to track inputs and outputs, aka 'things'. 
Once you have enough data, you can determine whether those green 
vegetables you've started eating are really decreasing the 
frequency of your hiccups when you train for your marathon.
How about the relationship between hours of sleep and your 
general mood at four in the afternoon? 

SmLogger was born out of a need to easily record such data.
It consists of a DSL:
    HELP 
      # Displays the help screen

    LIST 
      # Shows a list of things you are tracking

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

Try out the DSL without wiring up an SMS provider
-------------------------------------------------

There is a method called 'sms' that you can use to interact with the defined in spec/support/helper methods.rbTo test out the features without setting up an SMS provider, simply

    $ pry
    > require './spec/spec_helper'
    > sms 'help'
    > sms 'create walk'
    > sms '3 walk'

Roadmap
--------------

Completed:

  * Chain of Responsibility pattern to determine which subclass of Verb is appropriate for a given input
  * Specs verifying the above, including verifying that the input is INappropriate for all other subclasses 

Backlog:

  * Set the response output for each verb subclass
  * Design and implement the durable storage mechanism 
  * Tie in to Twilio 

Icebox:
  
  * Allow multiple users to access the same Sinatra instance
  * Graphical representation of data


