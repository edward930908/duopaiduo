<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>文章管理</title>
<link rel="Stylesheet" href="css/style.css" type="text/css" />
<link rel="Stylesheet" href="css/public/font-awesome.min.css" type="text/css" />
<!-- jQuery -->
<script type="text/javascript" src="js/public/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/public/bootstrap.min.js"></script>
<script type="text/javascript" src="js/public/layer/layer.js"></script>
<script type="text/javascript" src="js/public/laydate/laydate.js"></script>
<script type="text/javascript" src="js/public/laypage/laypage.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">
	$(function(){
			if($.cookie('name') != null && $.cookie('name') != ""){
				 $("#sp").html( $.cookie('name'));
				 $.ajax({
						url : "wzfenleiData",
						type : 'POST',
						dataType : 'JSON',
						async:false,
						success : function(data) {
							//var datas=JSON.parse(data.list);
							var datas=eval(data);
							//console.log(datas);
							var htm = ' <option value=0 >所属文章分类</option>';
							$.each(datas.list,function(i,obj){
								htm +=' <option value='+obj.article_category_id+'>'+obj.article_category_name+'</option>';
							});
							$("#xiala").html(htm);
						},
						error : function() {
							alert("网络异常！");
						}
					});
					erjigaibian(1);
			 }else{
				 layer.msg("登录超时！");
				window.location.href="login.jsp";
			 }
		
	});
	
	function erjigaibian(curr){
		 var articleCategoryId=$('#xiala').val();
		 var isShow=$('#xians').val();
		 var wenztitle=$("#wenztitle").val();
		 var addTime=$("#addTime").val();
		 
		 $.ajax({
				url : "wzleirongData1",
				type : 'POST',
				dataType : 'JSON',
				data : {
					articleCategoryId : articleCategoryId,
					isShow : isShow,
					wenztitle:wenztitle,
					addTime:addTime,
					page: curr,
					rows : 10
					},
				//async:false,
				success : function(data) {
					//var datas=JSON.parse(data);
					var datas = eval(data);
					//console.log(datas);
					var neirhtm = '';
					$.each(datas.list,function(i,obj){
						neirhtm +='<tr>';
						neirhtm +='<td><input type="checkbox" name="" value="" placeholder=""></td>';
						neirhtm +='<td>'+obj.title+'</td>';
						neirhtm +='<td>'+obj.article_category_name+'</td>';
						neirhtm +='<td>'+obj.add_time+'</td>';
						if(obj.status==0)
							neirhtm +='<td>未审核</td>';
						neirhtm +='<td>';
							 neirhtm +='<a href="upshwenz?articleId='+obj.article_id+'" ><button type="submit" class="btn btn-default ">去审核</button></a>';
						neirhtm +='</td>';
						neirhtm +='<tr>';
					});
					
					$("#neirhtm").html(neirhtm);
					
					laypage({
					    cont: 'page', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
					    pages: (datas.totalPage),   //通过后台拿到的总页数
					    curr: curr, //当前页
					    jump: function(obj, first){ //触发分页后的回调
					        if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
					        	$("#pages").val(obj.curr);
					       	erjigaibian(obj.curr)
					        }
					    }
					});
				},
				error : function() {
					alert("网络异常！");
				}
		 });
	 }
	
</script>
</head>

<body>

<div id="container" class="thewidth100">

<!--header-->
    <div class="header_bg clearfix thewidth100"> 
        <div class="header_top clearfix">
            <div class="f_l">多拍多资讯站后台管理</div> 
            <div class="f_r">欢迎 <span id="sp"></div>
        </div>
        <div class="header">
        
            <nav>
                <ul>
                    <li><a href="">管理首页</a></li>
                    <li><a href="wenz.jsp"  class="choice">文章管理</a></li>
                    <li><a href="advert.jsp">广告管理</a></li>
                    <li><a href="">用户管理</a></li>
                    <li><a href="">评论管理</a></li>
                    <li><a href="system.jsp">系统管理</a></li>
                </ul>
            </nav>
        </div>
    </div>
<!--------------------------------------[ header ]-------------------------------------->


<!--wrap-->
    <div class="wrap_bg thewidth100">    
        <div class="wrap clearfix bghui">

            <div class="wrap_l">
            <h2>审核文章列表</h2>
                <ul>
                    <li><a href="wenz.jsp">多拍多资讯文章列表</a></li>
                    <li><a href="addWenz.jsp">添加资讯文章</a></li>
                    <li><a href=""  class="choice">审核文章列表</a></li>
                </ul>
            </div>
            <div class="wrap_r">
                <div class="clearfix SearchOperation">
                <form class="form-inline f_l">
                      <div class="form-group">
                            <label for="">搜索时间</label>
                            <input  type="text" class="form-control" id="addTime" placeholder="添加时间">
                            <span class="laydate-icon" onclick="laydate({elem: '#addTime'});"></span>
                      </div>
                      <div class="form-group ma_l20">
                            <label for="">文章名称</label>
                            <input type="email" class="form-control" id="wenztitle" placeholder="输入搜索文章名称">
                      </div>
                      <button type="button" onclick="erjigaibian(1)" class="btn btn-default ma_l20">搜索</button>
                </form>
                <a href="addWenz.jsp"><button type="button" class="btn btn-default f_r">添加</button></a>
                </div>
                <input type="hidden" id="pages" valur="" />
                <div class="table">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th><input type="checkbox" name="" value="" placeholder=""></th>
                                <th>文章标题</th>
                                <th>
                                     <select onchange="erjigaibian(1)" id="xiala" class="form-control flei">
                                    </select>
                                </th>
                                <th>添加时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="neirhtm">
                        </tbody>
                    </table>
                </div>
                <div id="page"></div>
            </div>
        </div>    
    </div>
<!--/wrap-->


<!--------------------------------------[ footer ]-------------------------------------->
    <div class="footer_bg thewidth100">
        <div class="footer">
        
        
        
        </div>
    </div>
<!--/footer-->

</div>


</body>
</html>