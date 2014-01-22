SMLogger
========

SMLogger is a domain specific language for logging your daily activities via SMS. 

Activities can be anything you want. 
Let's say you want to log how many miles you walk. 

"create walk" sets up a type of activity called "walk".
"2 walk" then records that you walked two (miles) today.
"today" would tell you the sum total of all the activities you completed today. 
"help" tells you how to use SMlogger

Command Line Interface
----------------------

To test out the features without setting up an SMS provider, simply

    $ pry
    > require './spec/spec_helper'
    > sms 'help'
    > sms 'create walk'
    > sms '3 walk'

Roadmap
--------------

Complete:

  * Chain of Responsibility pattern to determine which subclass of Verb is appropriate for a given input
  * Specs verifying the above, including verifying that the input is INappropriate for all other subclasses 

Backlog:

  * Set the response output for each verb subclass
  * Design and implement the durable storage mechanism 
  * Tie in to Twilio 

Icebox:
  
  * Allow multiple users to access the same Sinatra instance
  * Graphical representation of data


