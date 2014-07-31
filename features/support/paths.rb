module NavigationHelpers
  
  # Extend the standard PathMatchers with your own paths
  # to be used in your features.
  # 
  # The keys and values here may be used in your standard web steps
  # Using:
  #
  #   When I go to the "rss_reader" admin page
  # 
  # would direct the request to the path you provide in the value:
  # 
  #   admin_rss_reader_path
  # 
  PathMatchers = {} unless defined?(PathMatchers)
  PathMatchers.merge!({
    # /rss_reader/i => 'admin_rss_reader_path'
  })
  
end

World(NavigationHelpers)