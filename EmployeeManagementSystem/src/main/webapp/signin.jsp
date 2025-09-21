<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
	crossorigin="anonymous">
</head>
<body class="bg-white">


<%
String msg=(String)session.getAttribute("msg");
if(msg == null)
{
	msg="";
}
session.removeAttribute("msg");
%>

<section class="container border rounded-3 w-50 bg-light" style="margin-top: 10rem;">
	<div class="row mb-3 bg-primary p-3 text-white fw-bold border rounded-3">
		<div class="col-md-12">
			<div>
				<h1 class="display-6">Please Signin to Your Account</h1>
				<p class="bg-danger border rounded-2"><%=msg %></p>
			</div>
		</div>  
	</div>
	<form action="user-signin" method="post" onsubmit="return validation()">
	<div class="row g-2 p-3">
		<div class="col-md-6">
			<div>
				<label class="form-label" for="uname">Enter UserName</label>
				<input class="form-control" type="text" name="username" id="uname">
				<p class="form-text text-danger" id="uerror"></p>
			</div>
		</div>
		<div class="col-md-6">
			<div>
				<label class="form-label" for="upass">Enter Password</label>
				<input class="form-control" type="password" name="password" id="upass">
				<p class="form-text text-danger" id="perror"></p>
			</div>
		</div>
		<div class="col-md-5 offset-md-5">
			<div>
				<button class="btn btn-primary">SignIn</button>
			</div>
		</div>
	</div>
	</form>
</section>
<p class="text-center lead m-2">powered By Seed Infotech Ltd.</p>









<script type="text/javascript">

	function validation()
	{
		let username=document.getElementById("uname").value;

		let pass=document.getElementById("upass").value;
		
		
		if(username == "")
		{
			document.getElementById("uerror").innerHTML='Please Enter Username';
			return false;
		}

		if(pass == "")
		{
			document.getElementById("perror").innerHTML='Please Enter Password';
			return false;
		}
	

	}

</script>




















</body>
</html>