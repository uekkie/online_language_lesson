class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson_feedbacks = current_user.lesson_feedbacks
    @subscription = Subscription.find_by(user: current_user)
  end
end
