class CertificatesController < ApplicationController

    #This provides separate indexes for processed and pending certificates
    def index
        @pending_certificates= Certificate.select { |certificate| certificate.approved == nil && certificate.expiration_date}
        @processed_certificates = Certificate.select { |certificate| certificate.approved != nil && certificate.expiration_date}.reverse!
    end

    #This handles uploading certificates
    def upload
        if params[:certificate][:expiration_date]
            @cert = Certificate.find_by_id(params[:id])
            @cert.update_attributes(cert_upload_params)
            @cert.update_attributes(:number => params[:certificate][:number], :expiration_date => DateTime.strptime(params[:certificate][:expiration_date],'%m/%d/%Y'))
            if @cert.expiration_date > DateTime.now
                @cert.update_attributes(:approved => nil)
            else
                @cert.update_attributes(:approved => false)
            end
        end
        redirect_to user_certs_path(@cert.user.id)
    end

    #This handles accepting certificates
    def accept_cert
        @certificate = Certificate.find_by_id(params[:id])
        @certificate.update_attribute(:approved,true)
        #add email logic
        respond_to do |format|
            format.js
        end
    end

    #This handles rejecting certificates
    def reject_cert
        @certificate = Certificate.find_by_id(params[:id])
        @certificate.update_attribute(:approved,false)
        #add email logic
        respond_to do |format|
            format.js
        end
    end

    private
    def cert_upload_params
        params.require(:certificate).permit(:front,:back)
    end
end
