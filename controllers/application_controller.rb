class ApplicationController < Sinatra::Base
  helpers ApplicationHelper
  set :views, File.expand_path('../../views', __FILE__)
  p File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)
  p File.expand_path('../../public', __FILE__)
  set :bind, '0.0.0.0'

  configure :production, :development do
    enable :logging
    set :session_secret, 'av3rys3cr3tk3y'
  end

  before do
    db = YAML.load_file(File.expand_path('./config/database.yml'))['development']
    ActiveRecord::Base.establish_connection db
  end

  get '/environment' do
    haml :set_mock_environment
  end

  post '/environment' do
    env = %w{integration quality production}
    supplied_env = params[:mock_environment].downcase
    if env.include? supplied_env
      ENV['TEST_ENV'] = supplied_env
      haml_info = {success: true, message: "Test environment set to #{supplied_env}"}
      haml :test_environment_ack, :locals => haml_info
    else
      haml_info = {success: false, message: "Test environment cannot be #{supplied_env} only #{env} supported."}
      haml :test_environment_ack, :locals => haml_info
    end
  end

  get "/*" do
    @title = "Mock Server in action"
    # Process the URL
    url = request.fullpath.sub!(/^\//, '')
    response = process_url(url, ENV['TEST_ENV'])
    if  response.has_key? :error
      haml :mock_response_test, :locals => {body: 'Not Found'}
    else
      haml :mock_response_test, :locals => {body: h(response[:mock_data_response])}
    end
  end
end

