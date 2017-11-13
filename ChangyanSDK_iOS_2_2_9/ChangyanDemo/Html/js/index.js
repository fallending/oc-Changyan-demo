var alispjsbridge =
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
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
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
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 12);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

var core = module.exports = {version: '2.4.0'};
if(typeof __e == 'number')__e = core; // eslint-disable-line no-undef

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

// Thank's IE8 for his funny defineProperty
module.exports = !__webpack_require__(2)(function(){
  return Object.defineProperty({}, 'a', {get: function(){ return 7; }}).a != 7;
});

/***/ }),
/* 2 */
/***/ (function(module, exports) {

module.exports = function(exec){
  try {
    return !!exec();
  } catch(e){
    return true;
  }
};

/***/ }),
/* 3 */
/***/ (function(module, exports) {

// https://github.com/zloirock/core-js/issues/86#issuecomment-115759028
var global = module.exports = typeof window != 'undefined' && window.Math == Math
  ? window : typeof self != 'undefined' && self.Math == Math ? self : Function('return this')();
if(typeof __g == 'number')__g = global; // eslint-disable-line no-undef

/***/ }),
/* 4 */
/***/ (function(module, exports) {

module.exports = function(it){
  return typeof it === 'object' ? it !== null : typeof it === 'function';
};

/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = { "default": __webpack_require__(15), __esModule: true };

/***/ }),
/* 6 */
/***/ (function(module, exports) {

// 7.2.1 RequireObjectCoercible(argument)
module.exports = function(it){
  if(it == undefined)throw TypeError("Can't call method on  " + it);
  return it;
};

/***/ }),
/* 7 */
/***/ (function(module, exports) {

// 7.1.4 ToInteger
var ceil  = Math.ceil
  , floor = Math.floor;
module.exports = function(it){
  return isNaN(it = +it) ? 0 : (it > 0 ? floor : ceil)(it);
};

/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

// to indexed object, toObject with fallback for non-array-like ES3 strings
var IObject = __webpack_require__(28)
  , defined = __webpack_require__(6);
module.exports = function(it){
  return IObject(defined(it));
};

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var _keys = __webpack_require__(14);

var _keys2 = _interopRequireDefault(_keys);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var util = __webpack_require__(13);
var bridge1 = __webpack_require__(10);
var bridge2 = __webpack_require__(11);
module.exports = {
    index: 0,
    selfName: 'ESports',
    isiPhone: false,
    isAndroid: false,
    ua: navigator.userAgent.toString(),
    appJSBridgeVersion: '',
    debug: false,
    init: function init() {
        var debug = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : false;

        var iPhoneTag = "Alisports-JSBridge/iPhone/";
        var androidTag = "/Alisports-JSBridge/Android/";
        var iPhoneTagIndex = this.ua.indexOf(iPhoneTag);
        var androidTagIndex = this.ua.indexOf(androidTag);
        this.isiPhone = iPhoneTagIndex > -1;
        this.isAndroid = androidTagIndex > -1;
        this.debug = debug;
        var version = '';
        if (this.isiPhone) {
            version = this.ua.substring(iPhoneTagIndex + iPhoneTag.length);
        }
        if (this.isAndroid) {
            version = this.ua.substring(androidTagIndex + androidTag.length);
        }
        if (version) {
            var versionIndex = version.indexOf('/');
            if (versionIndex > -1) {
                this.appJSBridgeVersion = version.substr(0, versionIndex);
            } else {
                this.appJSBridgeVersion = version;
            }
        }
        bridge1.init(this);
        bridge2.init(this);
    },
    /**
     * 调用App函数
     * @param name 函数名
     * @param arg  参数
     */
    invoke: function invoke(name) {
        var arg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        try {
            if (this.appJSBridgeVersion >= '2.0.0') {
                return bridge2.invoke(name, arg);
            } else if (this.appJSBridgeVersion >= '1.0.0') {
                return bridge1.invoke(name, arg);
            }
        } catch (e) {
            console.log(e);
            return false;
        }
    },
    /**
     * 生成uniqueId
     * @returns {string}
     */
    generateUni: function generateUni() {
        this.index++;
        var random = Math.random() * 1000000;
        return 'callback_' + this.index + '_' + random.toFixed(0);
    },
    /**
     * 生成回调对象
     * @param success_callback 成功回调函数
     * @param success_arg      成功回调函数参数
     * @param fail_callback    失败回调函数
     * @param fail_arg         失败回调函数参数
     * @returns {{}}
     */
    generateCallback: function generateCallback() {
        var _ref = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref$success_callback = _ref.success_callback,
            success_callback = _ref$success_callback === undefined ? undefined : _ref$success_callback,
            _ref$success_arg = _ref.success_arg,
            success_arg = _ref$success_arg === undefined ? {} : _ref$success_arg,
            _ref$fail_callback = _ref.fail_callback,
            fail_callback = _ref$fail_callback === undefined ? undefined : _ref$fail_callback,
            _ref$fail_arg = _ref.fail_arg,
            fail_arg = _ref$fail_arg === undefined ? {} : _ref$fail_arg;

        var uni = this.generateUni();
        this[uni] = {
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        };
        var obj = {};
        if (util.isFunction(success_callback) && success_arg) {
            obj.success_callback = this.selfName + '.' + uni + '.success_callback(' + this.selfName + '.' + uni + '.success_arg);';
        } else if (util.isFunction(success_callback)) {
            obj.success_callback = this.selfName + '.' + uni + '.success_callback();';
        } else {
            obj.success_callback = '';
        }
        if (util.isFunction(fail_callback) && fail_arg) {
            obj.fail_callback = this.selfName + '.' + uni + '.fail_callback(' + this.selfName + '.' + uni + '.fail_arg);';
        } else if (util.isFunction(fail_callback)) {
            obj.fail_callback = this.selfName + '.' + uni + '.fail_callback();';
        } else {
            obj.fail_callback = '';
        }
        return obj;
    },
    /**
     * 调出原生的登陆界面
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    login: function login() {
        var _ref2 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref2$success_callbac = _ref2.success_callback,
            success_callback = _ref2$success_callbac === undefined ? undefined : _ref2$success_callbac,
            _ref2$success_arg = _ref2.success_arg,
            success_arg = _ref2$success_arg === undefined ? {} : _ref2$success_arg,
            _ref2$fail_callback = _ref2.fail_callback,
            fail_callback = _ref2$fail_callback === undefined ? undefined : _ref2$fail_callback,
            _ref2$fail_arg = _ref2.fail_arg,
            fail_arg = _ref2$fail_arg === undefined ? {} : _ref2$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var obj = {
            'parameter': {},
            'callback': callbackObj
        };
        return this.invoke('aesLogin', obj);
    },
    /**
     * 关闭当前webView界面
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    closeWebView: function closeWebView() {
        var _ref3 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref3$success_callbac = _ref3.success_callback,
            success_callback = _ref3$success_callbac === undefined ? undefined : _ref3$success_callbac,
            _ref3$success_arg = _ref3.success_arg,
            success_arg = _ref3$success_arg === undefined ? {} : _ref3$success_arg,
            _ref3$fail_callback = _ref3.fail_callback,
            fail_callback = _ref3$fail_callback === undefined ? undefined : _ref3$fail_callback,
            _ref3$fail_arg = _ref3.fail_arg,
            fail_arg = _ref3$fail_arg === undefined ? {} : _ref3$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var obj = {
            'parameter': {},
            'callback': callbackObj
        };
        return this.invoke('aesCloseWebView', obj);
    },
    /**
     * 调出分享页面
     * @param title             分享标题
     * @param desc              描述
     * @param preview           缩略图地址
     * @param shareUrl          分享页面url地址
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    /**
     *
     * @param title
     * @param desc
     * @param preview
     * @param shareUrl
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    share: function share() {
        var _ref4 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref4$title = _ref4.title,
            title = _ref4$title === undefined ? undefined : _ref4$title,
            _ref4$desc = _ref4.desc,
            desc = _ref4$desc === undefined ? undefined : _ref4$desc,
            _ref4$preview = _ref4.preview,
            preview = _ref4$preview === undefined ? undefined : _ref4$preview,
            _ref4$shareUrl = _ref4.shareUrl,
            shareUrl = _ref4$shareUrl === undefined ? undefined : _ref4$shareUrl;

        var _ref5 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref5$success_callbac = _ref5.success_callback,
            success_callback = _ref5$success_callbac === undefined ? undefined : _ref5$success_callbac,
            _ref5$success_arg = _ref5.success_arg,
            success_arg = _ref5$success_arg === undefined ? {} : _ref5$success_arg,
            _ref5$fail_callback = _ref5.fail_callback,
            fail_callback = _ref5$fail_callback === undefined ? undefined : _ref5$fail_callback,
            _ref5$fail_arg = _ref5.fail_arg,
            fail_arg = _ref5$fail_arg === undefined ? {} : _ref5$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            title: title,
            desc: desc,
            preview: preview,
            shareUrl: shareUrl
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesShare', obj);
    },
    /**
     * 新增webView界面
     * @param url               新增webView界面地址
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    makeSegue: function makeSegue() {
        var _ref6 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref6$url = _ref6.url,
            url = _ref6$url === undefined ? undefined : _ref6$url;

        var _ref7 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref7$success_callbac = _ref7.success_callback,
            success_callback = _ref7$success_callbac === undefined ? undefined : _ref7$success_callbac,
            _ref7$success_arg = _ref7.success_arg,
            success_arg = _ref7$success_arg === undefined ? {} : _ref7$success_arg,
            _ref7$fail_callback = _ref7.fail_callback,
            fail_callback = _ref7$fail_callback === undefined ? undefined : _ref7$fail_callback,
            _ref7$fail_arg = _ref7.fail_arg,
            fail_arg = _ref7$fail_arg === undefined ? {} : _ref7$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            url: encodeURI(url)
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesMakeSegue', obj);
    },
    /**
     * 以设置cookie 的方式透传移动端的参数
     * @param param
     * @returns {*|string}
     */
    checkLogin: function checkLogin(param) {
        param = param || '{}';
        try {
            var param = JSON.parse(param);
            (0, _keys2.default)(param).forEach(function (key) {
                document.cookie = key + '=' + param[key];
            });
        } catch (e) {
            console.log(e.name + ": " + e.message);
        }
        return param;
    },
    /**
     * 控制页面是否可以分享
     * @param is_share          是否可以分享 1=yes 0=no
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    canShare: function canShare() {
        var _ref8 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref8$is_share = _ref8.is_share,
            is_share = _ref8$is_share === undefined ? undefined : _ref8$is_share;

        var _ref9 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref9$success_callbac = _ref9.success_callback,
            success_callback = _ref9$success_callbac === undefined ? undefined : _ref9$success_callbac,
            _ref9$success_arg = _ref9.success_arg,
            success_arg = _ref9$success_arg === undefined ? {} : _ref9$success_arg,
            _ref9$fail_callback = _ref9.fail_callback,
            fail_callback = _ref9$fail_callback === undefined ? undefined : _ref9$fail_callback,
            _ref9$fail_arg = _ref9.fail_arg,
            fail_arg = _ref9$fail_arg === undefined ? {} : _ref9$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            is_share: is_share
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesCanShare', obj);
    },
    /**
     * 弹出toast的页面
     * @param message          弹出的消息(字符串)
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    toast: function toast() {
        var _ref10 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref10$message = _ref10.message,
            message = _ref10$message === undefined ? undefined : _ref10$message;

        var _ref11 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref11$success_callba = _ref11.success_callback,
            success_callback = _ref11$success_callba === undefined ? undefined : _ref11$success_callba,
            _ref11$success_arg = _ref11.success_arg,
            success_arg = _ref11$success_arg === undefined ? {} : _ref11$success_arg,
            _ref11$fail_callback = _ref11.fail_callback,
            fail_callback = _ref11$fail_callback === undefined ? undefined : _ref11$fail_callback,
            _ref11$fail_arg = _ref11.fail_arg,
            fail_arg = _ref11$fail_arg === undefined ? {} : _ref11$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            message: message
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesToast', obj);
    },
    /**
     * 移动端的alert兼confirm，lbtn_title和rbtn_title若为空则表示不存在此按钮。
     * @param title             弹框标题
     * @param content           弹框内容
     * @param lbtn_title        左按钮文案
     * @param lbtn_callback     左按钮回调函数
     * @param rbtn_title        右按钮文案
     * @param rbtn_callback     右按钮回调函数
     * @param success_callback
     * @param success_arg
     * @param fail_callback
     * @param fail_arg
     */
    alert: function alert() {
        var _ref12 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref12$title = _ref12.title,
            title = _ref12$title === undefined ? undefined : _ref12$title,
            _ref12$content = _ref12.content,
            content = _ref12$content === undefined ? undefined : _ref12$content,
            _ref12$lbtn_title = _ref12.lbtn_title,
            lbtn_title = _ref12$lbtn_title === undefined ? undefined : _ref12$lbtn_title,
            _ref12$lbtn_callback = _ref12.lbtn_callback,
            lbtn_callback = _ref12$lbtn_callback === undefined ? undefined : _ref12$lbtn_callback,
            _ref12$rbtn_title = _ref12.rbtn_title,
            rbtn_title = _ref12$rbtn_title === undefined ? undefined : _ref12$rbtn_title,
            _ref12$rbtn_callback = _ref12.rbtn_callback,
            rbtn_callback = _ref12$rbtn_callback === undefined ? undefined : _ref12$rbtn_callback;

        var _ref13 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref13$success_callba = _ref13.success_callback,
            success_callback = _ref13$success_callba === undefined ? undefined : _ref13$success_callba,
            _ref13$success_arg = _ref13.success_arg,
            success_arg = _ref13$success_arg === undefined ? {} : _ref13$success_arg,
            _ref13$fail_callback = _ref13.fail_callback,
            fail_callback = _ref13$fail_callback === undefined ? undefined : _ref13$fail_callback,
            _ref13$fail_arg = _ref13.fail_arg,
            fail_arg = _ref13$fail_arg === undefined ? {} : _ref13$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            title: title,
            content: content
        };
        if (lbtn_title) {

            parameter.leftAction = {
                'title': lbtn_title,
                'action': '(' + lbtn_callback + ')()'
            };
        }
        if (rbtn_title) {

            parameter.rightAction = {
                'title': rbtn_title,
                'action': '(' + rbtn_callback + ')()'
            };
        }
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesAlert', obj);
    },
    phoneCall: function phoneCall() {
        var _ref14 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref14$phone = _ref14.phone,
            phone = _ref14$phone === undefined ? undefined : _ref14$phone;

        var _ref15 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref15$success_callba = _ref15.success_callback,
            success_callback = _ref15$success_callba === undefined ? undefined : _ref15$success_callba,
            _ref15$success_arg = _ref15.success_arg,
            success_arg = _ref15$success_arg === undefined ? {} : _ref15$success_arg,
            _ref15$fail_callback = _ref15.fail_callback,
            fail_callback = _ref15$fail_callback === undefined ? undefined : _ref15$fail_callback,
            _ref15$fail_arg = _ref15.fail_arg,
            fail_arg = _ref15$fail_arg === undefined ? {} : _ref15$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            phone: phone + ''
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke("aesPhoneCall", obj);
    },
    setTitle: function setTitle() {
        var _ref16 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref16$title = _ref16.title,
            title = _ref16$title === undefined ? undefined : _ref16$title;

        var _ref17 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref17$success_callba = _ref17.success_callback,
            success_callback = _ref17$success_callba === undefined ? undefined : _ref17$success_callba,
            _ref17$success_arg = _ref17.success_arg,
            success_arg = _ref17$success_arg === undefined ? {} : _ref17$success_arg,
            _ref17$fail_callback = _ref17.fail_callback,
            fail_callback = _ref17$fail_callback === undefined ? undefined : _ref17$fail_callback,
            _ref17$fail_arg = _ref17.fail_arg,
            fail_arg = _ref17$fail_arg === undefined ? {} : _ref17$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            title: title
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesSetTitle', obj);
    },
    duiBaLogin: function duiBaLogin() {
        var _ref18 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref18$success_callba = _ref18.success_callback,
            success_callback = _ref18$success_callba === undefined ? undefined : _ref18$success_callba,
            _ref18$success_arg = _ref18.success_arg,
            success_arg = _ref18$success_arg === undefined ? {} : _ref18$success_arg,
            _ref18$fail_callback = _ref18.fail_callback,
            fail_callback = _ref18$fail_callback === undefined ? undefined : _ref18$fail_callback,
            _ref18$fail_arg = _ref18.fail_arg,
            fail_arg = _ref18$fail_arg === undefined ? {} : _ref18$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var obj = {
            'parameter': {},
            'callback': callbackObj
        };
        return this.invoke('aesDuiBaLogin', obj);
    },
    newsInfo: function newsInfo() {
        var _ref19 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref19$title = _ref19.title,
            title = _ref19$title === undefined ? undefined : _ref19$title,
            _ref19$preview = _ref19.preview,
            preview = _ref19$preview === undefined ? undefined : _ref19$preview,
            _ref19$shareUrl = _ref19.shareUrl,
            shareUrl = _ref19$shareUrl === undefined ? undefined : _ref19$shareUrl,
            _ref19$newsId = _ref19.newsId,
            newsId = _ref19$newsId === undefined ? undefined : _ref19$newsId,
            _ref19$desc = _ref19.desc,
            desc = _ref19$desc === undefined ? undefined : _ref19$desc,
            _ref19$vid = _ref19.vid,
            vid = _ref19$vid === undefined ? undefined : _ref19$vid,
            _ref19$isVideo = _ref19.isVideo,
            isVideo = _ref19$isVideo === undefined ? undefined : _ref19$isVideo;

        var _ref20 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref20$success_callba = _ref20.success_callback,
            success_callback = _ref20$success_callba === undefined ? undefined : _ref20$success_callba,
            _ref20$success_arg = _ref20.success_arg,
            success_arg = _ref20$success_arg === undefined ? {} : _ref20$success_arg,
            _ref20$fail_callback = _ref20.fail_callback,
            fail_callback = _ref20$fail_callback === undefined ? undefined : _ref20$fail_callback,
            _ref20$fail_arg = _ref20.fail_arg,
            fail_arg = _ref20$fail_arg === undefined ? {} : _ref20$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            title: title,
            preview: preview,
            shareUrl: shareUrl,
            newsId: newsId,
            desc: desc,
            vid: vid,
            isVideo: isVideo
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke("aesNewsInfo", obj);
    },
    ykPlayerStatusChanged: function ykPlayerStatusChanged() {
        var _ref21 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref21$vid = _ref21.vid,
            vid = _ref21$vid === undefined ? undefined : _ref21$vid,
            _ref21$status = _ref21.status,
            status = _ref21$status === undefined ? undefined : _ref21$status;

        var _ref22 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref22$success_callba = _ref22.success_callback,
            success_callback = _ref22$success_callba === undefined ? undefined : _ref22$success_callba,
            _ref22$success_arg = _ref22.success_arg,
            success_arg = _ref22$success_arg === undefined ? {} : _ref22$success_arg,
            _ref22$fail_callback = _ref22.fail_callback,
            fail_callback = _ref22$fail_callback === undefined ? undefined : _ref22$fail_callback,
            _ref22$fail_arg = _ref22.fail_arg,
            fail_arg = _ref22$fail_arg === undefined ? {} : _ref22$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            vid: vid,
            status: status
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesYKPlayerStatusChanged', obj);
    },
    showBigImageAtIndex: function showBigImageAtIndex() {
        var _ref23 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref23$imgs = _ref23.imgs,
            imgs = _ref23$imgs === undefined ? undefined : _ref23$imgs,
            _ref23$i = _ref23.i,
            i = _ref23$i === undefined ? undefined : _ref23$i;

        var _ref24 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref24$success_callba = _ref24.success_callback,
            success_callback = _ref24$success_callba === undefined ? undefined : _ref24$success_callba,
            _ref24$success_arg = _ref24.success_arg,
            success_arg = _ref24$success_arg === undefined ? {} : _ref24$success_arg,
            _ref24$fail_callback = _ref24.fail_callback,
            fail_callback = _ref24$fail_callback === undefined ? undefined : _ref24$fail_callback,
            _ref24$fail_arg = _ref24.fail_arg,
            fail_arg = _ref24$fail_arg === undefined ? {} : _ref24$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            imgs: imgs,
            i: i
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesShowBigImageAtIndex', obj);
    },
    gamingHallNavigationBarRightButtonText: function gamingHallNavigationBarRightButtonText() {
        var _ref25 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref25$title = _ref25.title,
            title = _ref25$title === undefined ? undefined : _ref25$title,
            _ref25$type = _ref25.type,
            type = _ref25$type === undefined ? undefined : _ref25$type,
            _ref25$cityId = _ref25.cityId,
            cityId = _ref25$cityId === undefined ? undefined : _ref25$cityId;

        var _ref26 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref26$success_callba = _ref26.success_callback,
            success_callback = _ref26$success_callba === undefined ? undefined : _ref26$success_callba,
            _ref26$success_arg = _ref26.success_arg,
            success_arg = _ref26$success_arg === undefined ? {} : _ref26$success_arg,
            _ref26$fail_callback = _ref26.fail_callback,
            fail_callback = _ref26$fail_callback === undefined ? undefined : _ref26$fail_callback,
            _ref26$fail_arg = _ref26.fail_arg,
            fail_arg = _ref26$fail_arg === undefined ? {} : _ref26$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            title: title,
            type: type,
            cityId: cityId
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesGamingHallNavigationBarRightButtonText', obj);
    },
    gamingHallLocation: function gamingHallLocation() {
        var _ref27 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref27$cityName = _ref27.cityName,
            cityName = _ref27$cityName === undefined ? undefined : _ref27$cityName,
            _ref27$cityId = _ref27.cityId,
            cityId = _ref27$cityId === undefined ? undefined : _ref27$cityId;

        var _ref28 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            _ref28$success_callba = _ref28.success_callback,
            success_callback = _ref28$success_callba === undefined ? undefined : _ref28$success_callba,
            _ref28$success_arg = _ref28.success_arg,
            success_arg = _ref28$success_arg === undefined ? {} : _ref28$success_arg,
            _ref28$fail_callback = _ref28.fail_callback,
            fail_callback = _ref28$fail_callback === undefined ? undefined : _ref28$fail_callback,
            _ref28$fail_arg = _ref28.fail_arg,
            fail_arg = _ref28$fail_arg === undefined ? {} : _ref28$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });
        var parameter = {
            cityName: cityName,
            cityId: cityId
        };
        var obj = {
            'parameter': parameter,
            'callback': callbackObj
        };
        return this.invoke('aesGamingHallLocation', obj);
    },
    refreshSsoToken: function refreshSsoToken() {
        var _ref29 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref29$success_callba = _ref29.success_callback,
            success_callback = _ref29$success_callba === undefined ? undefined : _ref29$success_callba,
            _ref29$success_arg = _ref29.success_arg,
            success_arg = _ref29$success_arg === undefined ? {} : _ref29$success_arg,
            _ref29$fail_callback = _ref29.fail_callback,
            fail_callback = _ref29$fail_callback === undefined ? undefined : _ref29$fail_callback,
            _ref29$fail_arg = _ref29.fail_arg,
            fail_arg = _ref29$fail_arg === undefined ? {} : _ref29$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });

        callbackObj.success_callback = callbackObj.success_callback.replace(/success_callback\((.*?)\)/, 'success_callback("SSO_TOKEN",$1)');
        callbackObj.success_callback = callbackObj.success_callback.replace(/,\s*?\)/, ')');
        var obj = {
            'parameter': {},
            'callback': callbackObj
        };
        return this.invoke('aesRefreshSsoToken', obj);
    },
    getSsoToken: function getSsoToken() {
        var _ref30 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
            _ref30$success_callba = _ref30.success_callback,
            success_callback = _ref30$success_callba === undefined ? undefined : _ref30$success_callba,
            _ref30$success_arg = _ref30.success_arg,
            success_arg = _ref30$success_arg === undefined ? {} : _ref30$success_arg,
            _ref30$fail_callback = _ref30.fail_callback,
            fail_callback = _ref30$fail_callback === undefined ? undefined : _ref30$fail_callback,
            _ref30$fail_arg = _ref30.fail_arg,
            fail_arg = _ref30$fail_arg === undefined ? {} : _ref30$fail_arg;

        var callbackObj = this.generateCallback({
            'success_callback': success_callback,
            'success_arg': success_arg,
            'fail_callback': fail_callback,
            'fail_arg': fail_arg
        });

        callbackObj.success_callback = callbackObj.success_callback.replace(/success_callback\((.*?)\)/, 'success_callback("SSO_TOKEN",$1)');
        callbackObj.success_callback = callbackObj.success_callback.replace(/,\s*?\)/, ')');
        var obj = {
            'parameter': {},
            'callback': callbackObj
        };
        return this.invoke('aesGetSsoToken', obj);
    }
};

