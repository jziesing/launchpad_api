class ClaimsController < InheritedResources::Base

  private

    def claim_params
      params.require(:claim).permit(:claim_number, :initiation_date, :amount, :approved_amount, :claim_reason)
    end

end
