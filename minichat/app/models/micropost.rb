class Micropost < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	validates :author,	presence: true, length: { maximum: 50 }
	validates :content,	presence: true, length: { maximum: 140 }
end
