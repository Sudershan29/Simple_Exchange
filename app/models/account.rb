class Account < ApplicationRecord
	belongs_to :user
	has_many :requests
	has_many :transactions
	has_many :coin_requests
end
