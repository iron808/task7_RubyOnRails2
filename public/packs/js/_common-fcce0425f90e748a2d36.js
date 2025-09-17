/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/_common.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/_common.js":
/*!*****************************************!*\
  !*** ./app/javascript/packs/_common.js ***!
  \*****************************************/
/*! no static exports found */
/***/ (function(module, exports) {

document.addEventListener('DOMContentLoaded', function () {
  var toggle = document.getElementById("user_menu");
  var dropmenu = document.getElementById("login_dropmenu");
  toggle === null || toggle === void 0 || toggle.addEventListener('click', function () {
    dropmenu.classList.toggle("active");
  });
});
document.addEventListener("turbo:load", function () {
  var dotbutton = document.getElementById("dotsicon_text");
  var facilitymenu = document.getElementById("dotsicon_dropmenu");
  dotbutton.addEventListener('click', function () {
    facilitymenu.classList.toggle("active");
  });
});
document.addEventListener('DOMContentLoaded', function () {
  var viewPriceDiv = document.querySelector('.view_price');
  var checkinInput = document.getElementById('checkin_day');
  var checkoutInput = document.getElementById('checkout_day');
  var guestInput = document.getElementById('guest_count');
  var nightSpan = document.getElementById('night_count');
  var totalSpan = document.getElementById('total_price');
  var roomRate = parseFloat(viewPriceDiv.dataset.roomRate);
  function calculate() {
    var checkin = new Date(checkinInput.value);
    var checkout = new Date(checkoutInput.value);
    var guestCount = parseInt(guestInput.value, 10);
    if (checkin && checkout && checkout > checkin && guestCount > 0) {
      var nights = (checkout - checkin) / (1000 * 60 * 60 * 24);
      var total = nights * roomRate * guestCount;
      nightSpan.textContent = nights;
      totalSpan.textContent = total.toLocaleString();
    } else {
      nightSpan.textContent = 0;
      totalSpan.textContent = 0;
    }
  }
  checkinInput.addEventListener('change', calculate);
  checkoutInput.addEventListener('change', calculate);
  guestInput.addEventListener('input', calculate);
});

/***/ })

/******/ });
//# sourceMappingURL=_common-fcce0425f90e748a2d36.js.map