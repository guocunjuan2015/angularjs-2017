(function() {
	window._smConf = {
		organization : 'Jw6PkUNgUvoY41B2E1Wi', // 传入 organization，不要传入 accessKey.
		staticHost : 'static.fengkongcloud.com'
	};
	var url = (function() {
		var originHost = "static2.fengkongcloud.com";
		var isHttps = 'https:' === document.location.protocol;
		var protocol = isHttps ? 'https://' : 'http://';
		var fpJsPath = '/fpv2.js';
		var url = protocol + _smConf.staticHost + fpJsPath;
		var ua = navigator.userAgent.toLowerCase();
		var isWinXP = /windows\s(?:nt\s5.1)|(?:xp)/.test(ua);
		var isLowIE = /msie\s[678]\.0/.test(ua);
		if (isHttps && isWinXP && isLowIE) {
			url = protocol + originHost + fpJsPath;
		}
		return url;
	})();
	var sm = document.createElement("script");
	var s = document.getElementsByTagName("script")[0];
	sm.src = url;
	s.parentNode.insertBefore(sm, s);
})();