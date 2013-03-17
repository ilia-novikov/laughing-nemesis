module ApplicationHelper
	# Return a title on a per-page basis.
	def title
		base_title = "Ruby testing"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end	

	def header_active
		{@title => "active"}
	end

	def header_addon
		if not (["Home", "Contact", "About"].include?(@title))		
			return link_to @title, home_path
		end
	end
end