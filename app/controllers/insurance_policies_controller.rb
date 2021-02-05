class InsurancePoliciesController < InheritedResources::Base

  private

    def insurance_policy_params
      params.require(:insurance_policy).permit(:name, :policy_number, :policy_type, :effective_date, :expiration_date, :premium_amount)
    end

end
