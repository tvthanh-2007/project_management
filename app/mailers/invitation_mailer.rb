class InvitationMailer < ApplicationMailer
  default from: ENV.fetch("MAILERSEND_MAIL_NO_REPLY", "no-reply@gmail.com")

  def invite_email(invitation)
    @invitation = invitation
    @accept_url = "#{ENV["FE_DOMAIN"]}/projects/#{@invitation.project_id}/invitations/accept?" \
                  "token=#{@invitation.token}&email=#{CGI.escape(@invitation.email)}"

    mail(to: @invitation.email, subject: "Invitation #{@invitation.project.name}")
  end
end
