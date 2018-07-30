class Post < ApplicationRecord
	has_many :comments, as: :commentable, dependent: :destroy
	validates :title, presence: true, length: { minimum: 3 }
	validates :body, presence: true
	validates :category, presence: true
	#has_many :comments, dependent: :destroy #dependent: destroy for dependency of comment on post, if post is deleted than commment also delete 	
	belongs_to :user
	has_many :reports
	

	has_attached_file :image, styles: { medium: "50% x 50%>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", validate_media_type: false
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	def to_param
  		"#{id}-#{title.parameterize}"
	end 


end
