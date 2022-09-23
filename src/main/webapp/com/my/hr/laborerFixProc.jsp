<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ page import='java.time.LocalDate' %>
<%@ page import='java.time.format.DateTimeFormatter'%>
<%@ page import='com.my.hr.service.LaborerService, com.my.hr.service.LaborerServiceImpl' %>
<%@ page import='com.my.hr.domain.Laborer' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%	LaborerService laborerService = new LaborerServiceImpl();

	if( request.getParameter("laborerId") != null ) {
		int laborerId = Integer.parseInt(request.getParameter("laborerId"));
		String laborerName = request.getParameter("laborerName");
		LocalDate hireDate = LocalDate.parse(request.getParameter("hireDate"), DateTimeFormatter.ISO_DATE);
		
		laborerService.fixLaborer(
			new Laborer(laborerId, laborerName,	hireDate));
%>
	<jsp:forward page='laborer.jsp'/>
<%
	} else {
%>
		<c:redirect url='laborer.jsp'>
			<c:param name='error' value='fixError'/>
		</c:redirect>
<%	
	}
%>