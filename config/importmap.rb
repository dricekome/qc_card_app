# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "custom/team_unique_select", to: "custom/team_unique_select.js"
pin_all_from "app/javascript/controllers", under: "controllers"
