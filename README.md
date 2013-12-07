# Huh? #

This is a basic meta-framework for IRC bots. It wraps Cinch with some crap, so that it's pretty much plug and play.

# Let's Do This #

Put Ruby classes in lib. It expects them to be named a class version of the filename. I.e. with `derp.rb` we'd expect a class `Derp`. Each class needs an instance method `execute(m)`, where m is the IRC method. You can do whatever your heart desires in there. Yep, even that. The irc bot will respond to channel messages of "derp blah" with whatever execute does. Include a class method `self.description` if you want your class to included when you ask the bot for "help."

Look at `./lib/eightball.rb` for a very simple example of how to create your own class.

# To run #

    bundle install
    bundle exec ruby bot.rb
    
# To interact #

Let's say your bot's name is `joebot`. On IRC in `#yerchannel`, you say `joebot help`, and joebot will respond with a list of all the things you can do with the classes you've got in `./lib`.
