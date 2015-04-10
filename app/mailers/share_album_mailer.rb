class ShareAlbumMailer < ActionMailer::Base
  default from: 'sharemoments.com'

  def welcome_email(email, album)
    @email = email
    @album = album
    @url = 'http://sharemoments.com/user/sign_in'
    mail(to: @email, subject: 'Welcome to ShareMoments.com')
  end
end
