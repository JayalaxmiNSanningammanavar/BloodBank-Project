<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>Blood Bank Management System</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />
<%@page errorPage="ErrorPage.jsp"%>
</head>
<body id="top">
<div class="wrapper row1">
  <div id="header" class="clear">
    <div class="fl_left">
      <h1><a href="index.jsp">Blood Bank Management System</a></h1>
      <p>Management System</p>
    </div>
    <div class="fl_right">
      <ul> </ul>
    </div>
  </div>
</div>
<!-- ####################################################################################################### -->
<div class="wrapper row2">
  <div class="rnd">
    <!-- ###### -->
    <div id="topnav">
      <ul>
          <li><a href="index.jsp">Donor</a></li> 
          <li class="active"><a href="adminlogin.jsp">Admin</a></li> 
      </ul>
    </div>
    <!-- ###### -->
  </div>
</div>
<!-- ####################################################################################################### -->
<div class="wrapper row3">
  <div class="rnd">
    <div id="container" class="clear">
      <!-- ####################################################################################################### -->
      <h1>Admin Login Page</h1>
       
      <form action="codeadminindex.jsp" method="post">
          
          <table align="center" border="0px" width="100px">
              
              <tr style="color: red;">
                  <td>Username:</td><td><input type="text" name="username" size="35px" autocomplete="off"/>*</td>
              </tr>
              
              <tr style="color: red;">
                  <td>Password:</td><td><input type="password" name="password" size="35px" autocomplete="off"/>*</td>
              </tr>
              
              <tr>
                  <td>&nbsp;</td>
                  <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
              </tr>
                         
          </table>
          
      </form>
      
      <%
      //getting response
      
      out.println("<font color = 'red' >");
      
      try
      {
          if((request.getParameter("msg") != null) && (!request.getParameter("msg").trim().equals("")))
          {         
              String respMsg = AppBundle.getInstance().loadpropertyfile(request.getParameter("msg"), Constants.Config);
              
              out.println(respMsg != null ? respMsg : AppBundle.getInstance().loadpropertyfile("100", Constants.Config));
          }
      }
      catch(Exception e)
      {
          e.printStackTrace();
      }
      
      out.println("<font>");
      %>   
      
    </div>
    
  </div>
    
 </div>
    
</body>
    
</html>
