Shellmoji
=========

Shellmoji is a simple human-readable implementation of emojis in a command-line used to represent different icons that wouldn't appear in a shell otherwise.

![Shellmoji demo](https://i.imgur.com/euKCFlp.png)

Usage
-----

Temporarily, the configuration will be done manually, as I don't suggest using this for a daily system, it's not been fully tested.

To enable it, override your `ls` command with an alias, run this:

   alias ls='bash ~/shellmoji/aliases.sh'

You can also add it to your `~/.bashrc` file if you want it to last forever. Simply run this:

   echo "alias ls='bash ~/shellmoji/aliases.sh'" >> ~/.bashrc

Finally, simply run `ls` and you'll be up and running.

Resources
---------

 - [Emoji unicode table](https://apps.timwhitlock.info/emoji/tables/unicode)
 - [The classic test command](http://wiki.bash-hackers.org/commands/classictest)
 - [Array variables](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_02.html)
 - [Adding emojis on to a script not working](https://unix.stackexchange.com/questions/466961/adding-emojis-on-to-a-script-not-working?noredirect=1&lq=1)
