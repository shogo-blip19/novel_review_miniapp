class Review < ApplicationRecord
    validates :title, presence: true
    validates :genre, presence: true
    validates :comment, length: { maximum: 50 }
    belongs_to :user    

end
