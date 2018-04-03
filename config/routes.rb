Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  post 'news', to: 'news#create'
  get 'news', to: 'news#index'
  get 'news/:id', to: 'news#show'
  delete 'news/:id', to: 'news#destroy'
  put 'news/:id', to: 'news#update'
  patch 'news/:id', to: 'news#update'

  post 'news/:new_id/comments', to: 'comments#create'
  get 'news/:news_id/comments', to: 'news#comments'
  get 'news/:new_id/comments/:id', to: 'comments#show_comment'
  delete 'news/:new_id/comments/:id', to: 'comments#destroy_comment'
  put 'news/:new_id/comments/:id', to: 'comments#update_comment'
  patch 'news/:new_id/comments/:id', to: 'comments#update_comment'
end
