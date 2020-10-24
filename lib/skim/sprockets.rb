require "sprockets"

if Sprockets::VERSION.start_with?('3')
  Sprockets.register_engine ".skim", Skim::Template
else
  if Sprockets.respond_to?(:register_transformer)
    Sprockets.register_mime_type 'text/skim', extensions: ['.skim', '.jst.skim'], charset: :unicode
    Sprockets.register_transformer 'text/skim', 'application/javascript+function', Skim::Template
  elsif Sprockets.respond_to?(:register_engine)
    args = ['.skim', Skim::Template]
    args << { mime_type: 'application/javascript', silence_deprecation: true }
    Sprockets.register_engine(*args)
  end
end


unless defined?(Rails::Engine)
  Sprockets.append_path File.expand_path('../../../vendor/assets/javascripts', __FILE__)
end
