require 'sinatra'

get '/*' do
  content_type :json
  service = params[:splat].first
  scripts = Dir['scripts/**/*.rb']

  scripts
      .select {|script| script =~ /scripts\/#{service}.rb/}
      .map {|script| File.read(script)}
      .map {|file| eval(file)}
      .map {|result| return result}

  halt 404, "#{service} not found."
end