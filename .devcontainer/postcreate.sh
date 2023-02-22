#!/bin/bash

bundle config set path /workspaces/$1/vendor/cache
bundle install --jobs=1
bundle exec jekyll serve -w --safe --host localhost --port 3000 --drafts --future
