import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
global.toastr = require("toastr");
global.$ = require("jquery");

Rails.start();
ActiveStorage.start();