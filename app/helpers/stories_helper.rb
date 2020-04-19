module StoriesHelper
	def story_list_heading
		if controller.action_name == 'index'
			story_type = 'front page story'
		else
			story_type = 'upcoming story'
		end
		"Showing #{pluralize(@story.size, story_type)}"
	end
end
