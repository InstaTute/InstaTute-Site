class ReviewMailer < ApplicationMailer
  def review(review,user,tutor)
    @user = user
    @tutor = tutor
    @notice = @user.first_name << " has written a review of their last session with " << @tutor.first_name << " " << @tutor.last_name << ":"
    @details = review

    mail to: 'reviews@instatute.org', subject: "New Review"
  end
end
