module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = 'Ruby testing'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def header_active
    {@title => 'active'}
  end

  def error_class(string)
    unless @user.errors[string].blank?
      'error'
    end
  end

  def get_error(string)
    unless @user.errors[string].blank?
      message = @user.errors[string][0]
      @user.errors.full_message(string, message)
    end
  end

  def get_placeholder(size)
    color = %w(2F06E2 F1F15A 24AB66 DD4814).sort_by { rand }
    image_tag("http://cambelt.co/120x120/User?color=#{color},FFFFFF", :class => "img-circle #{size}-sized")
  end

  def get_icon(type)
    image_tag("icons/#{type}.png", :class => 'small-sized')
  end
end