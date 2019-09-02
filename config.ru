# frozen_string_literal: true

require './lib/codebreaker_web'

use Rack::Reloader, 0
use Rack::Static, urls: ['/assets'], root: 'public'
use Rack::Session::Pool

run CodebreakerWeb
