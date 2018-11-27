class Upload < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	validates :attachment, presence: true
	belongs_to :user
end
