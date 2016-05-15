def some_app_port
  8080
end

def some_app_url(path = '')
  "http://localhost:#{some_app_port}#{path}"
end