require 'opal'
require 'opal-jquery'

desc "Build our app to app.js"

task :prep do
  File.binwrite "opal.js", Opal::Builder.build("opal").to_s
end

task :build do
  Opal.append_path "app"
  File.binwrite "app.js", Opal::Builder.build("app").to_s
end
