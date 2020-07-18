# frozen_string_literal: true

require 'i18n'

I18n.load_path = Dir[Hanami.root.join('config/locales/**/*.{yml,rb}')]
I18n.default_locale = 'en'
I18n.backend.load_translations
