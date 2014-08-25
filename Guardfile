# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :views do
  guard 'livereload' do
    watch(%r{app/views/.+\.(erb|haml|slim)$})
    watch(%r{app/helpers/.+\.rb})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
  end
end

guard 'rspec' do

  # Model files
  watch(%r{^models/(.+)\.rb$})                           { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^presenters/(.+)\.rb$})                           { |m| "spec/presenters/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})

end

