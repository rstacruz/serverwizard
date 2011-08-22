# ServerWizard
#### Bootstrap script generator

Requirements
------------

- **Ruby 1.9.2**
   - RVM: `rvm install 1.9.2`
   - Ubuntu: `sudo apt-get install ruby19`

Setup
-----

Install gems:

    bundle install

Start:

    rackup

Contributing new recipes
------------------------

Put new recipes in `data/recipes/`. The beginning block of it is a YAML description,
just follow how the other recipes are doing it.

If you need external files for your recipe, put them in `public/` and use the
`cat_file` helper in the Bash scripts to pull them out. See *nginx_passenger.sh* for
an example.

Acknowledgements
----------------

Inspired by Intridea's [RailsWizard.org](http://railswizard.org).

Authored and maintaned by [Rico Sta. Cruz](http://ricostacruz.com), sponsored by
[Sinefunc, Inc](http://sinefunc.com). Released under the MIT license.
