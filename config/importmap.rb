# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin 'jquery', to: 'jquery.min.js', preload: true
pin 'jquery-ujs', to: 'jquery-ujs.js', preload: true
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
