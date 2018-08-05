# frozen_string_literal: true

module ApplicationHelper
  def alert_class(name)
    name = name.to_sym
    case name
    when :notice, :success then :success
    when :warning then :warning
    when :info then :info
    else :danger
    end
  end

  def empty_char
    safe_join [raw("&#8709;")]
  end

  def provider_profile_link(provider, uid)
    case provider
    when "twitter"
      link_to provider.capitalize, "https://twitter.com/intent/user?user_id=#{uid}"
    when "facebook"
      link_to provider.capitalize, "https://www.facebook.com/#{uid}"
    else
      empty_char
    end
  end

  def roles_list(roles)
    roles.any? ? roles.map(&:name).join(", ") : empty_char
  end

  def active_class(path)
    if path.is_a?(Array)
      "active" if path.map { |p| current_page?(p) }.include?(true)
    elsif current_page?(path)
      "active"
    end
  end
end
