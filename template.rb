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

LATEST_STABLE_RUBY = '2.3.0'
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
use_devise = ask_with_default_yes("Do you want to install Devise? [Y/n]")

if use_devise
  generate_devise_user  = ask_with_default_yes("Do you want to create a Devise User Class? [Y/n]")
  generate_devise_views = ask_with_default_yes("Do you want to generate Devise views? [Y/n]")
  use_active_admin  = ask_with_default_yes("Do you want to install Active Admin? [Y/n]")
end

use_roadie         = ask_with_default_yes("Do you want to install Roadie? [Y/n]")
use_paperclip      = ask_with_default_yes("Do you want to install Paperclip? [Y/n]")
use_vcr            = ask_with_default_yes("Do you want to install VCR? [Y/n]")
use_guard_rspec    = ask_with_default_yes("Do you want to install Guard-Rspec? [Y/n]")
switch_to_haml      = ask_with_default_yes("Do you want to use HAML instead of ERB? [Y/n]")
switch_to_bootstrap = ask_with_default_yes("Do you want to remove Bourbon/Neat and use Bootstrap? [Y/n]")
# switch_to_coffeescript = ask_with_default_yes("Do you want to remove EC6 and install CoffeeScript? [Y/n]")

create_tmuxinator_file = ask_with_default_no("Do you want to create a tmuxinator file? [y/N]")

######################################
#                                    #
# Gemfile manipulation               #
#                                    #
######################################

# Remove EC6 and put back CoffeeScript
# if switch_to_coffeescript
#   gsub_file('Gemfile', /^gem "sprockets"$/, '')
#   gsub_file('Gemfile', /^gem "sprockets-es6"$/, '')
#   gem "coffee-rails", "~> 4.1.0"
# end

gem 'devise'     if use_devise
gem 'haml-rails' if switch_to_haml

