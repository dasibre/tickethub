Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 controller :foo do
    get 'blog/show' => :list
  end
end


#resource :profile
# method  | action  | controller | path helper | uri
# get     | show    | profile    |


# resources :photos routes                                http://localhost:3000
# method   | action | controller | path helper  | url
#   get    | index  | photos     | photos_path  | /photos
#   get    | new    | photos     | new_photo    | /photos/new
#   post   | create | photos     | photos_path  | /photos
#   get    | edit   | photos     | edit_photo   | /photo/1/edit/
#   put    | update | photos     | photo_path   | /photo/1/ (applies to update#put|patch,show#get,destroy#delete actions#http-methods)