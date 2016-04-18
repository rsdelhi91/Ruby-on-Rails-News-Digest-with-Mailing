# README #

### What is this repository for? ###

* This repository is used for developing project 3 of **SWEN30006**
* Ruby -v = "**2.2.0p0** (2014-12-15 revision 49005)" 
* Rails v = "**4.2.3**" 

### How do I get set up? ###

+ Summary of set up
    * This is a ruby on rails web application that delivers the latest news.
    + Run the following code to set up the application and start the server
        * `bundle install`
        * `rake db:create`
        * `rake db:migrate`
        * `rails s`
+ Configuration
    * routes configurations are listed below

      Prefix | Verb  |URI Pattern                 |Controller#Action
------------:| :---- |:---------------------------|:----------------
        root | GET   |/                           |sessions#unauth
       login | GET   |/sessions/unauth(.:format)  |sessions#unauth
      signin | POST  |/sessions/login(.:format)   |sessions#login
      logout | DELETE|/sessions/logout(.:format)  |sessions#logout
admin_scrape | GET   |/admin/scrape(.:format)     |articles#fetch
 admin_email | GET   |/admin/email(.:format)      |articles#email
       users | POST  |/users(.:format)            |users#create
    new_user | GET   |/users/new(.:format)        |users#new
   edit_user | GET   |/users/:id/edit(.:format)   |users#edit
        user | PATCH |/users/:id(.:format)        |users#update
             | PUT   |/users/:id(.:format)        |users#update
             | DELETE|/users/:id(.:format)        |users#destroy
    articles | GET   |/articles(.:format)         |articles#index
             | POST  |/articles(.:format)         |articles#create
 new_article | GET   |/articles/new(.:format)     |articles#new
edit_article | GET   |/articles/:id/edit(.:format)|articles#edit
     article | GET   |/articles/:id(.:format)     |articles#show
             | PATCH |/articles/:id(.:format)     |articles#update
             | PUT   |/articles/:id(.:format)     |articles#update
             | DELETE|/articles/:id(.:format)     |articles#destroy
   interests | GET   |/interests(.:format)        |articles#my_interests


+ Dependencies
    * See GemFile
+ Database configuration
    * Run `rake db:seed` will provide a test user. (username: **sxue1**; password: **1234**)
+ Deployment instructions
    * Run `brew install ruby` or `sudo apt-get install ruby-full` to get the latest version of ruby *(For Mac OSX and Linux)*
    * Run `gem update rails` to install the latest version of rails

### Who do I talk to? ###

* Repo admin: Song Xue ** (sxue1@student.unimelb.edu.au; 667692) **
+ Other team contact: 
    * Yumeng Shi ** (yumengs2@student.unimelb.edu.au; 664891) **
    * Rahul Sharma ** (sharma1@student.unimelb.edu.au; 706453) **