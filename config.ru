# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Orientation::Application

# Action Cable uses EventMachine which requires that all classes are loaded in advance
Rails.application.eager_load!
