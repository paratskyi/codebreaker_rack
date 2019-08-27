# frozen_string_literal: true

require './lib/racker'

use Rack::Reloader, 0
use Rack::Static, urls: ['/assets'], root: 'public'
use Rack::Session::Cookie, key: 'rack.session',
                           domain: 'foo.com',
                           path: '/',
                           expire_after: 2_592_000,
                           secret: 'change_me',
                           old_secret: 'also_change_me'

run Racker
