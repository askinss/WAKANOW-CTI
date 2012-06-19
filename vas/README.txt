Documentation on Vas2

Vas2 is CTI (computer telephony integration), which integrates Switchvox an IP based PABX into SugarCRM.

How it works:
When a call is coming into Switchvox, it initiates a pop-up on the SugarCRM interface displaying the details of the caller and an hyperlink to the caller's information if one exists else it displays an hyperlink to create details for the contact. An interface is also embedded into SugarCRM that allows the agent (SugarCRM client) initiate a call from the web-interface.


How to configure Vas2:

For first time users:

Requirements:
Ruby 1.9.2
Rubygems
Rails 3.0.9
Mysql (and its ruby dependencies)
Jquery

Untar the folder, from the root path run bundle install (this would install all the required gems).

Open the config directory and edit the database.yml file to suit your db parameters, edit the sugar.yml file and include the configuration of your sugarcrm server, edit the switchvox.yml file to include the switchvox server settings.

Return the root path and run:
rake db:migrate
rackup config.ru -s thin -E production
rails s

On the client side, edit the js file to include the settings of the server.
And you are good to go

For subsequent use:

From the root path run:
rackup faye.ru
rails s thin
And you are good to go.


                                                                                     Bjhaid
