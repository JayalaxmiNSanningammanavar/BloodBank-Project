<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<%@page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
    <head profile="http://gmpg.org/xfn/11">
        <title>Blood Bank Management System</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="imagetoolbar" content="no" />
        <link rel="stylesheet" href="styles/layout.css" type="text/css" />       
        <link href="styles/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="scripts/jquery-1.5.js"></script>
        <script src="scripts/jquery-ui-1.8.17.custom.min.js"></script>

        <script type="text/javascript">
            
           $(function() 
           {
                   $("#datepicker").datepicker({ dateFormat: "yy-mm-dd" }).val()
           });
           
        </script>
    </head>
    <body id="top">
        <div class="wrapper row1">
            <div id="header" class="clear">
                <div class="fl_left">
                    <h1><a href="index.jsp">Blood Bank Management System</a></h1>
                    <p>Management System
                        <span style="padding-left: 250px; color: red;"> Welcome : <%=session.getAttribute("x")%></span>                           
                    </p>
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
                        <li><a href="profile.jsp">Profile Details</a></li>
                        <li class="active"><a href="appointment.jsp">Appointment</a></li>
                        <li><a href="history.jsp">History</a></li>                        
                        <li class="last"><a href="Signout.jsp">Sign Out</a></li>
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
                                        
                   <h1>Appointment Form</h1>
                    
                    <form action="codeappoinment.jsp" method="post">
          
                      <table align="center" border="0px" width="100px">

                          <tr style="color: red;">
                              <td>Blood Bank:</td>
                              <td>
                                            <select name="bloodbank" style="width:250px;">  

                                              <option value="-Select-">-Select-</option>

                                                  <%
                                                       Log objLog  = objLog = new Log();
                                                       Vector<Object> rsp = null;
                                                       Statement st = null;
                                                       ResultSet rs = null;
                                                       Connection con = null;                                      

                                                       try
                                                        {
                                                             String sql = "SELECT Blood_bank_id, Blood_bank_name "
                                                                        + "FROM blood_banks ";

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
                              <td>Appointment Date: </td><td>
                                  <input type="text" id="datepicker" name="datepicker" size="47px"/>*</td>
                          </tr>

                          <tr>
                              <td>&nbsp;</td>
                              <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
                          </tr>
                          
                      </table>

                  </form>
                                       
                    </div>

                    <%
                        //getting response
                        try 
                        {
                            out.println("<font color = 'red'>");

                            if ((request.getParameter("msg") != null) && (!(request.getParameter("msg").trim().equals("")))) 
                            {
                                String respMsg = AppBundle.getInstance().loadpropertyfile(request.getParameter("msg"), Constants.Config);
              
                                out.println(respMsg != null ? respMsg : AppBundle.getInstance().loadpropertyfile("100", Constants.Config));
                            }

                            out.println("</font>");
                        } 
                        catch (Exception e) 
                        {
                            e.printStackTrace();
                
                            Log.logger.error("Error:", e);
                            Log.logger.warn("This is a warning message");
                            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
                        }
                    %>
                    <!-- ####################################################################################################### -->
                </div>
            </div>        
    </body>
</html>
