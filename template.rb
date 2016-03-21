#                          .-:::--:/sydmmmmmdhyo/:.`
#                      .+ydmmmmmmmmmdhso+++ooyhmmmmmdyyyso/:`
#                   .:smmds+:-.-:/-.           `.:/oyyyhddmmmho-
#               `/sdmmmd+`                                .:ohmmh+`
#             -sdmmy+:.                                       -sdmd/
#           `smmd+`                                             .ymmy`
#          :dmd+                                           -      /mmh`
#         :dmh.                                           smy      /mmy`
#        -dmh`           /o.                              /s:       +dmd:
#        ymm:           `dmo            `-.                          .hmms-
#       .mmh             .:           /ymmh                           `+dmms`
#      `smm+                          +mhs/                     `:      `+mmh`
#     /dmmo                                                     /o`       +mms
#   `smmy.                                                                 hmd`
#   ommo          ./osyhhyyo/.                        ./osyhhyso/.         hmd.
#  .dmh        .+hmmmmmmmmmmmmdo.                  .odmmmmmmmmmmmmh+.      ymm:
#  -mms      `odmmmho:-..-:+ymmmms`      ```     `smmmmy+:-..-:+ymmmdo`    :mmy
#  .mmh     .hmmms.          .ommmd-./shdmmmdhs/-hmmmo.          .smmmh.    smmo
#   ymm/   `hmmd:   .+yhhy+.   -dmmdmmmmmmmmmmmmmmmd-   -oyhhy+.   :dmmh`    ymm:
#  smmy-   +mmm/   +h/odmmmmo   :mmmmmho:---/odmmmm:   oy/smmmmd/   /mmm+    -mmh`
# ommo  `/+hmmd`  .ms`-dmmmmm:   dmmm/         dmmd   :m/`:mmmmmd.  `dmmh+/.  +mms
# hmm`  dmmmmmd`  .dmmmmmmmmm-   dmmh          hmmd`  :mmmmmmmmmd`  `dmmmmmd` `dmm
# smm:  :yyhmmm+   /dmmmmmmd+   :mmmo          ommm/   ommmmmmmd:   /mmmhyy/  -mmh
# .dmd+`    hmmd/   `/syys+.   :dmmh`          `hmmd:   .+syys/`   /dmmh`   `/dmd-
#  `smmh    `ymmmy-          .smmmh.            .hmmms-          -smmmh`   odmmy.
#   .mmy      +dmmmho/:---/ohmmmmd`              `ommmmho/---:/ohmmmd+    -dmh.
#   `dmd`      `+hmmmmmmmmmmmmhodmy.             -hmhhmmmmmmmmmmmmh+`    `ymm:
#    /mmy`        `:+syyyys+:.  `smds-        `:ymmo` .:+syyyys+:`       ommo
#     +mmh:                       -sdmdysoooshdmdo.                     +mmy
#      -ymmd/           .sss`        -/osyhyso/.                       +mmy`
#        -dmh            +hy:                                         `dmd`
#         smm/                                         `-`            +mmo
#         `hmd/                                        -o:           :dmh`
#          `ymmh/.                    `ymo                          +dmh.
#            -ymmmdy-                  `:.                        -ymmy`
#              `:odmdo`                                        `/ymmh:
#                 `odmdo-                              ``..:/ohmmmy:
#                   .odmmds/-`                   `-/oydmmmmmmdhs/`
#                      :ohdmmmmdddmmdhyyssssyyhdmmmmmdy+///:.`
#                         `-:++ooooosyhhhhhhhyyso+:-`
#
#
#
# The Cookies HQ Rails app template
#
# See README.md for details!

######################################
#                                    #
# Auxiliar methods & constants       #
#                                    #
######################################
require 'securerandom'

LATEST_STABLE_RUBY = '2.1.3'
CURRENT_RUBY = RUBY_VERSION

def source_paths
  Array(super) + [File.join(File.expand_path(File.dirname(__FILE__)),'files')]
end

def ask_with_default_yes(question)
  answer = ask question
  answer = ['n', 'N', 'no', 'No'].include?(answer) ? false : true
end

def ask_with_default_no(question)
  answer = ask question
  answer = ['y', 'Y', 'yes', 'Yes'].include?(answer) ? true : false
end

def outdated_ruby_version?
  LATEST_STABLE_RUBY.gsub('.', '').to_i > CURRENT_RUBY.gsub('.', '').to_i
end

def add_tmuxinator_file
  current_dir = Dir.pwd + '/'
  create_file ".#{app_name}.tmx.yml" do
    <<-TMUX
# ~/.tmuxinator/#{app_name}.yml

name: #{app_name}
root: #{current_dir}

# Optional tmux socket
# socket_name: foo

