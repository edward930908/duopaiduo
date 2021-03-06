<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
String path = request.getContextPath();
String basePath = "http://jiu.dobado.cn/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>"/>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords" content="酒,酒业,白酒,葡萄酒,啤酒,果酒,酱香酒,浓香酒,米香酒,贵香坊,酒业资讯,多拍多酒业" /> 
<meta name="description" content="多拍多酒业频道，以互联网+的媒体视野，权威、深刻的独立视角，全景呈现酒类舆情走向、市场趋势、产业转型、业态创新、消费价值，融合酒业新生态，创领酒道新主流。多拍多酒业，让饮酒更更快乐。" />
<title>餐饮美食</title>
<link rel="Stylesheet" href="css/style.css" type="text/css" />
<link rel="Stylesheet" href="css/index.css" type="text/css" />
<!-- jQuery -->
<script type="text/javascript" src="js/public/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/public/bootstrap.min.js"></script>
<script type="text/javascript" src="js/public/layer/layer.js"></script>
<script type="text/javascript" src="js/public/laypage/laypage.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript">
function loadHeight(){
	parent.document.getElementById('centerFrame').style.height = ($("#container").height()+50)+'px';
}
$(function(){
	info();
	pageData(1,0);
});
function info(){
	$.ajax({
		url : "canyinData",
		type : 'POST',
		dataType : 'JSON',
		async:false,
		success : function(data) {
			//var datas=JSON.parse(data);
			console.log(data);
			//头轮播图
			var active='';
			var htm='<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">'
				   +'<!-- Indicators -->'
				   +'<ol class="carousel-indicators">';
				   for(var j=0;j<data.banner.length;j++){
					   if(j==0){
							active="active";
						}else{
							active="";
						}
					   htm +='<li data-target="#carousel-example-generic" data-slide-to="'+j+'" class="'+active+'"></li>';
				   }
				   htm +='</ol>';
				   htm +='<div class="carousel-inner" role="listbox">';
			$.each(data.banner,function(i,obj){
				if(i==0){
					active="active";
				}else{
					active="";
				}
				htm +='<div class="item '+active+'">';
				htm +='<a href="http://'+obj.url+'" >';
				htm +='<img src="'+obj.uri+'" alt="'+obj.title+'">';
				htm +='<div class="carousel-caption">';
				htm +=obj.title;
				htm +='</div></a>';
				htm +=' </div>';
			});
			htm +='</div></div>';
			$("#banner").html(htm);
			
			var paihangbang = '';
			$.each(data.paihang,function(i,obj){
                
                paihangbang +='<div class="article clearfix">';
                paihangbang +='<img style="width: 120px; height: 100px;" src="'+obj.img_uri+'" alt="">';
                paihangbang +='<div><h4 class="img"><a href="article?articleid='+obj.article_id+'" target="view_window">'+obj.title+'</a></h4>';
                paihangbang +='<p class="img">'+obj.content_summary+'</p>';
                paihangbang +='</div></div>';
            });
            $("#paihangbang").html(paihangbang);
            
            var xinwen = '';
            $.each(data.xinwen,function(i,obj){
                
                xinwen +='<div class="article clearfix">';
                xinwen +='<img style="width: 120px; height: 100px;" src="'+obj.img_uri+'" alt="">';
                xinwen +='<div><h4 class="img"><a href="article?articleid='+obj.article_id+'" target="view_window">'+obj.title+'</a></h4>';
                xinwen +='<p class="img">'+obj.content_summary+'</p>';
                xinwen +='</div></div>';
            });
			$("#xinwen").html(xinwen);
			
			var titleHtm = '';
			$.each(data.title,function(i,obj){
				titleHtm +='<a href="javascript:pageData(1,'+obj.article_id+');" >'+obj.title+'</a>';
			});
			$("#dongtaihtm").html(titleHtm);
		},
		error : function() {
			alert("网络异常！");
		}
	});
};

