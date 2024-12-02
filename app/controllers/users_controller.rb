class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
  @books = @user.books.order(id: :desc)
  @book = Book.new
  @today_book = @books.select { |book| book.created_at.to_date == Date.today }
  @yesterday_book = @books.select { |book| book.created_at.to_date == Date.today - 1 }
 # 今週の投稿を取得する
 this_week_range = Date.today.all_week
 @this_week_book = @books.select { |book| this_week_range.cover?(book.created_at.to_date) }

 # 先週の投稿を取得する
 last_week_range = (Date.today - 1.week).all_week
 @last_week_book = @books.select { |book| last_week_range.cover?(book.created_at.to_date) }
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      flash[:updated] = "Your account has error"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
