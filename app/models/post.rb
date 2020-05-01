class Post < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :comments

    validates :title, presence: true
    validates :category_id, presence: true
    validates :user_id, presence: false

    has_one_attached :image
    has_rich_text :body
    has_one :action_text_rich_text,
        class_name: "ActionText::RichText",
        as: :record

    def self.search(query)
        # where("title like ? OR body like ?", "%#{query}%", "%#{query}%")
        joins(:action_text_rich_text).where("action_text_rich_texts.body LIKE ?", "%#{query}%")
    end
end
