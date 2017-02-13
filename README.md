# Groot
Groot is a simple gem to help you authenticate using [JWT](https://github.com/jwt/ruby-jwt).
## Installation

Add it to your Gemfile:

```ruby
gem 'groot'
```

Run the following command to install it:
```console
bundle install
```

Run the generator:
```console
rails generate groot:install
```

## Usage
In the following command you should replace MODEL with your user application class
```console
rails generate groot:auth MODEL
```
Take a look at the MODEL and if you want, you can add any additional configuration to it.
Add the following line to your routes.rb file (assuming your model is 'Admin'):
```console
    auth_for :admins 
```
It will create the routes to Groot controllers.


### Filter and Helpers
Groot will create a filter for user authentication, to configure it just add the following line to your controller: (assuming again that your model is Admin):

```ruby
before_action :authenticate_admin!
```
Groot will also create some helpers to make your life easier.

To get the current signed-in user:
```ruby
current_admin
```
To verify if there is a user signed in:
```ruby
admin_signed_in?
```
## ORMs
So far Groot only supports ActiveRecord.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/alissonbrunosa/groot.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
