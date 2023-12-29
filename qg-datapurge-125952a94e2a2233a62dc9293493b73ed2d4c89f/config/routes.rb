Rails.application.routes.draw do
	
	resources :purgings do
		collection do 
			get 'purging_request'
			get 'purging_request_form'
			get 'purge_analytics'
		end
	end

	resources :pgr_requests
	get '/pgr_request/:id/approve' => "pgr_requests#approve"

end
