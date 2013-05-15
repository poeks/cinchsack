# Huh? #

This is a basic meta-framework for IRC bots. It wraps Cinch with some crap, so that it's pretty much plug and play.

# Let's Do This #

Put Ruby classes in lib. It expects them to be named a class version of the filename. I.e. with derp.rb we'd expect a class Derp. Each class needs an instance method execute(m), where m is the IRC method. You can do whatever your heart desires in there. Yep, even that. The irc bot will respond to channel messages of "derp blah" with whatever execute does. Include a class method description if you want your class to included when you ask the bot for "help."

# To run #

    bundle install
    bundle exec ruby bot.rb