# Remove bourbon/neat/refills
if switch_to_bootstrap
  gsub_file('Gemfile', /^gem "bourbon, "5.0.0.beta.3"$/, '')
  gsub_file('Gemfile', /^gem "neat", "~> 1.7.0"$/, '')
  gsub_file('Gemfile', /^gem "refills"/, '')
  gem 'bootstrap-sass'
end

gem 'activeadmin', github: 'gregbell/active_admin' if use_active_admin
gem 'paperclip' if use_paperclip
gem 'roadie', '~> 2.4.3' if use_roadie

gem_group :development do
  gem 'mailcatcher', require: false
  gem 'html2haml', require: false if switch_to_haml
  gem 'guard-livereload', require: false
  gem 'brakeman', require: false
end

gem_group :development, :test do
  gem 'guard-rspec', require: false if use_guard_rspec
  gem 'faker'
end

gem_group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'email_spec'
  gem 'vcr' if use_vcr
end

######################################
#                                    #
# Gem installation                   #
#                                    #
######################################
run 'bundle install'

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
end if use_paperclip


insert_into_file ".gitignore", after: "/config/secrets.yml\n" do
<<-GITIGNORE

# Ignore dotenv files
.env.local
GITIGNORE
end

inside "app" do
  inside "assets" do
    inside "fonts" do
      create_file ".keep", ""
    end

    if switch_to_bootstrap
      inside "stylesheets" do
        remove_file "refills/_flashes.scss"
        remove_file "refills"
        remove_file "application.css"
        remove_file "application.scss"
        copy_file   "application.scss"
        copy_file   "_variables.scss"
        copy_file   "_bootstrap_variables_overrides.scss"
        create_file "_base.scss",   ""
        create_file "_layout.scss", ""
        create_file "_module.scss", ""
        create_file "_state.scss",  ""
        create_file "_theme.scss",  ""
        copy_file   "email.scss"
      end

      inside "javascripts" do
        insert_into_file 'application.js', "//= require bootstrap-sprockets\n", after: "//= require jquery_ujs\n"
      end
    end
  end

  inside "views" do
    inside 'application' do
      run "for file in *.erb; do html2haml -e $file ${file%erb}haml > /dev/null 2>&1 && rm $file; done" if switch_to_haml
    end

    inside "layouts" do
      if switch_to_haml
        run "html2haml -e application.html.erb application.html.haml > /dev/null 2>&1 && rm application.html.erb"
        copy_file "email.html.haml" if use_roadie
      else
        copy_file "email.html.erb" if use_roadie
      end
    end
  end
end

inside "config" do
  insert_into_file 'application.rb', after: "config.active_job.queue_adapter = :delayed_job\n" do
    <<-APP

    config.assets.precompile += %w( .svg .eot .woff .ttf email.css )
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    APP
  end

  inside "environments" do
    insert_into_file 'development.rb', after: "config.action_mailer.default_url_options = { host: \"localhost:3000\" }\n" do
      <<-DEV

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

#####################
# SECRET KEY CONFIG #
#####################

secret_key = SecureRandom.hex(64)
insert_into_file '.env',
                 "SECRET_KEY_BASE=#{secret_key}",
                 after: "WEB_CONCURRENCY=1\n"

######################################
#                                    #
# Running installed gems generators  #
#                                    #
######################################
if use_devise
  generate "devise:install"
  generate "devise user"  if generate_devise_user

  if generate_devise_views
    generate "devise:views"
    run "for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml > /dev/null 2>&1 && rm $file; done" if switch_to_haml
  end
end

generate "simple_form:install --bootstrap" if switch_to_bootstrap
generate "active_admin:install" if use_active_admin
run "bundle exec guard init livereload"
run "bundle exec guard init rspec" if use_guard_rspec

#################
# Devise config #
#################

if use_devise
  devise_secret = IO.readlines("config/initializers/devise.rb")[8].split(" = ")[1].gsub("'","")
  insert_into_file '.env',
                   "DEVISE_SECRET=#{devise_secret}",
                   after: "WEB_CONCURRENCY=1\n"
  insert_into_file 'config/secrets.yml',
                  "  devise_secret: <%= ENV[\"DEVISE_SECRET\"] %>\n",
                  after: "secret_key_base: <%= ENV[\"SECRET_KEY_BASE\"] %>\n"
  insert_into_file 'config/initializers/devise.rb',
                   "  config.secret_key = Rails.application.secrets.devise_secret\n",
                   before: "# ==> Mailer Configuration\n"
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

  insert_into_file "rails_helper.rb", after: "require \"rspec/rails\"\n" do
    text =  "require 'capybara/rails'\n"
    text << "require 'capybara/rspec'\n"
    text << "require 'capybara/email/rspec'\n"
    text << "require 'database_cleaner'\n"
    text << "require 'email_spec'\n"
    text << "require 'shoulda/matchers'\n"
    text << "require 'paperclip/matchers'\n" if use_paperclip
    text << "require 'vcr'\n" if use_vcr
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
  end if use_vcr

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

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

    RSPEC
  end

  insert_into_file "rails_helper.rb", after: "  config.include FactoryGirl::Syntax::Methods\n" do
    <<-RSPEC

  config.include Devise::TestHelpers, type: :controller
    RSPEC
  end if use_devise

  insert_into_file "rails_helper.rb", after: "config.include FactoryGirl::Syntax::Methods\n" do
    <<-RSPEC
  config.include Paperclip::Shoulda::Matchers
    RSPEC
  end if use_paperclip

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

say("\nWe have installed Active Admin. When you run your migrations, you'll have an AdminUser with:\n\tEmail: admin@example.com\n\tPassword: password\n\n", "\e[33m") if use_active_admin

create_database = ask_with_default_no("Do you want me to migrate the database for you? [y/N]")

if create_database
  run "bundle exec rake db:migrate"

  run "bundle exec rake spec"
  say("\nWhat you see above is the first failing test of the project. It fails because you have no routes defined, so the root_path is not visitable. This means everything is set and you can start working (perhaps in making this test pass).\n\n", "\e[33m")

end

if create_tmuxinator_file
  add_tmuxinator_file
  run "mkdir -p ~/.tmuxinator/"
  run "ln .#{app_name}.tmx.yml ~/.tmuxinator/#{app_name}.yml"
  gitignore_tmuxinator
end
