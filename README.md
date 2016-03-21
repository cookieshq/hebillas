The Cookies HQ Rails App Template
=================================

On our projects we tend to use the same gems and configurations, this template is created to help us set up new projects faster.

Requirements
------------

1. Have **Ruby** installed. Preferabily `2.1.3`, but works with `2.0.0` also.
2. Have **Rails** installed. This template was created for and tested with version `4.1.6`.

How to use
----------

Assuming that you have Ruby and Rails installed, you'll need to checkout the repo:

```
git clone git@github.com:cookieshq/cookieshq-rails-template.git
```

And then run the rails app generator passing the template:

```
rails new app_name -m cookieshq-rails-template/template.rb
```

It will ask you if you want to install certain gems and install them for you, along with other ones. In the end, it will ask you if you want your database to be created and migrated.

What to do after
----------------

* Fix the first failing test that is created if you choose to create your database. It's basically about adding a root on your `routes.rb`.
* Init your git repo. Until we figure out how to perform actions after the binstub call is performed, we don't want to init a repo and do a first commit, then leave you with a dirty status repo. Hopefully we'll be able to fix it when Rails 4.2 is out. See [this](https://github.com/rails/rails/issues/16292) for details.


List of gems installed
----------------------

Does not include dependencies of the gems listed!

* [pg](https://github.com/ged/ruby-pg) to use PostgreSQL with Active Record
* [devise](https://github.com/plataformatec/devise) - optional
* [simple_form](https://github.com/plataformatec/simple_form)
* [haml-rails](https://github.com/indirect/haml-rails)
* [bootstrap-sass](https://github.com/twbs/bootstrap-sass)
* [airbrake](https://github.com/airbrake/airbrake) - optional
* [active_admin](https://github.com/activeadmin/activeadmin) - optional (available if you choose to install Devise)
* [paperclip](https://github.com/thoughtbot/paperclip) - optional
* [roadie 2.4.3](https://github.com/Mange/roadie/tree/2-4-stable)

On the **production** group:
* [rails_12factor](https://github.com/heroku/rails_12factor) - optional

On the **development** group:
* [capistrano](https://github.com/capistrano/capistrano) (*if you won't use Heroku*)
* [capistrano-rvm](https://github.com/capistrano/rvm) (*if you won't use Heroku*)
* [capistrano-bundler](https://github.com/capistrano/bundler) (*if you won't use Heroku*)
* [mailcatcher](https://github.com/sj26/mailcatcher) - not required
* [html2haml](https://github.com/haml/html2haml) - not required (needed to convert the devise views)
* [guard-livereload](https://github.com/guard/guard-livereload)
* [brakeman](https://github.com/presidentbeef/brakeman)

On the **test** and **development** groups:
* [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails)
* [faker](https://github.com/stympy/faker)
* [rspec](https://github.com/rspec/rspec)
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [guard-rspec](https://github.com/guard/guard-rspec) - optional
* [dotenv-rails](https://github.com/bkeepers/dotenv) - optional

On the **test** group:
* [capybara](https://github.com/jnicklas/capybara)
* [capybara-email](https://github.com/dockyard/capybara-email)
* [capybara-webkit](https://github.com/thoughtbot/capybara-webkit)
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner)
* [launchy](https://github.com/copiousfreetime/launchy)
* [email_spec](https://github.com/bmabey/email-spec/)
* [timecop](https://github.com/travisjeffery/timecop)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [formulaic](https://github.com/thoughtbot/formulaic)
* [webmock](https://github.com/bblimke/webmock)
* [vcr](https://github.com/vcr/vcr) - optional

### Also it:

* Sets your current ruby at the top of your `Gemfile`.
* Warns you if you are using an outdated version of Ruby.
* Generates a `.gitignore` file with some common files and folders that we add.
* Puts in a default skeleton for JS code organization, as per told in [this post](http://cookieshq.co.uk/posts/write-maintainable-javascript-in-rails/)
* Puts in an email template and style as per told in [this post](http://cookieshq.co.uk/posts/how-to-style-emails-with-rails-and-roadie/)
* Creates a stylesheet skeleton that is [SMAC compliant](https://smacss.com/book/categorizing).
* Edits `application.css(.scss)` and `application.js` to use `bootstrap`.
* Puts in an `layouts/application.html.erb` equivalent written in HAML with some nice additions (viewport, etc)
* Puts in the `database.yml` file adapted to PostgreSQL.
* Creates your `development` and `test` databases (optional)
* Edits `application.rb` to add rspec and action mailer config.
* Edits `development.rb` to add action mailer config.
* Does a basic configuration of RSpec.
* Creates a test and runs it (it will fail) to get your TDD/BDD on ;)
* If you won't use Heroku, capifies the project and uncomments the bundler, rvm, assets and migrations lines in `Capfile`.
* If you choose to, it will create a [tmuxinator](https://github.com/tmuxinator/tmuxinator) configuration file on the root of the project, add it to the gitignore and link it on the `~/tmuxinator/` folder. Keep in mind that it wont install the tmuxinator gem, nor tmux, for you.

Future improvements
====================

* Create a version that can be run from the raw link on github (i.e.: embedding all files on the template).
* Separate long strings into auxiliary methods, for the sake of code readability.
