<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录</title>
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="shortcut icon" href="resources/admin/favicon.ico" type="image/x-icon" />
	<link rel="apple-touch-icon-precomposed" href="resources/assets/i/app-icon72x72@2x.png">
	<link rel="stylesheet" href="resources/bootstrap-4.4.1/css/bootstrap.min.css"  >
	<link rel="stylesheet" href="resources/assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="resources/assets/css/admin.css">
    <link rel="stylesheet" href="resources/assets/css/app.css">
	<style>
		.valicode{
			border: 1px solid #ccc;
			padding: 7px 0px;
			border-radius: 3px;
			padding-left:5px;
			-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			-webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
			-o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
		}
		.valicode :focus{
			border-color: #66afe9;
			outline: 0;
			-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
			box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
		}
		.center {
			display:inline-block;
			float: left;
			height:50px;
			line-height:50px;
		}
	</style>
    <script src="resources/js/jquery-3.4.1.min.js" ></script>
    <script src="resources/js/json2.js" ></script>
	<script src="resources/js/jquery-ui.js" ></script>
	<script type="text/javascript">
		var flag=false;
		$(function () {
			$("#checkCode").blur(function(){
				var checkCode=$.trim($("#checkCode").val());
                if(checkCode!=null&&checkCode!=""){
				$.ajax({
					url:"./codeCheck",
					type:"post",
					data:{"checkCode":checkCode},
					success:function(data){
						if(data=="ok"){
							flag=true;
						}
						else {
							alert("验证码输入错误！");
							window.location.href="login";
						}
					},
					error:function() { alert("异常！"); }
				});
                }
                else{
                	alert("请输入验证码");
				}
			});
		});
		function myReload() {
			$("#checkCode").val("");
			document.getElementById("CreateCheckCode").src =
					document.getElementById("CreateCheckCode").src+ "?nocache=" + new Date().getTime();
		}
		function check() {
			if(flag!=true){
				alert("请输入验证码");
			}
			else{
				var username = $.trim($("#username").val());
				var password = $.trim($("#password").val());
				console.log(username);
				console.log(password);
				$.ajax({
					url:"loginCheck",
					type:"post",
					data:{"username":username,
						"password":password
					},
					success:function(data){
						console.log("第二个Ajax");
						if(data == "ok"){
							alert("登录成功");
							//console.log(userData);
							window.location.href="admin";
						}
						else {
							alert("用户名或密码错误");
							window.location.href="login";
						}
					},
					error:function(){
						console.log("登录失败");
						alert("异常！，登录失败");
					}
				});
			}

		}
	</script>
</head>
<body data-type="login">
  <div class="am-g myapp-login">
	  <br/>
	  <div class="myapp-login-logo-block  tpl-login-max">
		<div class="myapp-login-logo-text">
			<div class="myapp-login-logo-text">
				Admin <span> Login</span> <i class="am-icon-skyatlas"></i>
				
			</div>
		</div>
		<div class="login-font">
			<i>Login</i>
		</div>
		<div class="am-u-sm-10 login-am-center">
			<form class="am-form" name="form" >
				<fieldset>
					<div class="am-form-group">
						<input type="text" class="" id="username" placeholder="告诉我你的名字" name="username">
					</div>
					<div class="am-form-group">
						<input type="password" class="" id="password" placeholder="输入密码吧" name="password">
					</div>
					<div>
<%--						<div class="center"><a href="#" >验证码</a></div>--%>
						<div class="center"><input type="text" id="checkCode" placeholder="请输入验证码" name="checkCode" class="valicode" style="width: 150px"></div>
						<div style="display:inline-block;float: left;"><img src="pictureCheckCode" id="CreateCheckCode" align="middle" ></div>
						<div class="center"><a href="#" onclick="return myReload();" >看不清,换一个(不区分大小写)</a></div>
					</div>
					<div>

					</div>
					<p><button type="button" onclick="return check();" class="am-btn am-btn-default">登录</button></p>
				</fieldset>
			</form>
		</div>
	</div>
</div>

  <script src="resources/assets/js/jquery.min.js"></script>
  <script src="resources/assets/js/amazeui.min.js"></script>
  <script src="resources/assets/js/app.js"></script>
</body>
</html>