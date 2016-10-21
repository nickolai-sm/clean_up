# CleanUp

Move and copy files and directories to appointed directories according defined conditions.

## Installation

    $ gem install cleanup

## Usage

Write configuration file with rules `rules.rb` and place it in current folder or in your home folder and run:

    $ cleanup
    
Also you can specify path to config file:

    $ cleanup -c path/to/config/rules.rb
    
## Config Example
Example of rules.rb:

```` ruby

CleanUp.define do
  move do
    source '~/Downloads'
    target '~/'

    file do
      extension 'mp3'
      dir 'Music'
    end

    file do
      extension 'avi', 'mov'
      dir 'Movies'
    end

    file do
      pattern 'report_'
      dir 'Documents/Reports'
    end

    file do
      extension 'torrent'
      dir '.Trash'
    end
  end
end

````


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nickolai-sm/clean_up.

