Rails.application.reloader.to_prepare do
  Globalize::ActiveRecord::InstanceMethods.module_eval do
    def save(**)
      result = Globalize.with_locale(translation.locale || I18n.default_locale) do
        without_fallbacks do
          super
        end
      end

      globalize.clear_dirty if result

      result
    end
  end
end