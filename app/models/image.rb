class Image < ApplicationRecord
  belongs_to :uploaded_by, class_name: 'User'
end
