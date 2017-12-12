(function(){
    var LSwiperMaker = function(o){ 
        var that = this;
        this.config = o;
        this.control = false;
        this.sPos = {};
        this.mPos = {};
        this.dire;
 
        // this.config.bind.addEventListener('touchstart', function(){ return that.start(); } ,false);
        // 这样不对的，event对象只在事件发生的过程中才有效;
        this.config.bind.addEventListener('touchstart', function(e){ return that.start(e); } ,false);
        this.config.bind.addEventListener('touchmove', function(e){ return that.move(e); } ,false);
        this.config.bind.addEventListener('touchend', function(e){ return that.end(e); } ,false);
    }
 
    LSwiperMaker.prototype.start = function(e){
         
         var point = e.touches ? e.touches[0] : e;
         this.sPos.x = point.screenX;
         this.sPos.y = point.screenY;
    }
    LSwiperMaker.prototype.move = function(e){  
 
        var point = e.touches ? e.touches[0] : e;
        this.control = true;
        this.mPos.x = point.screenX;
        this.mPos.y = point.screenY;
    }
 
    LSwiperMaker.prototype.end = function(e){
 
        this.config.dire_h  && (!this.control ? this.dire = null : this.mPos.x > this.sPos.x ? this.dire = 'R' : this.dire = 'L')
        this.config.dire_h  || (!this.control ? this.dire = null : this.mPos.y > this.sPos.y ? this.dire = 'D' : this.dire = 'U')
 
        this.control = false;
        this.config.backfn(this);
    }
    window.LSwiperMaker = LSwiperMaker;
    document.addEventListener('touchmove', function (e) {
    	e.preventDefault(); 
    	/*var XX = this.sPos.x;
    	var xx = this.mPos.x;
    	var YY = this.sPos.y;
    	var yy = this.mPos.y;
    	if(Math.abs(XX-xx)-Math.abs(YY-yy)>0)  //左右滑动
        {
            e.stopPropagation();//组织冒泡
            e.preventDefault();//阻止浏览器默认事件
            //左右滑动
        }
        else if(Math.abs(XX-xx)-Math.abs(YY-yy)<0){  //上下滑动
            //上下滑动，使用浏览器默认的上下滑动
        }*///加上这句android失效
    }, false);// 禁止微信touchmove冲突
 
}())

function addSwipe(id,dire,eve){
	var a = new LSwiperMaker({
		bind : document.getElementById(id), // 绑定的DOM对象
		dire_h : true, //true 判断左右， false 判断上下
		backfn : function(o) { //回调事件
			if (dire == o.dire && "R" == o.dire) {
				eve();
			} else if (dire == o.dire && "L" == o.dire) {
				eve();
			}
		}
	})
}
