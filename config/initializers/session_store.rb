Rails.application.config.session_store :cookie_store, key: "_web_prac_#{Rails.env}_session", secure: Rails.env.production?
