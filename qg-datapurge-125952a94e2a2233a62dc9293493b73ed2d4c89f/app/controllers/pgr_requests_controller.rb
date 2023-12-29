class PgrRequestsController < ApplicationController
	
  #authorize_resource
  #before_filter :authenticate_user!
  #before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

  include Approval2::ControllerAdditions

	def index
		@purge_request = (params[:approval_status].present? and params[:approval_status] == 'U') ? PgrRequest.unscoped.where("approval_status =?",'U').order("id desc") : PgrRequest.order("id desc")
		@purge_request = @purge_request.paginate(:per_page => 10, :page => params[:page]) rescue []
	end

	 def show
  	  @purge_data = PgrRequest.unscoped.find(params[:id])
  	end

  	def approve
  		purge_data = PgrRequest.find(params[:id])
  		purge_data.updated_by = current_user.id
  		purge_data.save

		begin
			if purge_data.table_name == "FUNDS_TRANSFERS"
				plsql.purge_tables_ft2(purge_data.table_name,purge_data.to_date.to_date.strftime("%d-%m-%Y"),current_user.username)
			elsif purge_data.table_name == "INWARD_REMITTANCES"
				plsql.purge_tables_inw(purge_data.table_name,purge_data.to_date.to_date.strftime("%d-%m-%Y"),current_user.username)
			elsif purge_data.table_name == "ECOL_TRANSACTIONS"
				plsql.purge_tables_ecol(purge_data.table_name,purge_data.to_date.to_date.strftime("%d-%m-%Y"),current_user.username)
			elsif purge_data.table_name == "NS_PENDING_NOTIFICATION"
				ActiveRecord::Base.connection.execute("delete ns_pending_notifications where created_at < sysdate - #{purge_data.ns_day_cnt}")	
			end
		rescue Exception => e
			puts "data purge procedure call error #{e}"
		end

		redirect_to '/pgr_requests'
  	end

  	private

    def pgr_request_params
      params.require(:pgr_request).permit(:table_name,:to_date,:lock_version, :approval_status, :last_action, :approved_version, 
                                   :approved_id, :created_by, :updated_by)
    end
end
