# Devise::Capturable

`Devise::Capturable` is a gem that makes it possible to use the Janrain Engage user registration widget, while preserving your Devise authentication setup with your custom user model.

## Flow

When using this gem, you'll replace the normal user registration and login form with the Janrain user registration widget. The login / registration flow will be as follows

* User clicks a login link
* User is presented with user registration widget and either registers or logs in
* The gem intercepts the `onCaptureLoginSuccess` event from the widget, grabs the oauth code, and makes a `POST` request with the code to the `sessions_controller`
* The gem includes a strategy that will grab the oauth token in the `session_controller`, load the user data from the Capture API, and either create a new user or log in the user if the user exists.

## Setup

You need to perform these steps to setup the gem with devise. 



How to use out of the box

How to overwrite finder and setter

Remember to set the redirect_uri