function pageData(curr,fpid){
	var fpids;
	if(fpid!=-1){fpids = fpid}
	$.ajax({
		url : "pageData",
		type : 'POST',
		dataType : 'JSON',
		data:{page: curr,rows : 7,aids : 30,fpid : fpids},
		async:false,
		success : function(data) {
			//var datas=JSON.parse(data);
			console.log(data);
			var boodhtm='';
			$.each(data.list,function(i,obj){
				
                boodhtm +='<div class="article clearfix">';
                boodhtm +='<img style="width: 120px; height: 120px;" src="'+obj.img_uri+'" alt="'+obj.title+'">';
                boodhtm +='<div><h4 class="img"><a href="article?articleid='+obj.article_id+'" target="view_window">'+obj.title+'</h4></a>';
                boodhtm +='<summary>'+obj.add_time+'</summary>';
                boodhtm +='<p class="img">'+obj.content_summary+'</p>';
                boodhtm +='</div></div>';
			});
			$("#boodhtm").html(boodhtm);
			laypage({
	             cont: 'paging', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
	             pages: (data.totalPage),   //通过后台拿到的总页数
	             curr: curr, //当前页
	             skin: 'yahei',
	             jump: function(obj, first){ //触发分页后的回调
	                 if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
	                	 pageData(obj.curr,-1);
	                 }
	             }
	         });
			loadHeight();
		},
		error : function() {
			alert("网络异常！");
		}
	});
}
</script>
</head>

<body id="container">

<div class="thewidth100">
<!--wrap-->
    <div class="wrap_bg thewidth100 dongtai">    
        <div class="wrap thewidth ">
            <div  class="index3 clearfix">
            <!-- index3左 -->
              <div class="f_l">
                  <h3 class="small">
                    <span onclick="pageData(1,0)" class="c_lan">餐饮美食</span>
                    <div id="dongtaihtm" class="small_l">
                      
                    </div>
                    
                  </h3>
                  <div id="banner" class="index1">
                    <!--banner轮转-->
                  </div>
                  <div id="boodhtm" class="dongtai_1">
                       <!--主体-->  
                  </div>
                  <div class="paging" id="paging" style="eight: 100px">
                    
                  </div>
                        
              </div>
               <!-- /index3左 -->
              <!-- index3右 -->
              <div class="f_r">
                  <h3 class="small">
                    <span class="c_lan">推荐排行榜</span>
                  </h3>
                  <div id="paihangbang" class="dongtai_2">
                        <div class="article clearfix">
                          <a href="javascript:;">
                            <img style="width: 120px; height: 100px;" src="images/index/index_27.jpg" alt="">
                            <h4 class="img">中国白酒成功拓展非洲市场</h4>
                            <p class="img">在由区域共同体连接成贯穿非洲大陆的自由贸易区内，本土产品零土产品零土产品零土产品零土产品零土产品零</p>
                          </a>
                        </div>
                        <div class="article clearfix">
                          <a href="javascript:;">
                            <img src="images/index/index_30.jpg" alt="">
                            <h4 class="img">中国白酒成功拓展非洲市场</h4>
                            <p class="img">在由区域共同体连接成贯穿非洲大陆的自由贸易区内，本土产品零土产品零土产品零土产品零土产品零土产品零</p>
                          </a>
                        </div>
                        <div class="article clearfix">
                          <a href="javascript:;">
                            <img src="images/index/index_36.jpg" alt="">
                            <h4 class="img">中国白酒成功拓展非洲市场</h4>
                            <p class="img">在由区域共同体连接成贯穿非洲大陆的自由贸易区内，本土产品零土产品零土产品零土产品零土产品零土产品零</p>
                          </a>
                        </div>
                  </div>

<div class="mt_40">
  

                  <h3 class="small">
                    <span class="c_lan">热门新闻</span>
                  </h3>
                  <div id="xinwen" class="dongtai_2">
                        <div class="article clearfix">
                          <a href="javascript:;">
                            <img src="images/index/index_27.jpg" alt="">
                            <h4 class="img">中国白酒成功拓展非洲市场</h4>
                            <p class="img">在由区域共同体连接成贯穿非洲大陆的自由贸易区内，本土产品零土产品零土产品零土产品零土产品零土产品零</p>
                          </a>
                        </div>
                        <div class="article clearfix">
                          <a href="javascript:;">
                            <img src="images/index/index_30.jpg" alt="">
                            <h4 class="img">中国白酒成功拓展非洲市场</h4>
                            <p class="img">在由区域共同体连接成贯穿非洲大陆的自由贸易区内，本土产品零土产品零土产品零土产品零土产品零土产品零</p>
                          </a>
                        </div>
                        <div class="article clearfix">
                          <a href="javascript:;">
                            <img src="images/index/index_36.jpg" alt="">
                            <h4 class="img">中国白酒成功拓展非洲市场</h4>
                            <p class="img">在由区域共同体连接成贯穿非洲大陆的自由贸易区内，本土产品零土产品零土产品零土产品零土产品零土产品零</p>
                          </a>
                        </div>
                  </div>
</div>
              </div>
              <!-- /index3右 -->
          </div>
          <!-- /index3 -->
        </div>    
    </div>
<!--/wrap-->
</div>
</body>
</html>