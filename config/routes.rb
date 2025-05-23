# == Route Map
#
#                            Prefix Verb   URI Pattern                                                 Controller#Action
#                                          /assets                                                     Propshaft::Server
#        message_generated_messages POST   /messages/:message_id/generated_messages(.:format)          generated_messages#create
#    edit_message_generated_message GET    /messages/:message_id/generated_messages/:id/edit(.:format) generated_messages#edit
#         message_generated_message PATCH  /messages/:message_id/generated_messages/:id(.:format)      generated_messages#update
#                                   PUT    /messages/:message_id/generated_messages/:id(.:format)      generated_messages#update
#                                   DELETE /messages/:message_id/generated_messages/:id(.:format)      generated_messages#destroy
#                          messages GET    /messages(.:format)                                         messages#index
#                                   POST   /messages(.:format)                                         messages#create
#                       new_message GET    /messages/new(.:format)                                     messages#new
#                      edit_message GET    /messages/:id/edit(.:format)                                messages#edit
#                           message GET    /messages/:id(.:format)                                     messages#show
#                                   PATCH  /messages/:id(.:format)                                     messages#update
#                                   PUT    /messages/:id(.:format)                                     messages#update
#                                   DELETE /messages/:id(.:format)                                     messages#destroy
#                         seed_home POST   /home/seed(.:format)                                        home#seed
#                              home GET    /home(.:format)                                             home#show
#                   test_root_rails GET    /test_root(.:format)                                        rails/welcome#index
#                rails_health_check GET    /up(.:format)                                               rails/health#show
#                              demo GET    /demo(.:format)                                             demos#show
#                              root GET    /                                                           messages#index
#  turbo_recede_historical_location GET    /recede_historical_location(.:format)                       turbo/native/navigation#recede
#  turbo_resume_historical_location GET    /resume_historical_location(.:format)                       turbo/native/navigation#resume
# turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                      turbo/native/navigation#refresh

Rails.application.routes.draw do
  resources :messages do
    resources :generated_messages, only: [:edit, :create, :update, :destroy]
  end

  resource :home, controller: :home, only: [:show] do
    post :seed
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  if Rails.env.local?
    # a test only route used by spec/features/it_works_spec.rb
    get "test_root", to: "rails/welcome#index", as: "test_root_rails"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resource :demo, only: [:show]

  # Defines the root path route ("/")
  # root "home#show"
  root "messages#index"
end
