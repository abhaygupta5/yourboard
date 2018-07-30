class Notification < ApplicationRecord
	belongs_to :recipient, class_name: 'User'
	belongs_to :actor, class_name: 'User'
	belongs_to :notifiable, class_name: 'Post'


	scope :unread, -> { where(read_at: nil) }
end
