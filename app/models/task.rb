class Task < ApplicationRecord
  belongs_to :user
	validates :title, presence: true
	validates :detail, presence: true

	paginates_per 5

	enum priority: {high: 1, middle: 2, low: 3}

	scope :title_search, -> (query) {where("title LIKE ?", "%#{query}%")}
	def title_search(query)
	  where("title LIKE ?", "%#{query}%")
	end

  scope :status_search, -> (query) {where(status: query)}
  def status_search(query)
  	where(status: query)
  end
end
