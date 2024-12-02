class Book < ApplicationRecord
  belongs_to :user

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # ↓本の投稿数を数えるので、book.rbに記述してく。
  # scope :スコープの名前, -> { 条件式 }
  # モデル側であらかじめ特定の条件式に対して名前をつけて定義し、
  # その名前でメソッドの様に条件式を呼び出すことが出来る仕組みのこと!!
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 

end