/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var _stringify = __webpack_require__(5);

var _stringify2 = _interopRequireDefault(_stringify);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

module.exports = {
    bridge: null,
    init: function init(bridge) {
        this.bridge = bridge;
    },
    invoke: function invoke(name) {
        var arg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        if (this.bridge.isiPhone) {
            return this.invokePhone(name, arg);
        } else if (this.bridge.isAndroid) {
            return this.invokeAndroid(name, arg);
        } else {
            return false;
        }
    },
    getMapFunctionName: function getMapFunctionName(name) {
        var funciton_map = {
            'ios': {
                'aesPhoneCall': 'aesTelephone',
                'aesNewsInfo': 'aesNewsInfomation'
            },
            'android': {}
        };
        if (this.bridge.isiPhone) {
            return typeof funciton_map.ios[name] == 'undefined' ? name : funciton_map.ios[name];
        } else if (this.bridge.isAndroid) {
            return typeof funciton_map.android[name] == 'undefined' ? name : funciton_map.ios[name];
        } else {
            return name;
        }
    },
    invokePhone: function invokePhone(name) {
        var arg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        var func = void 0;
        var func_name = this.getMapFunctionName(name);
        if (!func_name) {
            console.log('getMapFunctionName not find:' + name);
            return false;
        }
        func = typeof window.webkit.messageHandlers[func_name] !== 'undefined' ? window.webkit.messageHandlers[func_name] : null;
        if (!func) {
            console.log('function not find:' + func_name);
            return false;
        }
        switch (func_name) {
            case 'aesLogin':
                func.postMessage(null);
                break;
            case 'aesCloseWebView':
                func.postMessage(null);
                break;
            case 'aesShare':
                func.postMessage(arg.parameter);
                break;
            case 'aesMakeSegue':
                func.postMessage(arg.parameter.url);
                break;
            case 'aesCanShare':
                func.postMessage(arg.parameter.is_share);
                break;
            case 'aesToast':
                func.postMessage(arg.parameter.message);
                break;
            case 'aesAlert':
                func.postMessage(arg.parameter);
                break;
            case 'aesTelephone':
                func.postMessage(arg.parameter);
                break;
            case 'aesSetTitle':
                func.postMessage(arg.parameter.title);
                break;
            case 'aesDuiBaLogin':
                func.postMessage(null);
                break;
            case 'aesNewsInfomation':
                func.postMessage(arg.parameter);
                break;
            case 'aesYKPlayerStatusChanged':
                func.postMessage(arg.parameter);
                break;
            case 'aesShowBigImageAtIndex':
                func.postMessage(arg.parameter);
                break;
            case 'aesGamingHallNavigationBarRightButtonText':
                func.postMessage(arg.parameter);
                break;
            case 'aesGamingHallLocation':
                func.postMessage(arg.parameter);
                break;
            default:
                console.log('function not match:' + func_name);
                return false;
                break;
        }
        return true;
    },
    invokeAndroid: function invokeAndroid(name) {
        var arg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        var func = void 0;
        var func_name = this.getMapFunctionName(name);
        if (!func_name) {
            console.log('getMapFunctionName not find:' + name);
            return false;
        }
        func = typeof window.esportsAndroid[func_name] !== 'undefined' ? window.esportsAndroid[func_name] : null;
        if (!func) {
            console.log('function not find:' + func_name);
            return false;
        }
        switch (func_name) {
            case 'aesLogin':
                func.apply(window.esportsAndroid, []);
                break;
            case 'aesCloseWebView':
                func.apply(window.esportsAndroid, ['']);
                break;
            case 'aesShare':
                func.apply(window.esportsAndroid, [(0, _stringify2.default)(arg.parameter)]);
                break;
            case 'aesMakeSegue':
                func.apply(window.esportsAndroid, [arg.parameter.url]);
                break;
            case 'aesCanShare':
                func.apply(window.esportsAndroid, [arg.parameter.is_share]);
                break;
            case 'aesToast':
                func.apply(window.esportsAndroid, [arg.parameter.message]);
                break;
            case 'aesAlert':
                func.apply(window.esportsAndroid, [(0, _stringify2.default)(arg.parameter)]);
                break;
            case 'aesPhoneCall':
                func.apply(window.esportsAndroid, [arg.parameter.phone]);
                break;
            case 'aesSetTitle':
                func.apply(window.esportsAndroid, [arg.parameter.title]);
                break;
            case 'aesDuiBaLogin':
                func.apply(window.esportsAndroid, []);
                break;
            case 'aesNewsInfo':
                func.apply(window.esportsAndroid, [(0, _stringify2.default)(arg.parameter)]);
                break;
            case 'aesYKPlayerStatusChanged':
                func.apply(window.esportsAndroid, [(0, _stringify2.default)(arg.parameter)]);
                break;
            case 'aesShowBigImageAtIndex':
                func.apply(window.esportsAndroid, [arg.parameter.imgs, arg.parameter.i]);
                break;
            case 'aesGamingHallNavigationBarRightButtonText':
                func.apply(window.esportsAndroid, [(0, _stringify2.default)(arg.parameter)]);
                break;
            case 'aesGamingHallLocation':
                func.apply(window.esportsAndroid, [(0, _stringify2.default)(arg.parameter)]);
                break;
            default:
                console.log('function not match:' + func_name);
                return false;
                break;
        }
        return true;
    }
};

