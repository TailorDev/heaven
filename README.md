Heaven
======

[![Build
Status](https://travis-ci.org/TailorDev/heaven.svg?branch=tailordev)](https://travis-ci.org/TailorDev/heaven)

Heaven is an API that integrates with GitHub's [Deployment API][1]. It receives
[deployment events][2] from GitHub and pushes code to our servers. This is a
fork of [atmos/heaven](https://github.com/atmos/heaven) that is tweaked for
[TailorDev](http://tailordev.fr) needs.

Documentation
-------------

* [Overview](/doc/overview.md)
* [Installation](/doc/installation.md)
* [Deployment Providers](/doc/providers.md)
* [Deployment Notifications](/doc/notifications.md)
* [Environment Locking](/doc/locking.md)

Launch on Heroku
----------------

[![Launch on
Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)


[1]: http://developer.github.com/v3/repos/deployments/
[2]: https://developer.github.com/v3/repos/deployments/#create-a-deployment
