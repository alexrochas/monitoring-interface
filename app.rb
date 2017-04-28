require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

get '/*' do
  content_type :json
  service = params[:splat].first
  scripts = Dir['scripts/**/*.rb']

  begin
    scripts
        .select {|script| script =~ /scripts\/#{service}.rb/}
        .tap {|stream| raise 'No service found' if stream.empty?}
        .map {|script| File.read(script)}
        .map {|file| eval(file)}
        .map {|result| result}
  rescue
    halt 404, JSON.generate({:error => {:message => "#{service} error."}})
  end
end