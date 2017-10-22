begin
  require 'bundler/inline'
rescue LoadError => e
  $stderr.puts 'Bundler version 1.10 or later is required. Please update your Bundler'
  raise e
end

gemfile(true) do
  source 'https://rubygems.org'
  gem 'rails', '5.0.1'
  gem 'pry'
  gem 'sqlite3'
  gem 'rb-readline'
end

require 'action_controller/railtie'
require 'active_record'
require 'minitest/autorun'
require 'logger'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :todos, force: true do |t|
    t.string :content
  end
end

class Todo < ActiveRecord::Base
  alias_attribute :content_html, :content
  validates_presence_of :content
end

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
  config.session_store :cookie_store, key: 'cookie_store_key'
  secrets.secret_token = 'secret_token'
  secrets.secret_key_base = 'secret_key_base'

  config.logger = Logger.new($stdout)
  Rails.logger = config.logger

  routes.draw do
    resources :todos
    resources :wrapped_todos
  end
end

ActionController::Base.wrap_parameters format: [:json]

class TodosController < ActionController::Base
  include Rails.application.routes.url_helpers

  def create
    Todo.create!(params.require(:todo).permit(:content, :content_html))
    render plain: 'It worked?'
  end
end

class WrappedTodosController < ActionController::Base
  wrap_parameters :todo, include: %i( content_html )

  def create
    Todo.create!(params.require(:todo).permit(:content, :content_html))
    render plain: 'It worked?'
  end
end

require 'minitest/autorun'
require 'rack/test'

class BugTest < Minitest::Test
  include Rack::Test::Methods

  def test_wrapping_listed_attribute
    post '/todos.json', {content: '<b>Please clap</b>'}.to_json, {'CONTENT_TYPE' => 'application/json'}
    assert last_response.ok?, 'Wrapping did not work with attribute on model'
  end

  def test_explicitly_wrapping_unlisted_attribute
    post '/wrapped_todos.json', {content_html: '<b>Please clap</b>'}.to_json, {'CONTENT_TYPE' => 'application/json'}
    Pry.start
    assert last_response.ok?, 'Wrapping works when given explicitly with include option'
  end

  private
  def app
    Rails.application
  end
end