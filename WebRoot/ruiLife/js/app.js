var basePath = "http://www.rqbao.com/rqb";
var localPath = "http://www.rqbao.com";
var rlifePath = "http://www.rqbao.com/life";

//var basePath = "http://test.rqbao.com/rqb";
//var localPath = "http://test.rqbao.com/";
//var rlifePath = "http://test.rqbao.com/life";
//var basePath = "http://localhost/rqb";
//var localPath = "http://localhost/rqt";
//var rlifePath = "http://localhost/rlife";
/*首页angular单页面切换*/
angular.module('rqb', ['ngRoute'])
/*瑞服务*/
.controller('serviceCtrl',["$scope","$http", function ($scope,$http) {
	var data = {
		kind:'00',
		pageSize:'50'
	}
	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
    $http.post(basePath + '/appRlifeGoods/rLifeGoodsList.do',data, postCfg)
		.success(function(data) {
			/*console.log(data);*/
			$scope.rLifeGoods = data.list;
	});
    
    
    data = {
		type:'00'
	}
	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
    $http.post(basePath + '/appRlifeGoods/getGoodsByType.do',data, postCfg)
	.success(function(data) {
		$scope.bannerGoods = data;
		/*$scope.id0='';
		$scope.id1='';
		$scope.id2='';
		$scope.imgUrl0='';
		$scope.imgUrl1='';
		$scope.imgUrl2='';
		if (data != null && data != '') {
			$scope.id0=data[0].id;
			$scope.id1=data[1].id;
			$scope.id2=data[2].id;
			$scope.imgUrl0=data[0].imgUrl;
			$scope.imgUrl1=data[1].imgUrl;
			$scope.imgUrl2=data[2].imgUrl;
		}*/
	});
}])

/*瑞友汇*/
.controller('FriendCtrl',["$scope","$http", function ($scope,$http) {
	var data = {
		kind:'01',
		pageSize:'50'
	}
	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
    $http.post(basePath + '/appRlifeGoods/rLifeGoodsList.do',data, postCfg)
		.success(function(data) {
			// console.log(data);
			$scope.rLifeGoods = data.list;
	});
    
    data = {
		type:'01'
	}
	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
    $http.post(basePath + '/appRlifeGoods/getGoodsByType.do',data, postCfg)
	.success(function(data) {
		$scope.bannerGoods = data;
		/*$scope.id0='';
		$scope.id1='';
		$scope.id2='';
		$scope.imgUrl0='';
		$scope.imgUrl1='';
		$scope.imgUrl2='';
		if (data != null && data != '') {
			$scope.id0=data[0].id;
			$scope.id1=data[1].id;
			$scope.id2=data[2].id;
			$scope.imgUrl0=data[0].imgUrl;
			$scope.imgUrl1=data[1].imgUrl;
			$scope.imgUrl2=data[2].imgUrl;
		}*/
	});
}])

/*VIP专享*/
.controller('VipCtrl', ["$scope","$http",function ($scope,$http) {
	var data = {
		kind:'02',
		pageSize:'50'
	}
	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
    $http.post(basePath + '/appRlifeGoods/rLifeGoodsList.do',data, postCfg)
		.success(function(data) {
			// console.log(data);
			$scope.rLifeGoods = data.list;
	});
    
    data = {
		type:'02'
	}
	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
    $http.post(basePath + '/appRlifeGoods/getGoodsByType.do',data, postCfg)
	.success(function(data) {
		$scope.bannerGoods = data;
		/*$scope.id0='';
		$scope.id1='';
		$scope.id2='';
		$scope.imgUrl0='';
		$scope.imgUrl1='';
		$scope.imgUrl2='';
		if (data != null && data != '') {
			$scope.id0=data[0].id;
			$scope.id1=data[1].id;
			$scope.id2=data[2].id;
			$scope.imgUrl0=data[0].imgUrl;
			$scope.imgUrl1=data[1].imgUrl;
			$scope.imgUrl2=data[2].imgUrl;
		}*/
	});
}])

/*积分兑换*/
.controller('PointsCtrl', ["$scope","$http",function ($scope,$http) {
	var data = {
		kind:'03',
		pageSize:'50'
	}
	transFn = function(data) {
        return $.param(data);
    },
    postCfg = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
        transformRequest: transFn
    };
    $http.post(basePath + '/appRlifeGoods/rLifeGoodsList.do',data, postCfg)
		.success(function(data) {
			// console.log(data);
			$scope.rLifeGoods = data.list;
	});
    
    data = {
    		type:'03'
    	}
    	transFn = function(data) {
            return $.param(data);
        },
        postCfg = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
            transformRequest: transFn
        };
        $http.post(basePath + '/appRlifeGoods/getGoodsByType.do',data, postCfg)
    	.success(function(data) {
    		$scope.bannerGoods = data;
    		/*$scope.id0='';
    		$scope.id1='';
    		$scope.id2='';
    		$scope.imgUrl0='';
    		$scope.imgUrl1='';
    		$scope.imgUrl2='';
    		if (data != null && data != '') {
    			$scope.id0=data[0].id;
    			$scope.id1=data[1].id;
    			$scope.id2=data[2].id;
    			$scope.imgUrl0=data[0].imgUrl;
    			$scope.imgUrl1=data[1].imgUrl;
    			$scope.imgUrl2=data[2].imgUrl;
    		}*/
    	});
}])

/*首页的单页面切换*/
.config(function ($routeProvider) {
    $routeProvider.
    when('/service', {
        templateUrl: 'tpls/service.jsp',
    }).    
    when('/friend', {
        templateUrl: 'tpls/friend.jsp',
    }).
    when('/vip', {
        templateUrl: 'tpls/vip.jsp',
    }).
    when('/points', {
        templateUrl: 'tpls/points.jsp',
    }).
    otherwise({
        redirectTo: '/points'
    });
});

//轮播插件
/*function banner(){
	var mySwiper = new Swiper('.swiper-container',{
		pagination : '.swiper-pagination',
		pcontentaginationClickable :true,
		autoplay:2000,
	})
}*/
