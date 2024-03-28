<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>Blood Bank Management System</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />

</head>
<body id="top">
<div class="wrapper row1">
  <div id="header" class="clear">
    <div class="fl_left">
      <h1><a href="index.jsp">Blood Bank Management System</a></h1>
      <p>Management System</p>
    </div>
    <div class="fl_right">
    </div>
  </div>
</div>
<!-- ####################################################################################################### -->
<div class="wrapper row2">
  <div class="rnd">
    <!-- ###### -->
    <div id="topnav">
      <ul>
        <li class="active"><a href="index.jsp">Donor</a></li>          
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
     
      <form action="codesignin.jsp" method="post">
          
          <h1 style="color: red;">Donor Registration Form</h1>
          
          <table align="center" border="0px" width="100px">
              
              <tr style="color: red;">
                  <td>Name:</td><td><input type="text" name="name" size="54px" autocomplete="off"/>*</td>
              </tr>
              
              <tr style="color: red;">
                  <td>Gender:</td>
                  <td>
                      <input type="radio" name="gender" size="54px" value="Male" >Male</input>
                      <input type="radio" name="gender" size="54px" value="Female" >Female</input> *
                  </td>
              </tr>
              
              <tr style="color: red;">
                  <td>Phone No:</td><td><input type="text" name="phone" size="54px" autocomplete="off"/>*</td>
              </tr>
              
              <tr style="color: red;">
                  <td>Email Id:</td><td><input type="text" name="email" size="54px" autocomplete="off"/>*</td>
              </tr>
              
              <tr style="color: red;">
                  <td>Blood Type:</td>
                  <td>
                                <select name="bloodtype" style="width:288px;">  
                                      
                                  <option value="-Select-">-Select-</option>
                                      
                                      <%
                                           Log objLog  = objLog = new Log();
                                           Vector<Object> rsp = null;
                                           Statement st = null;
                                           ResultSet rs = null;
                                           Connection con = null;                                      
                                         
                                           try
                                            {
                                                 String sql = " SELECT blood_type_id, blood_type_name "
                                                             + " FROM blood_type ";

                                                 rsp = DatabaseFile.getInstance().codeselect(sql);

                                                 st = (Statement) rsp.get(0);
                                                 rs = (ResultSet) rsp.get(1);
                                                 con = (Connection) rsp.get(2);

                                                 while(rs.next())
                                                 {
                                                      %>
                                                        <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                                                      <%
                                                 }                                     
                                            }
                                            catch(Exception e)
                                            {
                                                e.printStackTrace();
                                                Log.logger.error("Error:", e);
                                                Log.logger.warn("This is a warning message");
                                                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                                            }
                                            finally
                                            {
                                                try
                                                {
                                                    if(st != null)
                                                    {
                                                        st.close(); 
                                                        st = null;
                                                    }
                                                }
                                                catch(Exception e)
                                                {
                                                    e.printStackTrace();

                                                    Log.logger.error("Error:", e);
                                                    Log.logger.warn("This is a warning message");
                                                    Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                                                }

                                                try
                                                {
                                                    if(rs != null)
                                                    {
                                                        rs.close(); 
                                                        rs = null;
                                                    }
                                                }
                                                catch(Exception e)
                                                {
                                                    e.printStackTrace();

                                                    Log.logger.error("Error:", e);
                                                    Log.logger.warn("This is a warning message");
                                                    Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                                                }

                                                try
                                                {
                                                    if(con != null)
                                                    {
                                                        DatabaseFile.cp.surrenderConnection(con);

                                                        con.close();
                                                        con = null;
                                                    }
                                                }
                                                catch(Exception e)
                                                {
                                                    e.printStackTrace();

                                                    Log.logger.error("Error:", e);
                                                    Log.logger.warn("This is a warning message");
                                                    Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                                                }

                                                rsp = null;
                                            }
                                      %>
                                      
                                  </select>*
                  </td>
              </tr>
              
              <tr style="color: red;">
                  <td>Address:</td><td><textarea cols="50" rows="6" name="address"></textarea>*</td>
              </tr>
              
              <tr style="color: red;">
                  <td>Username:</td><td><input type="text" name="username" size="54px" autocomplete="off"/>*</td>
              </tr>
              
              <tr style="color: red;">
                  <td>Password:</td><td><input type="password" name="password" size="54px" autocomplete="off"/>*</td>
              </tr>
              
              <tr>
                  <td>&nbsp;</td>
                  <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
              </tr>
              
          </table>
          
      </form>
                      
      <%
          out.println("<font color = 'red' >");

          //getting response
          try
          {
              if( (request.getParameter("msg") != null) && (!(request.getParameter("msg").trim().equals(""))) )
              {
                  String respMsg = AppBundle.getInstance().loadpropertyfile(request.getParameter("msg"), Constants.Config);
              
                  out.println(respMsg != null ? respMsg : AppBundle.getInstance().loadpropertyfile("100", Constants.Config));
              }
          }
          catch(Exception e)
          {
              e.printStackTrace();
          }

          out.println("</font>");
      %>
      
      <!-- ####################################################################################################### -->
    </div>
  </div>
</div>
</body>
</html>
