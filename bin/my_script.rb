require 'addressable/uri'
require 'rest-client'

# bin/my_script.rb


def get_all_users
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users'
  ).to_s
  
  puts RestClient.get(url)
end

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s
  
  puts RestClient.post(
    url,
    { user: { name: "Gizmo", email: "gizmo@gmail.com"} }
  )
end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/3.json'
  ).to_s
  
  puts RestClient.patch(
    url,
    { user: { name: "Gizmo", email: "gizmo@random.com"} }
  )
end

def destroy_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/3.json'
  ).to_s
  
  puts RestClient.delete(
    url
  )
end

create_user