Realtime Twitter Bot
====================

A realtime bot for [twitter](http://twitter.com/)

Gem dependencies:
 * [xmpp4r/simple](http://code.google.com/p/xmpp4r-simple/)
 * [twitter](http://twitter.rubyforge.org/)
 * [simple-daemon](http://simple-daemon.rubyforge.org/)
 

Using the bot
-------------

Place a file in your $HOME: **bot.yml** with the format:
  `twitter_user: "account"`
  `twitter_pass: "password"`
  `jabber_acct: "jabber user (user@gmail.com works fine)"`
  `jabber_pass: "jabber/gmail password"`


Registering the jabber account with twitter
-------------------------------------------

**DO NOT SKIP THIS**

* visit http://twitter.com/devices
* add your jabber account
* use a jabber client (iChat, adium, etc), sign in to the account and verify the code twitter gives you
* if you'd like to handle direct messages, ask [al3x](http://twitter.com/al3x) to turn on *autofollow*


Contributors
------------

* Erik [Kastner](http://metaatem.net) &ltkastner@gmail.com&gt;
