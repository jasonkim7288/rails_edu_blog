class Post < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :comments

    validates :title, presence: true
    validates :category_id, presence: true
    validates :user_id, presence: false

    has_one_attached :image
    has_rich_text :body

    def self.search(query)
        where("title like ? OR body like ?", "%#{query}%", "%#{query}%")
    end
end
