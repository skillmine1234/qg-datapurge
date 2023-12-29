class PurgingsController < ApplicationController

  #authorize_resource
  #before_filter :authenticate_user!
  #before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include Approval2::ControllerAdditions

  def purging_request
    prg_data = PgrRequest.new
    prg_data.table_name = params[:table_name]
    prg_data.to_date = params[:from_date]
    prg_data.created_by = current_user.id
    
    if params.has_key?(:deletion_period)
        prg_data.ns_day_cnt = params[:deletion_period]["return"]
    end  
     
    prg_data.save
    
    respond_to do |format|
      format.js   { render :js => "alert('Request Accepeted Successfully and is pending for approval');" }
    end

  end

  def purge_analytics
    @prg_audit = AuditPurge.all
  end  

end
