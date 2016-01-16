# InSpecMultiServer

Command line tool to run chef inspec tests on multiple unix servers. This gem writes a config to the home directory with support for multiple projects, stages and servers per project.

**Note**: There is currently no support for windows. The current version only works via ssh protocol.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inspec-multi-server'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inspec-multi-server

## Example Config

Example config:

```json
{
  "cookbook-name": {
    "development": {
      "path": "/path/to/cookbook",
      "servers": [
        {
          "user": "username",
          "publickey": "~/.ssh/id_rsa",
          "host": "localhost"

        },
        {
          "user": "username",
          "publickey": "~/.ssh/id_rsa",
          "host": "localhost1"
        }
      ]
    }
  }
}

```

## Usage

**Note**: You may need to run rbenv rehash to make the command available. Check your path if the command is not available.

To run the inspec-multi-server command line tool do the following:

Run inspec-multi-server to create example config:
```ruby
  $ inspec-multi-server
```

Update ~/.inspec-multi-server with your settings:
```bash
  $ vim ~/.inspec-multi-server
```

Run help:
```ruby
  $ inspec-multi-server --help
  NAME
      inspec-multi-server - command line tool for inspec to run inspec tests on multiple servers.

  SYNOPSIS
      inspec-multi-server [global options] command [command options] [arguments...]

  VERSION
      0.0.4

  GLOBAL OPTIONS
      --help             - Show this message
      -v, --[no-]verbose - Show additional output.
      --version          - Display the program version

  COMMANDS
      help - Shows a list of commands or help for one command
      run  - Run inspec
```

Run help on run command:
```ruby
  $ inspec-multi-server run --help
  NAME
      run - Run inspec

  SYNOPSIS
      inspec-multi-server [global options] run [command options]

  DESCRIPTION
      Run inspec on multiple servers.

  COMMAND OPTIONS
      --project=arg - project (default: cme-eventhub-core)
      --stage=arg   - stage (default: development)
      --test=arg    - test (default: all)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/inSpecMultiServer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
