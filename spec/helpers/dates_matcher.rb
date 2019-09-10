module DatesMatcher
  def match_date(matching_date)
    matching_date_str = matching_date.strftime('%F')
    satisfy("match date #{matching_date_str}") { |date| date.strftime('%F') == matching_date_str }
  end
  alias a_date_matching match_date
end
