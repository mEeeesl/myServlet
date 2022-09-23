<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ page import='java.time.LocalDate' %>
<%@ page import='java.time.format.DateTimeFormatter'%>
<%@ page import='com.my.hr.service.LaborerService, com.my.hr.service.LaborerServiceImpl' %>
<%@ page import='com.my.hr.domain.Laborer' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.js'></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
    <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
    <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.6.3/css/all.css' />
	
<%	LaborerService laborerService = new LaborerServiceImpl(); 

	String laborerName = request.getParameter("laborerName");
	String hireDateStr = request.getParameter("hireDate");
	
	if(laborerName != "" && hireDateStr != "") {
		LocalDate hireDate = LocalDate.parse(request.getParameter("hireDate"), DateTimeFormatter.ISO_DATE);
	
		laborerService.addLaborer(laborerName, hireDate);
%>
		<jsp:forward page='laborer.jsp'/>
<%
	} else {
%>
	<c:redirect url='laborer.jsp'>
		<c:param name='error' value='addError'/>
	</c:redirect>
<%
	}
%>
