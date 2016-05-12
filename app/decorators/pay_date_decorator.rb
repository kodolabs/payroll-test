class PayDateDecorator < Draper::Decorator

  delegate_all

  def show_date
    if is_first?
      I18n.t('dates.first_day')
    elsif is_last?
      I18n.t('dates.last_date')
    else
      "Every #{object.pay_date} day"
    end

  end

end