class ApprovedAccountsController < ApplicationController

    def index
      @approved_accounts = ApprovedAccount.all
    end

    def create
      approved_account = ApprovedAccount.create(approved_account_params)
      redirect_to '/member_portal/add_members'
    end

    def destroy
      approved_account = ApprovedAccount.find(params[:id])
      approved_account.destroy
      redirect_to '/member_portal/add_members'
    end

    private
    def approved_account_params
      params.require(:approved_account).permit(:email, :division)
    end
end
