# Devise::Capturable

`Devise::Capturable` is a gem that makes it possible to use the Janrain Engage user registration widget, while preserving your Devise authentication setup with your custom user model.

## Flow

When using this gem, you'll replace the normal user registration and login form with the Janrain user registration widget. The login / registration flow will be as follows

* User clicks a login link
* User is presented with the user registration widget and either registers or logs in
* The gem intercepts the `onCaptureLoginSuccess` event from the widget, grabs the oauth code, and makes a `POST` request with the code to the `sessions_controller`
* The gem includes a strategy that will grab the oauth token in the `session_controller`, load the user data from the Capture API, and either create a new user or log in the user if the user exists. You can override the `set_capturable_params` method in your `User` model in order to set custom properties on your `User` model before saving. You can also disable the auto creation of users.

## Setup

You need to perform these steps to setup the gem with devise. First of all, add the gem to your `Gemfile`

```ruby
gem "devise-capturable"
```

Then in your `config/initializers/devise.rb` add the following settings, replacing them with your Capture data. The 

```ruby
Devise.setup do |config|
	config.capturable_endpoint = "YOURDATA"  
	config.capturable_client_id = "YOURDATA"
	config.capturable_client_secret = "YOURDATA"
	config.capturable_redirect_uri = "YOURDATA" THIS IS QUESTIONABLE. FIX BEFORE RELEASE. WHY OH WHY DO WE NEED IT IF WE'RE NOT USING IT?
end
```

Then add the JS....

By default this will expect your `User` model to have a `uuid:string` property to save the `uuid` of the Capture user.

## Overriding User Creation

TODO