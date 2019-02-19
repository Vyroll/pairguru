# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :string
#  user_id    :integer
#  movie_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validate :limit
  
  def limit
    user = self.user
    movie = self.movie
    comments = user.reload.comments.where(movie:movie)

    if comments.count >= 1
      errors.add(:base, "Exceeded comments limit. You can leave only one comment under each movie. U HAVE #{comments.count} COMMENTS")
    end
  end
end
