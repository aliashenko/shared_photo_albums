class ShareAlbumMailer < ActionMailer::Base
  default from: 'sharemoments.com'

  def welcome_email(email, album)
    @email = email
    @album = album
    @url = "localhost:3000/user/sign_up?album_id=#{@album.id}"
    mail(to: @email, subject: 'Welcome to ShareMoments.com')
  end
end
