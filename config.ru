require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#required for PATCH and DELETE requests
use Rack::MethodOverride

#mount controllers here
use UsersController
run ApplicationController
