class Story < ActiveRecord::Base
	after_create :create_initial_vote
	validates :name, :presence => true
	validates :link, :presence => true
	has_many :votes do
		def latest
			find :all, :order => 'id DESC', :limit => 3
		end
	end
	belongs_to :user
	def to_param
		"#{id}-#{name.gsub(/\W/,'-').downcase}"
	end
	protected
		def create_initial_vote
			votes.create :user => user
		end
end
