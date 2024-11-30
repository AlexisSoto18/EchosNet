class UsersController < ApplicationController
  before_action :authenticate_user!

  def download_pdf
    @user = current_user
    @followers = @user.followers
    @following = @user.followed_users
    @tweeets = @user.tweeets

    pdf = Prawn::Document.new
    pdf.text "User Details", size: 24, style: :bold
    pdf.move_down 20

    # Información básica del usuario
    pdf.text "Name: #{@user.name}"
    pdf.text "Username: #{@user.username}"
    pdf.text "Email: #{@user.email}"
    pdf.move_down 20

    # Información de publicaciones
    pdf.text "Posts (Total: #{@tweeets.count}):", size: 18, style: :bold
    @tweeets.each do |tweeet|
      pdf.text tweeet.tweeet
    end
    pdf.move_down 20

    # Información de seguidores
    pdf.text "Followers:", size: 18, style: :bold
    @followers.each do |user|
      pdf.text "#{user.name} (@#{user.username})"
    end
    pdf.move_down 20

    # Información de seguidos
    pdf.text "Following:", size: 18, style: :bold
    @following.each do |user|
      pdf.text "#{user.name} (@#{user.username})"
    end

    send_data pdf.render, filename: "user_details.pdf", type: "application/pdf", disposition: "inline"
  end
end
