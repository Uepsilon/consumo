module OrderItemsHelper
  def remaining_label(product, realm)
    remaining = product.remaining(realm.id)

    if remaining > 10
      label_class = 'info'
    elsif remaining > 5
      label_class = 'warn'
    else
      label_class = 'danger'
    end

    capture_haml do
      haml_tag :div, class: 'remaining' do
        haml_tag :span, "#{I18n.t 'product.remaining'}: "
        haml_tag :span, remaining, class: "label label-#{label_class}"
      end
    end
  end
end
