Rails.application.routes.draw do
  mount Qg::DataPurge::Engine => "/qg-data_purge"
end
