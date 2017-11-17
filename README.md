# Friends Management simple API

"Friends Management" is a common requirement which ussually starts off simple but can grow in complexity depending on the application's use case.
Things you may want to cover:

## Tools
Tool | Description
--- | ---
**[Rails 5.1.2](http://api.rubyonrails.org/)** | Ruby on Rails API
**[Ruby 2.4.1](https://ruby-doc.org/core-2.4.1/)** | Ruby
**[Rspec](https://github.com/rspec/rspec-rails)** | Testing tool
**[PostgreSQL](https://www.postgresql.org/)** | Database
**[Apipie](https://github.com/Apipie/apipie-rails)** | API documentation (customized)

### Installation

How to [Install Rails](http://installrails.com/)

```sh
$ git clone git@github.com:emheri/friends-management.git
$ cd friends-management
$ bundle install
$ rake db:create && rake db:migrate
$ rails s
```

### Run Unit Testing

```sh
$ cd friends-management
$ bundle exec rspec spec/
```

[API documentations](https://arcane-shelf-95028.herokuapp.com/apipie)