Apipie.configure do |config|
  config.app_name                = "Friends Management"
  config.app_info                = "Simple friend management API"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.validate                = false
  config.namespaced_resources    = true
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