# Runs before everything. Use it to start daemons etc.
# pre: sudo /etc/rc.d/mysqld start

# Runs in each window and pane before window/pane specific commands. Useful for setting up interpreter versions.
# pre_window: rbenv shell 2.0.0-p247

# Pass command line options to tmux. Useful for specifying a different tmux.conf.
# tmux_options: -f ~/.tmux.mac.conf

# Change the command to call tmux.  This can be used by derivatives/wrappers like byobu.
# tmux_command: byobu

windows:
  - editor: vim
  - server: bundle exec rails s
  - console: bundle exec rails c
  - terminal:
    TMUX
  end
end

def gitignore_tmuxinator
  insert_into_file ".gitignore", after: "/config/secrets.yml\n" do
    <<-GITIGNORE

# Ignore Tmuxinator file
.#{app_name}.tmx.yml
    GITIGNORE
  end
end

######################################
#                                    #
# Prompt the user for options        #
#                                    #
######################################
install_devise = ask_with_default_yes("Do you want to install Devise? [Y/n]")

if install_devise
  generate_devise_user  = ask_with_default_yes("Do you want to create a Devise User Class? [Y/n]")
  generate_devise_views = ask_with_default_yes("Do you want to generate Devise views? [Y/n]")
  install_active_admin  = ask_with_default_yes("Do you want to install Active Admin? [Y/n]")
end

heroku_deploy = ask_with_default_yes("Do you need to deploy this app on Heroku? [Y/n]")

if heroku_deploy
  capistrano_deploy = false
else
  say("\n\tWe will install Capistrano for deployments, then.\n\n", "\e[33m")
  capistrano_deploy = true
end

install_paperclip   = ask_with_default_yes("Do you want to install Paperclip? [Y/n]")
install_airbrake    = ask_with_default_yes("Do you want to install Airbrake? [Y/n]")
install_vcr         = ask_with_default_yes("Do you want to install VCR? [Y/n]")
install_guard_rspec = ask_with_default_yes("Do you want to install Guard-Rspec? [Y/n]")
install_dotenv      = ask_with_default_yes("Do you want to install Dotenv [Y/n]")

######################################
#                                    #
# Gemfile manipulation               #
#                                    #
######################################

# Specify Ruby version
insert_into_file 'Gemfile', "\nruby '#{CURRENT_RUBY}'", after: "source 'https://rubygems.org'\n"

