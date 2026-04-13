require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Força headless_chrome pra rodar silenciosamente em ambientes de CI e containers do Rails.
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
