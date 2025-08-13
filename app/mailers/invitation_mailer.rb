class InvitationMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def invite_email(invitation)
    @invitation = invitation
    @accept_url = "#{ENV["FE_DOMAIN"]}/projects/#{@invitation.project_id}/invitations/accept?" \
                  "token=#{@invitation.token}&email=#{CGI.escape(@invitation.email)}"

    mail(to: @invitation.email, subject: "Invitation #{@invitation.project.name}")
  end
end
