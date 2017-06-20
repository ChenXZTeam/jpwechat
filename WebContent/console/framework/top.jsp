<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
        <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<style>
    body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,
form,fieldset,input,textarea,p,blockquote,th,td,a{
	margin:0px;padding:0px;font-family:"微软雅黑";
}
a{text-decoration:none; color: #9D9C9C;}
ul li{list-style:none;}
.clear{clear:both;}

	#header{
		/* width: 100%; */
		height: 79px;
		background-color: rgb(57,110,165);
		background: url("<%=basePath %>images/framework/bg.jpg") repeat-x 0px 0px;
	}
	.logo{
	    margin-top: 17px;
    	margin-left: 20px;
		width:295px;
		height: 59px;
		background: url("<%=basePath %>images/framework/add.png") no-repeat 0px 0px;
		float: left;
	}
	#header ul{
		overflow: hidden;
    	float: right;
	}
	#header ul li{
		float: left;
		list-style: none;
		font-size: 16px;
		color: #fff;
		width: 203px;
		margin-top: 23px;
	}
	#header ul li a{
		
		color: #fff;

	}
</style>

	<div id="header">
		<div class="logo"></div>
		<ul>
			<li> 欢迎你登录：<%=com.solar.tech.util.Current.user().getUserName()%>&nbsp;&nbsp;&nbsp; <a href="logout.action">退出</a>
			</li>
			
		</ul>
	</div>
