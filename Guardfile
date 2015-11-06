coffeescript_options = {
  input:    '.',
  patterns: [/^(.+\.coffee)/]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end
