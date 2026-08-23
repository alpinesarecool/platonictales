class TalePost < ApplicationRecord
  has_many :feedbacks, dependent: :destroy
end
