HEBILLAS: The Cookies HQ Rails App Template Redux
=================================================

On our projects we tend to use the same gems and configurations, this template is created to help us set up new projects faster.

Requirements
------------

This template is based to work on top of [Thoughtbot's Suspenders](https://github.com/thoughtbot/suspenders) (v1.37).

How to use
----------

Assuming that you have Suspenders installed, you'll need to checkout the repo:

```
git clone git@github.com:cookieshq/hebillas.git
```

And then run suspenders, passing the template:

```
suspenders app_name -m hebillas/template.rb
```

It will ask you if you want to install certain gems and install them for you, along with other goodies. In the end, it will ask you if you want your database to be migrated.

What to do after
----------------

* Fix the first failing test that is created if you choose to create your database. It's basically about adding a root on your `routes.rb`.
* Init your git repo. Until we figure out how to perform actions after the binstub call is performed, we don't want to init a repo and do a first commit, then leave you with a dirty status repo. Hopefully we'll be able to fix it when Rails 4.2 is out. See [this](https://github.com/rails/rails/issues/16292) for details.

List of gems installed
----------------------

Does not include dependencies of the gems listed!

* [pg](https://github.com/ged/ruby-pg) to use PostgreSQL with Active Record
* [devise](https://github.com/plataformatec/devise) - optional
* [haml-rails](https://github.com/indirect/haml-rails) - we'll convert all .erb files to .haml while generating the application
* [bootstrap-sass](https://github.com/twbs/bootstrap-sass) - we'll remove bourbon, neat, refills and associated files.
* [active_admin](https://github.com/activeadmin/activeadmin) - optional (available if you choose to install Devise)
* [paperclip](https://github.com/thoughtbot/paperclip) - optional
* [roadie 2.4.3](https://github.com/Mange/roadie/tree/2-4-stable)

On the **development** group:
* [mailcatcher](https://github.com/sj26/mailcatcher) - not required
* [html2haml](https://github.com/haml/html2haml) - not required (needed to convert the devise views)
* [guard-livereload](https://github.com/guard/guard-livereload)
* [brakeman](https://github.com/presidentbeef/brakeman)

On the **test** and **development** groups:
* [faker](https://github.com/stympy/faker)
* [guard-rspec](https://github.com/guard/guard-rspec) - optional

On the **test** group:
* [capybara](https://github.com/jnicklas/capybara)
* [capybara-email](https://github.com/dockyard/capybara-email)
* [capybara-webkit](https://github.com/thoughtbot/capybara-webkit)
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner)
* [launchy](https://github.com/copiousfreetime/launchy)
* [email_spec](https://github.com/bmabey/email-spec/)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [formulaic](https://github.com/thoughtbot/formulaic)
* [webmock](https://github.com/bblimke/webmock)
* [vcr](https://github.com/vcr/vcr) - optional

### Also it:

* Generates a `.gitignore` file with some common files and folders that we add.
* Puts in a default skeleton for JS code organization, as per told in [this post](http://cookieshq.co.uk/posts/write-maintainable-javascript-in-rails/)
* Puts in an email template and style as per told in [this post](http://cookieshq.co.uk/posts/how-to-style-emails-with-rails-and-roadie/)
* Creates a stylesheet skeleton that is [SMAC compliant](https://smacss.com/book/categorizing).
* Edits `application.css(.scss)` and `application.js` to use `bootstrap`.
* Edits `application.rb` to add rspec and action mailer config.
* Edits `development.rb` to add action mailer config.
* Does a basic configuration of RSpec.
* Creates a test and runs it (it will fail) to get your TDD/BDD on ;)
* If you choose to, it will create a [tmuxinator](https://github.com/tmuxinator/tmuxinator) configuration file on the root of the project, add it to the gitignore and link it on the `~/tmuxinator/` folder. Keep in mind that it wont install the tmuxinator gem, nor tmux, for you.

Future improvements
====================

* Give user choice to remove EC6 and use CoffeeScript.
* Give user choice to use Bugsnag or Airbrake (or none).
* Give user choice to user letter_opener instead of mailcatcher (or none).
* Check Heroku option on suspenders and get in additional options if needed/available.
* Create a version that can be run from the raw link on github (i.e.: embedding all files on the template).
* Separate long strings into auxiliary methods, for the sake of code readability.