/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var _stringify = __webpack_require__(5);

var _stringify2 = _interopRequireDefault(_stringify);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

module.exports = {
    bridge: null,
    init: function init(bridge) {
        this.bridge = bridge;
    },
    invoke: function invoke(name) {
        var arg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        if (this.bridge.isiPhone) {
            return this.invokePhone(name, arg);
        } else if (this.bridge.isAndroid) {
            return this.invokeAndroid(name, arg);
        } else {
            return false;
        }
    },
    getMapFunctionName: function getMapFunctionName(name) {
        var funciton_map = {
            'ios': {},
            'android': {}
        };
        if (this.bridge.isiPhone) {
            return typeof funciton_map.ios[name] == 'undefined' ? name : funciton_map.ios[name];
        } else if (this.bridge.isAndroid) {
            return typeof funciton_map.android[name] == 'undefined' ? name : funciton_map.ios[name];
        } else {
            return name;
        }
    },
    invokePhone: function invokePhone(name) {
        var arg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        var func = void 0;
        var func_name = this.getMapFunctionName(name);
        if (!func_name) {
            console.log('getMapFunctionName not find:' + name);
            return false;
        }
        func = typeof window.webkit.messageHandlers[func_name] !== 'undefined' ? window.webkit.messageHandlers[func_name] : null;
        if (!func) {
            console.log('function not find:' + func_name);
            return false;
        }
        func.postMessage(arg);
        return true;
    },
    invokeAndroid: function invokeAndroid(name) {
        var arg = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        var func = void 0;
        var func_name = this.getMapFunctionName(name);
        if (!func_name) {
            console.log('getMapFunctionName not find:' + name);
            return false;
        }
        func = typeof window.esportsAndroid[func_name] !== 'undefined' ? window.esportsAndroid[func_name] : null;
        if (!func) {
            console.log('function not find:' + func_name);
            return false;
        }
        func.apply(window.esportsAndroid, [(0, _stringify2.default)(arg)]);
        return true;
    }
};

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


