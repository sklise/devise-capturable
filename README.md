# Devise::Capturable

`Devise::Capturable` is a gem that makes it possible to use the Janrain Engage user registration widget, while preserving your Devise authentication setup with your custom user model.

## Flow

When using this gem, you'll replace the normal user registration and login form with the Janrain user registration widget. The login / registration flow will be as follows:

* User clicks a login link
* User is presented with the user registration widget and either registers or logs in
* The gem intercepts the `onCaptureLoginSuccess` event from the widget, grabs the oauth code, and constructs a form that makes a `POST` request with the code to the `sessions_controller`
* The gem includes a strategy that will grab the oauth token in the `session_controller`, load the user data from the Capture API (to ensure the validity of the token), and either create a new user or log in the user if the user exists.

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
end
```

Then add the JS and the CSS

```ruby
Show how to add JS and CSS here
``

By default this will only set the `email` property of your Capture user, but you can override a setter method in your model to grab extra data from Capture.

## Automatic Setting

The Janrain User Registration widget relies on a bunch of settings that are 1) never used and 2) breaks the widget if they are not there. To circumvent this madness, this gem will automatically set a bunch of janrain setting variables for you:

```javascript
// these settings will always be the same
janrain.settings.capture.flowName = 'signIn';
janrain.settings.capture.responseType = 'code';
janrain.settings.capture.setProfileCookie = false;
janrain.settings.capture.keepProfileCookieAfterLogout = false;
janrain.settings.language = 'en';

// these settings are never used but crashes the widget if not present
janrain.settings.capture.redirectUri = 'http://stupidsettings.com';
```

This means that you can delete these settings from your embed code.

## Overriding User Creation

TODO

## Stopping User Creation

TODO

## Example Application