# Change sqlite3 for pg
gsub_file "Gemfile", /^# Use sqlite3 as the database for Active Record$/, "# Use Postgre as the database for Active Record"
gsub_file "Gemfile", /^gem\s+["']sqlite3["'].*$/, "gem 'pg'"

uncomment_lines "Gemfile", /capistrano-rails/ if capistrano_deploy

gem 'devise' if install_devise
gem 'rails_12factor', group: :production if heroku_deploy

gem 'haml-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'simple_form'
gem 'airbrake' if install_airbrake

gem 'activeadmin', github: 'gregbell/active_admin' if install_active_admin
gem 'paperclip' if install_paperclip
gem "roadie", '~> 2.4.3'

gem_group :development do
  if capistrano_deploy
    gem 'capistrano'
    gem 'capistrano-rvm'
    gem 'capistrano-bundler'
  end

  gem 'mailcatcher', require: false
  gem 'html2haml', require: false if generate_devise_views
  gem 'guard-livereload', require: false
  gem 'brakeman', require: false
end

gem_group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard-rspec', require: false if install_guard_rspec
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'dotenv-rails' if install_dotenv
end

gem_group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'email_spec'
  gem 'capybara-webkit'
  gem 'timecop'
  gem 'shoulda-matchers', require: false
  gem 'formulaic'
  gem 'webmock'
  gem 'vcr' if install_vcr
end

######################################
#                                    #
# Gem installation                   #
#                                    #
######################################
run 'bundle install'
run 'bundle exec cap install' if capistrano_deploy

######################################
#                                    #
# Modification and addition of files #
#                                    #
######################################
run "rm -rf test/"

#############
# Gitignore #
#############
remove_file ".gitignore"
create_file '.gitignore' do
  <<-GITIGNORE
# See https://help.github.com/articles/ignoring-files for more about ignoring files.
#
# If you find yourself ignoring temporary files generated by your text editor
# or operating system, you probably want to add a global ignore instead:
#   git config --global core.excludesfile '~/.gitignore_global'

# Ignore bundler config.
/.bundle

# Ignore all logfiles and tempfiles.
/log/*.log
/tmp

# Ignore database config
/config/database.yml

# Ignore DS_Store
.DS_Store

# Ignore secrets
/config/secrets.yml
  GITIGNORE
end

insert_into_file ".gitignore", after: "/config/secrets.yml\n" do
  <<-GITIGNORE

# Ignore Paperclip uploads
/public/system
  GITIGNORE
end if install_paperclip

if install_dotenv
  insert_into_file ".gitignore", after: "/config/secrets.yml\n" do
    <<-GITIGNORE

# Ignore dotenv files
.env
    GITIGNORE
  end

  create_file "env.yml.example" do
    <<-DOTENV
# Use dotenv to keep your environment variables safe and separated
# Read more at:
# https://github.com/bkeepers/dotenv/blob/master/README.md
# Remember to configure manually dotenv in your app!
# Once finished, remember to copy this file into a new one called just .env
    DOTENV
  end
end

if capistrano_deploy
  uncomment_lines 'Capfile', /'capistrano\/rvm'/
  uncomment_lines 'Capfile', /'capistrano\/bundler'/
  uncomment_lines 'Capfile', /capistrano\/rails\/assets/
  uncomment_lines 'Capfile', /capistrano\/rails\/migrations/
end

inside "app" do
  inside "assets" do
    inside "fonts" do
      create_file ".keep", ""
    end

    inside "stylesheets" do
      remove_file "application.css"
      copy_file   "application.css.scss"
      copy_file   "_variables.scss"
      copy_file   "_bootstrap_variables_overrides.scss"
      create_file "_base.css.scss",   ""
      create_file "_layout.css.scss", ""
      create_file "_module.css.scss", ""
      create_file "_state.css.scss",  ""
      create_file "_theme.css.scss",  ""
      copy_file   "email.css.scss"
    end

    inside "javascripts" do
      inside "main" do
        create_file "base.js.coffee", "@Main = {}"
      end
      create_file "main.js", "//= require ./main/base\n//= require_tree ./main\n"

      inside "shared" do
        create_file "base.js.coffee", "@Shared = {}"
        create_file "form.js.coffee", "@Shared.form = {}"
        create_file "util.js.coffee", "@Shared.util = {}"
      end
      create_file "shared.js", "//= require ./shared/base\n//= require_tree ./shared\n"

      insert_into_file 'application.js', after: "//= require turbolinks\n" do
        text = "//= require bootstrap-sprockets\n"
        text
      end
    end
  end

  inside "views" do
    inside "layouts" do
      remove_file "application.html.erb"
      copy_file "application.html.haml"
      copy_file "email.html.haml"
    end

    inside "shared" do
      template "_head.html.haml"
    end
  end
end

inside "config" do
  remove_file "database.yml"
  template "database.yml.example"
  run "cp database.yml.example database.yml"

  insert_into_file 'application.rb', after: "# config.i18n.default_locale = :de\n" do
    <<-APP
    config.generators do |g|
      g.test_framework :rspec,
       fixtures: true,
       view_specs: false,
       helper_specs: false,
       routing_specs:    false,
       controller_specs: true,
       request_specs:    true

      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.assets.precompile += %w( .svg .eot .woff .ttf email.css )
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    APP
  end

  inside "environments" do
    insert_into_file 'development.rb', after: "config.action_mailer.raise_delivery_errors = false\n" do
      <<-DEV
      # Action Mailer default options
      config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

      # Setup for Mailcatcher, if present
      if `which mailcatcher`.length > 0
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = { address: "localhost", port: 1025 }
      end

      # Specify locations for mails previews
      config.action_mailer.preview_path = "spec/mailers/previews"

      # Use email template for emails except on devise mails sent for admin users
      config.to_prepare do
        ActionMailer::Base.layout proc { |mailer|
          if mailer.is_a?(Devise::Mailer) && mailer.scope_name == :admin_user
            nil
          else
            "email"
          end
        }
      end

      DEV
    end
  end
end

######################################
#                                    #
# Running installed gems generators  #
#                                    #
######################################
if install_devise
  generate "devise:install"
  generate "devise user"  if generate_devise_user

  if generate_devise_views
    generate "devise:views"
    run "for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml > /dev/null 2>&1 && rm $file; done"
  end
end

generate "simple_form:install --bootstrap"
generate "active_admin:install" if install_active_admin
run "bundle exec guard init livereload"
run "bundle exec guard init rspec" if install_guard_rspec
generate "rspec:install"

#################
# Devise config #
#################

if install_devise
  devise_secret = IO.readlines("config/initializers/devise.rb")[6].split(" = ")[1].gsub("'","")
  insert_into_file 'config/secrets.yml',
                  "  devise_secret: #{devise_secret}",
                  after: "development:\n"
  insert_into_file 'config/secrets.yml',
                  "  devise_secret: #{SecureRandom.hex(64)}\n",
                  after: "test:\n"
  insert_into_file 'config/secrets.yml',
                  "  devise_secret: <%= ENV[\"DEVISE_SECRET\"] %>\n",
                  after: "production:\n"
  insert_into_file 'config/initializers/devise.rb',
                   "  config.secret_key = Rails.application.secrets.devise_secret\n",
                   after: "# confirmation, reset password and unlock tokens in the database.\n"
end


################
# Rspec Config #
################
inside "spec" do
  inside "acceptance" do
    create_file "routes_acceptance_spec.rb" do
      <<-TEST
require 'rails_helper'

feature "routes acceptance spec" do
  scenario "user visits root path" do
    visit root_path
    expect(page.status_code).to eql(200)
  end
end
      TEST
    end
  end

  comment_lines "rails_helper.rb", /config.fixture_path/

  insert_into_file "rails_helper.rb", after: "# Add additional requires below this line. Rails is not loaded until this point!\n" do
    text =  "require 'capybara/rails'\n"
    text << "require 'capybara/rspec'\n"
    text << "require 'capybara/email/rspec'\n"
    text << "require 'database_cleaner'\n"
    text << "require 'email_spec'\n"
    text << "require 'shoulda/matchers'\n"
    text << "require 'paperclip/matchers'\n" if install_paperclip
    text << "require 'webmock/rspec'\n"
    text << "require 'vcr'\n" if install_vcr
    text
  end

  insert_into_file "rails_helper.rb", after: "ActiveRecord::Migration.maintain_test_schema!\n" do
    <<-RSPEC

Capybara.javascript_driver = :webkit
Faker::Config.locale = :"en-gb"
    RSPEC
  end

  insert_into_file "rails_helper.rb", after: "ActiveRecord::Migration.maintain_test_schema!\n" do
    <<-RSPEC
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
    RSPEC
  end if install_vcr

  insert_into_file "rails_helper.rb", after: "RSpec.configure do |config|\n" do
    <<-RSPEC
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include Formulaic::Dsl, type: :feature
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

    RSPEC
  end

  insert_into_file "rails_helper.rb", after: "Rspec.configure do |config|\n" do
    <<-RSPEC
  config.include Devise::TestHelpers, type: :controller
    RSPEC
  end if install_devise

  insert_into_file "rails_helper.rb", after: "Rspec.configure do |config|\n" do
    "config.include Paperclip::Shoulda::Matchers"
  end if install_paperclip

  inside "mailers" do
    inside "previews" do
      create_file ".keep", ""
    end
  end
end

######################################
#                                    #
# Overriding default bundle install  #
#                                    #
######################################
def run_bundle ; end

######################################
#                                    #
# Initial commit of the app          #
#                                    #
######################################

# We remove this until we can get the after_bundler hook working on rails 4.2
# See: https://github.com/rails/rails/issues/16292
# git :init
# git add: "."
# git commit: "-a -m 'Initial commit'"

######################################
#                                    #
# Info for the user                  #
#                                    #
######################################

say("\nPlease note that you're using ruby #{CURRENT_RUBY}. Latest ruby version is #{LATEST_STABLE_RUBY}. Should you want to change it, please amend the Gemfile accordingly.\n", "\e[33m") if outdated_ruby_version?

say("\nWe have installed Heroku's rails_12factor gem for you. You'll still need to configure your Heroku account and create your app.\n", "\e[33m") if heroku_deploy

say("\nWe have installed Active Admin. When you run your migrations, you'll have an AdminUser with:\n\tEmail: admin@example.com\n\tPassword: password\n\n", "\e[33m") if install_active_admin

create_database = ask_with_default_no("Do you want me to create and migrate the database for you? [y/N]")

if create_database
  run "bundle exec rake db:create"
  run "bundle exec rake db:migrate"

  if install_airbrake
    airbrake_api_key = ask("\nEnter your airbrake API KEY to configure Airbrake: ")
    generate "airbrake --api-key #{airbrake_api_key}"
  end

  run "bundle exec rake spec"
  say("\nWhat you see above is the first failing test of the project. It fails because you have no routes defined, so the root_path is not visitable. This means everything is set and you can start working (perhaps in making this test pass).\n\n", "\e[33m")

else
  say("\nAirbrake gem has been installed, you'll need to create your databases and then run 'rails generate airbrake --api-key your_key_here' to set it up.\n\n", "\e[33m") if install_airbrake

end

create_tmuxinator_file = ask_with_default_no("Do you want to create a tmuxinator file? [y/N]")

if create_tmuxinator_file
  add_tmuxinator_file
  run "mkdir -p ~/.tmuxinator/"
  run "ln .#{app_name}.tmx.yml ~/.tmuxinator/#{app_name}.yml"
  gitignore_tmuxinator
end
