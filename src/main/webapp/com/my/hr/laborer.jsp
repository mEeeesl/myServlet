<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ page import='com.my.hr.service.LaborerService, com.my.hr.service.LaborerServiceImpl' %>
<%@ page import='java.util.List, java.util.ArrayList' %>
<%@ page import='java.time.LocalDate' %>
<%@ page import='java.time.LocalDateTime' %>
<%@ page import='java.time.format.DateTimeFormatter' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%	LaborerService laborerService = new LaborerServiceImpl(); %>
<!DOCTYPE html>
<html>
<head>
    <title>hr</title>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <script src='https://code.jquery.com/jquery-3.6.0.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.js'></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
    <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' />
    <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.6.3/css/all.css' />

<%
    	String errMsg = request.getParameter("error");
%>
 	<script type="text/javascript">
 		if( <%= errMsg != null %> ) {
 			$(() => {
 				$('#modal').modal();
 				$('#modalBtn').hide();
 				
	 			switch("<%= errMsg %>") {
	 			case "addError": 
	 				$('#modalMsg').text("이름과 입사일을 입력해주세요.").css('color', 'red'); break;
	 			case "fixError": 
	 				$('#modalMsg').text("수정할 노동자를 선택해주세요.").css('color', 'red'); break;
	 			case "delError": 
	 				$('#modalMsg').text("삭제할 노동자를 선택해주세요.").css('color', 'red');
	 			}
	 			<% errMsg = null; %>
 			})
 		}
 		
		$(document).on('hidden.bs.modal', '#modal', function () {
		    location.href="laborer.jsp" }); 
 	</script>
 	
    <style>
        #hireDate::before {
            content: attr(placeholder);
            width: 100%;
        }

        #hireDate:focus::before,
        #hireDate:valid::before {
            display: none;
        }
    </style>
</head>

<body>
<form>
    <div class='container'>
        <div class='row'>
            <div class='col'>
                <header class='jumbotron p-2'>
                    <h1 class='text-center'>HR</h1>
                </header>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                    <div class='row mb-3'>
                        <div class='col-2'>
                            <input type='text' class='form-control' placeholder='노동자명' id='laborerName' name='laborerName'/>
                        </div>
                        <div class='col-4'>
                            <input type='date' class='form-control' placeholder='입사일' id='hireDate' name='hireDate'/>
                        </div>
                        <div class='col'>
                            <nav class='d-flex'>
                                <button type='submit' formaction='laborerAddProc.jsp' class='btn btn-success flex-fill mr-1' id='addLaborerBtn' formmethod='post'>
                                    <i class='fas fa-plus'></i><span class='label d-none d-sm-inline'>추가</span>
                                </button>
                                <button type='submit' formaction='laborerFixProc.jsp' class='btn btn-info flex-fill mr-1' id='fixLaborerBtn' formmethod='post'>
                                    <i class='fas fa-edit'></i><span class='label d-none d-sm-inline'>수정</span>
                                </button>
                                <button type='button'class='btn btn-warning flex-fill' id='delLaborerBtn'
                                      data-toggle="modal" data-target="#modal">
                                    <i class='fas fa-trash-alt'></i><span class='label d-none d-sm-inline'>삭제</span>
                                </button>
                            </nav>
                        </div>
                    </div>
                    <div class='row'>
                        <div class='col mt-3'>
                            <table class='table'>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>ID</th>
                                        <th>이름</th>
                                        <th>입사일</th>
                                    </tr>
                                </thead>
                                <tbody id='tbody'>
                                        <% 
                                           if(laborerService.getLaborers().size() > 0) {
                                              for(int i = 0; i < laborerService.getLaborers().size(); i++) {
                                        %>
                                           <tr>
                                              <td>
                                             <input type='radio' name='laborerId'
                                                value='<%= laborerService.getLaborers().get(i).getLaborerId() %>'>
                                          </td>
                                          <td><%= laborerService.getLaborers().get(i).getLaborerId() %></td>
                                              <td><%= laborerService.getLaborers().get(i).getName() %></td>
                                              <td><%= laborerService.getLaborers().get(i).getHireDate() %></td>
                                           </tr>
                                        <%
                                              }
                                           } else { 
                                        %>
                                           <tr>
                                              <td colspan='4' class='text-center'>노동자가 없습니다.</td>
                                           </tr>
                                        <%
                                           }
                                        %>
                                </tbody>
                            </table>
                        </div>
                    </div>
            </div>
        </div>
    </div>

    <div class='modal fade' tabindex='-1' id='modal'>
        <div class='modal-dialog'>
            <div class='modal-content'>
                <div class='modal-header'>
                    <button type='button' class='close' data-dismiss='modal'>
                        <span>&times;</span>
                    </button>
                </div>
                <div class='modal-body'>
                    <p id='modalMsg'></p>
                </div>
                <div class='modal-footer' id='modalBtn'>
                    <button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
                    <button type='submit' formaction='laborerDelProc.jsp' 
                    class='btn btn-primary' id='delLaborerOkBtn' formmethod='post'>예</button>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>