window.ESports = __webpack_require__(9);
({
    "init": function init() {
        var ReadyEvent = new Event('ESportsReady');
        document.dispatchEvent(ReadyEvent);
        window.ESports.init();
    }
}).init();

/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = {
    isFunction: function isFunction(arg) {
        return Object.prototype.toString.call(arg) === '[object Function]';
    }
};

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = { "default": __webpack_require__(16), __esModule: true };

/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

var core  = __webpack_require__(0)
  , $JSON = core.JSON || (core.JSON = {stringify: JSON.stringify});
module.exports = function stringify(it){ // eslint-disable-line no-unused-vars
  return $JSON.stringify.apply($JSON, arguments);
};

/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(41);
module.exports = __webpack_require__(0).Object.keys;

/***/ }),
/* 17 */
/***/ (function(module, exports) {

module.exports = function(it){
  if(typeof it != 'function')throw TypeError(it + ' is not a function!');
  return it;
};

/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

var isObject = __webpack_require__(4);
module.exports = function(it){
  if(!isObject(it))throw TypeError(it + ' is not an object!');
  return it;
};

/***/ }),
/* 19 */
/***/ (function(module, exports, __webpack_require__) {

// false -> Array#indexOf
// true  -> Array#includes
var toIObject = __webpack_require__(8)
  , toLength  = __webpack_require__(37)
  , toIndex   = __webpack_require__(36);
module.exports = function(IS_INCLUDES){
  return function($this, el, fromIndex){
    var O      = toIObject($this)
      , length = toLength(O.length)
      , index  = toIndex(fromIndex, length)
      , value;
    // Array#includes uses SameValueZero equality algorithm
    if(IS_INCLUDES && el != el)while(length > index){
      value = O[index++];
      if(value != value)return true;
    // Array#toIndex ignores holes, Array#includes - not
    } else for(;length > index; index++)if(IS_INCLUDES || index in O){
      if(O[index] === el)return IS_INCLUDES || index || 0;
    } return !IS_INCLUDES && -1;
  };
};

/***/ }),
/* 20 */
/***/ (function(module, exports) {

var toString = {}.toString;

module.exports = function(it){
  return toString.call(it).slice(8, -1);
};

/***/ }),
/* 21 */
/***/ (function(module, exports, __webpack_require__) {

// optional / simple context binding
var aFunction = __webpack_require__(17);
module.exports = function(fn, that, length){
  aFunction(fn);
  if(that === undefined)return fn;
  switch(length){
    case 1: return function(a){
      return fn.call(that, a);
    };
    case 2: return function(a, b){
      return fn.call(that, a, b);
    };
    case 3: return function(a, b, c){
      return fn.call(that, a, b, c);
    };
  }
  return function(/* ...args */){
    return fn.apply(that, arguments);
  };
};

/***/ }),
/* 22 */
/***/ (function(module, exports, __webpack_require__) {

var isObject = __webpack_require__(4)
  , document = __webpack_require__(3).document
  // in old IE typeof document.createElement is 'object'
  , is = isObject(document) && isObject(document.createElement);
module.exports = function(it){
  return is ? document.createElement(it) : {};
};

/***/ }),
/* 23 */
/***/ (function(module, exports) {

// IE 8- don't enum bug keys
module.exports = (
  'constructor,hasOwnProperty,isPrototypeOf,propertyIsEnumerable,toLocaleString,toString,valueOf'
).split(',');

/***/ }),
/* 24 */
/***/ (function(module, exports, __webpack_require__) {

var global    = __webpack_require__(3)
  , core      = __webpack_require__(0)
  , ctx       = __webpack_require__(21)
  , hide      = __webpack_require__(26)
  , PROTOTYPE = 'prototype';

var $export = function(type, name, source){
  var IS_FORCED = type & $export.F
    , IS_GLOBAL = type & $export.G
    , IS_STATIC = type & $export.S
    , IS_PROTO  = type & $export.P
    , IS_BIND   = type & $export.B
    , IS_WRAP   = type & $export.W
    , exports   = IS_GLOBAL ? core : core[name] || (core[name] = {})
    , expProto  = exports[PROTOTYPE]
    , target    = IS_GLOBAL ? global : IS_STATIC ? global[name] : (global[name] || {})[PROTOTYPE]
    , key, own, out;
  if(IS_GLOBAL)source = name;
  for(key in source){
    // contains in native
    own = !IS_FORCED && target && target[key] !== undefined;
    if(own && key in exports)continue;
    // export native or passed
    out = own ? target[key] : source[key];
    // prevent global pollution for namespaces
    exports[key] = IS_GLOBAL && typeof target[key] != 'function' ? source[key]
    // bind timers to global for call from export context
    : IS_BIND && own ? ctx(out, global)
    // wrap global constructors for prevent change them in library
    : IS_WRAP && target[key] == out ? (function(C){
      var F = function(a, b, c){
        if(this instanceof C){
          switch(arguments.length){
            case 0: return new C;
            case 1: return new C(a);
            case 2: return new C(a, b);
          } return new C(a, b, c);
        } return C.apply(this, arguments);
      };
      F[PROTOTYPE] = C[PROTOTYPE];
      return F;
    // make static versions for prototype methods
    })(out) : IS_PROTO && typeof out == 'function' ? ctx(Function.call, out) : out;
    // export proto methods to core.%CONSTRUCTOR%.methods.%NAME%
    if(IS_PROTO){
      (exports.virtual || (exports.virtual = {}))[key] = out;
      // export proto methods to core.%CONSTRUCTOR%.prototype.%NAME%
      if(type & $export.R && expProto && !expProto[key])hide(expProto, key, out);
    }
  }
};
// type bitmap
$export.F = 1;   // forced
$export.G = 2;   // global
$export.S = 4;   // static
$export.P = 8;   // proto
$export.B = 16;  // bind
$export.W = 32;  // wrap
$export.U = 64;  // safe
$export.R = 128; // real proto method for `library` 
module.exports = $export;

/***/ }),
/* 25 */
/***/ (function(module, exports) {

var hasOwnProperty = {}.hasOwnProperty;
module.exports = function(it, key){
  return hasOwnProperty.call(it, key);
};

/***/ }),
/* 26 */
/***/ (function(module, exports, __webpack_require__) {

var dP         = __webpack_require__(29)
  , createDesc = __webpack_require__(33);
module.exports = __webpack_require__(1) ? function(object, key, value){
  return dP.f(object, key, createDesc(1, value));
} : function(object, key, value){
  object[key] = value;
  return object;
};

/***/ }),
/* 27 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = !__webpack_require__(1) && !__webpack_require__(2)(function(){
  return Object.defineProperty(__webpack_require__(22)('div'), 'a', {get: function(){ return 7; }}).a != 7;
});

/***/ }),
/* 28 */
/***/ (function(module, exports, __webpack_require__) {

// fallback for non-array-like ES3 and non-enumerable old V8 strings
var cof = __webpack_require__(20);
module.exports = Object('z').propertyIsEnumerable(0) ? Object : function(it){
  return cof(it) == 'String' ? it.split('') : Object(it);
};

/***/ }),
/* 29 */
/***/ (function(module, exports, __webpack_require__) {

var anObject       = __webpack_require__(18)
  , IE8_DOM_DEFINE = __webpack_require__(27)
  , toPrimitive    = __webpack_require__(39)
  , dP             = Object.defineProperty;

exports.f = __webpack_require__(1) ? Object.defineProperty : function defineProperty(O, P, Attributes){
  anObject(O);
  P = toPrimitive(P, true);
  anObject(Attributes);
  if(IE8_DOM_DEFINE)try {
    return dP(O, P, Attributes);
  } catch(e){ /* empty */ }
  if('get' in Attributes || 'set' in Attributes)throw TypeError('Accessors not supported!');
  if('value' in Attributes)O[P] = Attributes.value;
  return O;
};

/***/ }),
/* 30 */
/***/ (function(module, exports, __webpack_require__) {

var has          = __webpack_require__(25)
  , toIObject    = __webpack_require__(8)
  , arrayIndexOf = __webpack_require__(19)(false)
  , IE_PROTO     = __webpack_require__(34)('IE_PROTO');

module.exports = function(object, names){
  var O      = toIObject(object)
    , i      = 0
    , result = []
    , key;
  for(key in O)if(key != IE_PROTO)has(O, key) && result.push(key);
  // Don't enum bug & hidden keys
  while(names.length > i)if(has(O, key = names[i++])){
    ~arrayIndexOf(result, key) || result.push(key);
  }
  return result;
};

/***/ }),
/* 31 */
/***/ (function(module, exports, __webpack_require__) {

// 19.1.2.14 / 15.2.3.14 Object.keys(O)
var $keys       = __webpack_require__(30)
  , enumBugKeys = __webpack_require__(23);

module.exports = Object.keys || function keys(O){
  return $keys(O, enumBugKeys);
};

/***/ }),
/* 32 */
/***/ (function(module, exports, __webpack_require__) {

// most Object methods by ES6 should accept primitives
var $export = __webpack_require__(24)
  , core    = __webpack_require__(0)
  , fails   = __webpack_require__(2);
module.exports = function(KEY, exec){
  var fn  = (core.Object || {})[KEY] || Object[KEY]
    , exp = {};
  exp[KEY] = exec(fn);
  $export($export.S + $export.F * fails(function(){ fn(1); }), 'Object', exp);
};

/***/ }),
/* 33 */
/***/ (function(module, exports) {

module.exports = function(bitmap, value){
  return {
    enumerable  : !(bitmap & 1),
    configurable: !(bitmap & 2),
    writable    : !(bitmap & 4),
    value       : value
  };
};

/***/ }),
/* 34 */
/***/ (function(module, exports, __webpack_require__) {

var shared = __webpack_require__(35)('keys')
  , uid    = __webpack_require__(40);
module.exports = function(key){
  return shared[key] || (shared[key] = uid(key));
};

/***/ }),
/* 35 */
/***/ (function(module, exports, __webpack_require__) {

var global = __webpack_require__(3)
  , SHARED = '__core-js_shared__'
  , store  = global[SHARED] || (global[SHARED] = {});
module.exports = function(key){
  return store[key] || (store[key] = {});
};

/***/ }),
/* 36 */
/***/ (function(module, exports, __webpack_require__) {

var toInteger = __webpack_require__(7)
  , max       = Math.max
  , min       = Math.min;
module.exports = function(index, length){
  index = toInteger(index);
  return index < 0 ? max(index + length, 0) : min(index, length);
};

/***/ }),
/* 37 */
/***/ (function(module, exports, __webpack_require__) {

// 7.1.15 ToLength
var toInteger = __webpack_require__(7)
  , min       = Math.min;
module.exports = function(it){
  return it > 0 ? min(toInteger(it), 0x1fffffffffffff) : 0; // pow(2, 53) - 1 == 9007199254740991
};

/***/ }),
/* 38 */
/***/ (function(module, exports, __webpack_require__) {

// 7.1.13 ToObject(argument)
var defined = __webpack_require__(6);
module.exports = function(it){
  return Object(defined(it));
};

/***/ }),
/* 39 */
/***/ (function(module, exports, __webpack_require__) {

// 7.1.1 ToPrimitive(input [, PreferredType])
var isObject = __webpack_require__(4);
// instead of the ES6 spec version, we didn't implement @@toPrimitive case
// and the second argument - flag - preferred type is a string
module.exports = function(it, S){
  if(!isObject(it))return it;
  var fn, val;
  if(S && typeof (fn = it.toString) == 'function' && !isObject(val = fn.call(it)))return val;
  if(typeof (fn = it.valueOf) == 'function' && !isObject(val = fn.call(it)))return val;
  if(!S && typeof (fn = it.toString) == 'function' && !isObject(val = fn.call(it)))return val;
  throw TypeError("Can't convert object to primitive value");
};

/***/ }),
/* 40 */
/***/ (function(module, exports) {

var id = 0
  , px = Math.random();
module.exports = function(key){
  return 'Symbol('.concat(key === undefined ? '' : key, ')_', (++id + px).toString(36));
};

/***/ }),
/* 41 */
/***/ (function(module, exports, __webpack_require__) {

// 19.1.2.14 Object.keys(O)
var toObject = __webpack_require__(38)
  , $keys    = __webpack_require__(31);

__webpack_require__(32)('keys', function(){
  return function keys(it){
    return $keys(toObject(it));
  };
});

/***/ })
/******/ ]);