class ShareAlbumMailer < ActionMailer::Base
  default from: 'sharemoments.com'

  def welcome_email(email, album)
    @email = email
    @album = album
    @url = 'http://sharemoments.com/login'
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end
end