<%--
<body>
<form method='post'>
    <div class='container'>
        <div class='row'>
            <div class='col'>
                <header class='jumbotron p-2'>
                    <h1 class='text-center'>HR</h1>
                </header>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                    <div class='row mb-3'>
                        <div class='col-2'>
                            <input type='text' class='form-control' placeholder='노동자명' id='laborerName' name='laborerName'/>
                        </div>
                        <div class='col-4'>
                            <input type='date' class='form-control' placeholder='입사일' id='hireDate' name='hireDate'/>
                        </div>
                        <div class='col'>
                            <nav class='d-flex'>
                                <button type='submit' formaction='laborerAddProc.jsp' class='btn btn-success flex-fill mr-1' id='addLaborerBtn'
                                		formmethod='post'>
                                    <i class='fas fa-plus'></i><span class='label d-none d-sm-inline'>추가</span>
                                </button>
                                <button type='submit' formaction='laborerFixProc.jsp' class='btn btn-info flex-fill mr-1' id='fixLaborerBtn'>
                                    <i class='fas fa-edit'></i><span class='label d-none d-sm-inline'>수정</span>
                                </button>
                                <button type='button'class='btn btn-warning flex-fill' id='delLaborerBtn'
                                		data-toggle="modal" data-target="#modal">
                                    <i class='fas fa-trash-alt'></i><span class='label d-none d-sm-inline'>삭제</span>
                                </button>
                            </nav>
                        </div>
                    </div>
                    <div class='row'>
                        <div class='col mt-3'>
                            <table class='table'>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>ID</th>
                                        <th>이름</th>
                                        <th>입사일</th>
                                    </tr>
                                </thead>
                                <tbody id='tbody'>
                                        <% 
                                        	if(laborerService.getLaborers().size() > 0) {
                                        		for(int i = 0; i < laborerService.getLaborers().size(); i++) {
                                        %>
                                        	<tr>
		                                        <td>
	                        						<input type='radio' name='laborerId'
	                        							value='<%= laborerService.getLaborers().get(i).getLaborerId() %>'>
		                        				</td>
		                        				<td><%= laborerService.getLaborers().get(i).getLaborerId() %></td>
		                                        <td><%= laborerService.getLaborers().get(i).getName() %></td>
		                                        <td><%= laborerService.getLaborers().get(i).getHireDate() %></td>
		                                     </tr>
                                        <%
                                        		}
                                        	} else { 
                                        %>
                                        	<tr>
                                        		<td colspan='4' class='text-center'>노동자가 없습니다.</td>
                                        	</tr>
                                        <%
                                        	}
                                        %>
                                </tbody>
                            </table>
                        </div>
                    </div>
            </div>
        </div>
    </div>

    <div class='modal fade' tabindex='-1' id='modal'>
        <div class='modal-dialog'>
            <div class='modal-content'>
                <div class='modal-header'>
                    <button type='button' class='close' data-dismiss='modal'>
                        <span>&times;</span>
                    </button>
                </div>
                <div class='modal-body'>
                    <p id='modalMsg'>노동자를 삭제하시겠습니까? </p>
                </div>
                <div class='modal-footer' id='modalBtn'>
                    <button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
                    <button type='submit' formaction='laborerDelProc.jsp' 
                    class='btn btn-primary' id='delLaborerOkBtn'>예</button>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>
--%>