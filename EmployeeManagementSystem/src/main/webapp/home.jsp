<%@page import="java.util.Set"%>
<%@page import="com.MainApp.Entity.Employee"%>
<%@page import="java.util.List"%>
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

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
	crossorigin="anonymous"></script>
	
<style type="text/css">
	#box, #box2{
		position: absolute;
		left: 3rem;
		top:7rem;
	}
	#box1{
		position: absolute;
		right: 3rem;
		top:7rem;
		width: 60%;
		height: 80vh;
		overflow: auto;
	}
	
</style>


</head>


<body class="bg-white">


	<%
	String token = (String) session.getAttribute("token");
	if (token != null) {
	%>
	
	<%
	Set<String> s=(Set<String>) request.getAttribute("des");
	%>
	
	
	<!-- navbar start -->
	
	<nav class="navbar navbar-expand-lg bg-primary shadow-sm">
		<div class="container-fluid">
			<h1 class="text-light display-6 fw-bolder navbar-brand">Hello, <%=token %></h1>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="btn btn-outline-light"
						aria-current="page" href="user-signout">SignOut</a></li>
					<li class="nav-item dropdown ">
				          <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				            Designation
				          </a>
				          <ul class="dropdown-menu">
				            <%
				            for(String ds:s)
				            {
				            	%>
				            	<li><a class="dropdown-item" href="/filter?des=<%=ds %>"><%=ds %></a></li>
				            	<%
				            }
				            %>
				          </ul>
        			</li>
				</ul>
				<form action="search-employee" method="post" class="d-flex" role="search">
					<input class="form-control me-2" type="search" placeholder="Search by id"
						aria-label="Search" name="id"/>
					<button class="btn btn-outline-warning" type="submit">Search</button>
				</form>
				<form action="remove-filter" method="post" class="d-flex" role="search">
					<button class="btn-close" type="submit"></button>
				</form>
			</div>
		</div>
	</nav>
	
	
	<!-- navbar end -->
	
	
	
	<!-- id, Name, salary, de, profile picture, date of join -->
	
	
	<!-- form start -->
		<section class="container w-25 border rounded-3 bg-light " id="box">
			<div class="row mb-3">
				<div class="col-md-12 bg-primary border rounded-3 p-3">
					<div>
						<p class="fs-5 text-center text-white">Enter Employee Information</p>
					</div>
				</div>
			</div>
			<form action="add-employee" method="post" enctype="multipart/form-data">
			<div class="row g-3">
				<div class="col-md-6">
					<div>
						<label for="id" class="form-label form-label-sm">Employee Id</label>
						<input class="form-control form-control-sm" type="text" name="id" id="id">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="name" class="form-label form-label-sm">Employee Name</label>
						<input class="form-control form-control-sm" type="text" name="name" id="name">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="salary" class="form-label form-label-sm">Employee Salary</label>
						<input class="form-control form-control-sm" type="number" name="salary" id="salary">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="designation" class="form-label form-label-sm">Employee Designation</label>
						<input class="form-control form-control-sm" type="text" name="designation" id="designation">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="picture" class="form-label form-label-sm">Upload Profile Picture</label>
						<input class="form-control form-control-sm" type="file" name="picture" id="picture">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="date" class="form-label form-label-sm">Employee Date of Joining</label>
						<input class="form-control form-control-sm" type="date" name="date" id="date">
					</div>
				</div>
				<div class="col-md-4 offset-md-3 mb-3">
					<div>
						<button class="btn btn-primary">Add Employee</button>
					</div>
				</div>
			</div>
			<input type="hidden" name="username" value="<%=token%>">
			</form>
		</section>
	<!-- form end -->
	
	
	
	
	
	
	<!-- 
	display Employee Start
	 -->
<%
List<Employee> l=(List<Employee>) request.getAttribute("l");
%>	 

	 <section class="container border rounded-3" id="box1">
	 	<div class="row bg-primary rounded-3 p-3">
	 		<div class="col-md-12">
	 			<h1 class="text-center text-white display-6">Employees Information</h1>
	 		</div>
	 	</div>
	 	<div class="row g-3 p-5">
	 		<%
	 		for(Employee e:l)
	 		{
	 			%>
	 			<div class="col-md-4">
	 				<div class="container border rounded-3 p-3  bg-light">
	 					<img class="rounded-3 mb-2" alt="loading..." src="/images/<%=e.getPictureName()%>" width="150">
	 					<h5 class="card-title">Id :<%=e.getId() %>, Name : <%=e.getName() %></h5>
						<p class="card-text">Designation : <%=e.getDesignation() %></p>
						<p class="card-text">Salary : <%=e.getSalary() %></p>
						<p class="card-text">Join Date : <%=e.getDate() %></p>
						<form action="delete-employee" method="post">
							<input type="hidden" name="id" value="<%=e.getId()%>">
							<button class="btn btn-sm btn-outline-danger">Delete</button>
						</form>
						
						<form action="get-employee" method="post">
							<input type="hidden" name="id" value="<%=e.getId()%>">
							<button  class="btn btn-sm btn-outline-primary">Edit</button>
						</form>
						
	 				</div>
	 			</div>
	 			<%
	 		}
	 		if(l.size() == 0)
	 		{
	 			%>
	 			<h1 class="text-center text-danger display-6">Employee's Not Added</h1>
	 			<%
	 		}
	 		%>
	 		
	 	</div>
	 </section>
	 
	 
	 <!-- 
	display Employee end
	 -->
	
	
	
	
	
	
	<!-- 
	edit form start
	 -->
	<%
	Employee e=(Employee) session.getAttribute("e");
	if(e != null)
	{
		%>
		<section class="container w-25 border rounded-3 bg-light " id="box2">
			<div class="row mb-3">
				<div class="col-md-12 bg-primary border rounded-3 p-3">
					<div>
						<p class="fs-5 text-center text-white">Edit Employee Information</p>
						<button onclick="closebox()" class="bg-white btn-close"></button>
					</div>
				</div>
			</div>
			<form action="add-employee" method="post" enctype="multipart/form-data">
			<div class="row g-3 p-3">
				<div class="col-md-6">
					<div>
						<label for="id" class="form-label form-label-sm">Employee Id</label>
						<input class="form-control form-control-sm" type="text" name="id" id="id" value="<%=e.getId()%>">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="name" class="form-label form-label-sm">Employee Name</label>
						<input class="form-control form-control-sm" type="text" name="name" id="name" value="<%=e.getName()%>">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="salary" class="form-label form-label-sm">Employee Salary</label>
						<input class="form-control form-control-sm" type="number" name="salary" id="salary" value="<%=e.getSalary()%>">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="designation" class="form-label form-label-sm">Employee Designation</label>
						<input class="form-control form-control-sm" type="text" name="designation" id="designation" value="<%=e.getDesignation()%>">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="picture" class="form-label form-label-sm">Upload Profile Picture</label>
						<input class="form-control form-control-sm" type="file" name="picture" id="picture">
					</div>
				</div>
				<div class="col-md-6">
					<div>
						<label for="date" class="form-label form-label-sm">Employee Date of Joining</label>
						<input class="form-control form-control-sm" type="date" name="date" id="date" value="<%=e.getDate()%>">
					</div>
				</div>
				<div class="col-md-4 offset-md-3 mb-3">
					<div>
						<button class="btn  btn-primary" onclick="closebox()">Save Changes</button>
					</div>
				</div>
			</div>
			<input type="hidden" name="username" value="<%=token%>">
			</form>
		</section>
		<%
	}
	session.removeAttribute("e");
	%>
	
	
	<!-- 
	Edit form end
	 -->
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<script type="text/javascript">
		function closebox()
		{
			document.getElementById("box2").style.display="none";
		}
	</script>
	
	
	
	
	
	
	
	<%
	} else {
	session.setAttribute("msg", "First Signin An then Access Home page");
	response.sendRedirect("signin.jsp");
	}
	%>
















</body>
</html>