# Latest [![Build Status](https://secure.travis-ci.org/citrus/latest.png)](http://travis-ci.org/citrus/latest)

### Latest keeps us up to speed by querying rubygems.org for a gem's most recent version number. Yep, that's all it does.

Basically I was tired of visiting `https://rubygems.org/gems/whatever-gem` to find out a gem's most recent version number.


------------------------------------------------------------------------------
Usage
------------------------------------------------------------------------------

After installing, use latest from your command line like so:


```bash
latest rails
# rails 3.2.1

latest rails spree haml
# rails 3.2.1
# spree 1.0.0
# haml 3.1.4
```


------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

As usual, just use the `gem install` command:

```bash
gem install latest
# or
sudo gem install latest
```


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

Testing is done with minitest. Run the tests with:

```bash
bundle exec rake
```


------------------------------------------------------------------------------
Requirements
------------------------------------------------------------------------------

Other than rake and bundler for development, Latest has zero gem dependencies! All it requires is Ruby >= 1.9.2.


------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2011 - 2012 Spencer Steffen & Citrus, released under the New BSD License All rights reserved.
