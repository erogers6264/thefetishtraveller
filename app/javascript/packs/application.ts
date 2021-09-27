import * as Rails from '@rails/ujs';
import '@hotwired/turbo-rails';

Rails.start();

import '../sprinkles/touch';
import '../controllers';

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js');
}