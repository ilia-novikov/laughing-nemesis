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

	def classes
		if @title == "Home"
			return {:home => "active", :contact => "", :about => ""}
		end
		if @title == "Contact"
			return {:home => "", :contact => "active", :about => ""}
		end		
		if @title == "About"
			return {:home => "", :contact => "", :about => "active"}
		end
	end
end
