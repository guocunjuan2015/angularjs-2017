//function getDoc(id){return(document.getElementById(id))} 
function coculateOffset(ele){
    var node = $("#"+ele)[0];
    var orignalHeight = node.style.height;
    var orignalDisplay = node.style.display;
    node.style.height = "";
    node.style.display = "block";
    var h = node.offsetHeight;
    node.style.height = orignalHeight;
    node.style.display = orignalDisplay;
    return(h);
}
//显示元素
function showEle(ele){
    var h = coculateOffset(ele)
    var i = 1;
    var t = setInterval(function(){
        i += i;
        $("#"+ele).style.height = i + "px";
        $("#"+ele).style.display = "";	
        if( i > h/2){
        	$("#"+ele).style.height = h + "px";
            clearInterval(t);
        }
    },35)
}
//隐藏元素
function hideEle(ele){
    var h = coculateOffset(ele);
    var t = setInterval(function(){
        if(h > 2){
            h = h/2;
        }else{
            h = 0;
            clearInterval(t);
        }
        $("#"+ele).style.height = h + "px";
    },50)
}
//判断显隐
function ShowHide(ele){
    var currentHeight = $(ele).style.display == "none" ? 0 : $(ele).offsetHeight;
	$(ele).style.overflow = "hidden";
    if(currentHeight > 0){
        hideEle(ele);
    }else{
        showEle(ele);
    }
}