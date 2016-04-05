coffeescript_options = {
  input:    '.',
  patterns: [/\A(.+\.coffee)\z/]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end
