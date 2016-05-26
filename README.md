# Funky

Under the hood, Funky hits Facebook's APIs on some cases, while other cases it will scrape Facebook's HTML to get the data. It's kind of... funky.

A lot of data that are made public on Facebook's various posts are strangely not available from Facebook's Graph API without very specific permissions. For example, even though the number of shares and views are shown publicly in the web page, the Graph API will not return those results unless the user has insight permissions for that video. Funky can get around that limitation by scraping HTML. While where possible, it will use Facebook's Graph API.

## Usage

This is still a very early version, and it currently can only retrieve certain Facebook video data.

### Use #where clause to get an array of videos

```ruby
ids = ['10154439119663508', '10153834590672139']
videos = Funky::Video.where(id: ids)
videos.first.id            # => '10154439119663508'
videos.first.created_time  # => #<DateTime: 2015-12-17T06:29:48+00:00>
videos.first.description   # => "Hugh Jackman coaches Great Britain's..."
videos.first.length        # => 147.05
videos.first.picture       # => "https://scontent.xx.fbcdn.net/v/..."

```

If a non-existing video ID is passed into the where clause, it is ignored. Other video IDs will still be retrieved.

```ruby
ids = ['10154439119663508', '10153834590672139', 'doesnotexist']
videos = Funky::Video.where(id: ids)
videos.count    # => 2
videos.first.id # => '10154439119663508'
videos.last.id  # => '10153834590672139'
```

### Use #find to get a single video

```ruby
video = Funky::Video.find('10154439119663508')
video.id            # => '10154439119663508'
video.like_count    # => 1169
video.comment_count # => 65
video.share_count   # => 348
video.view_count    # => 10121
```

If a non-existing video ID is passed into #find, Funky::ContentNotFound will be raised.

```ruby
Funky::Video.find('doesnotexist') # => raises Funky::ContentNotFound
```

### Connection error

Should there be a case where Funky is unable to connect to facebook, `Funky::ConnectionError` will be raised.

```ruby
# Given funky is unable to establish a connection to facebook
Funky::Video.find('10154439119663508') # => raises Funky::ConnectionError
Funky::Video.where(id: '10154439119663508') # => raises Funky::ConnectionError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fullscreen/funky. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

