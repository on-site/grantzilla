[![Build Status](https://travis-ci.org/on-site/Grantzilla.svg?branch=master)](https://travis-ci.org/on-site/Grantzilla)

## Development Environment

Run `rake setup` to prepare the necessary environment variables to begin
development. After that, you will need to run `rvm use .` to load the
environment variables generated in `.ruby-env`.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/on-site/Grantzilla. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](CODE_OF_CONDUCT.md) code of conduct.

## License

This project is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

## Setup

```
sudo apt-get install -y postgresql-9.3 postgresql-client-common postgresql-client-common libmagickwand-dev imagemagick
# Change my_user_name and my_secret_password before running the next command
sudo su - postgres -c "psql -c 'CREATE USER my_user_name WITH PASSWORD '\''my_secret_password'\'''"
git clone https://github.com/on-site/Grantzilla.git
which rvm >> /dev/null || \curl -sSL https://get.rvm.io | bash -s stable
rvm install `cat Grantzilla/.ruby-version`
cd Grantzilla
gem install bundler
bundle
rake setup # When prompted, use the same username and password as in the CREATE USER command above
cd .
```
