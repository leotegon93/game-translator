guard 'rspec', version: 2, cli: "--color --format nested --drb", all_after_pass: false  do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch(%r{^spec/fabricators/(.+)\.rb$})     
  watch(%r{^spec/factories/(.+)\.rb$})                { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
end