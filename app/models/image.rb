class Image < ApplicationRecord
  belongs_to :user, foreign_key :uploaded_by
end
