<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.constants.Constants"%>
<%@page import="com.apps.ResourceBundle.AppBundle"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.util.Vector"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
    <head profile="http://gmpg.org/xfn/11">
        <title>Blood Bank Management System</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="imagetoolbar" content="no" />
        <link rel="stylesheet" href="styles/layout.css" type="text/css" />
        <%@page errorPage="ErrorPage.jsp"%>
        <%@page session="true" %>
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
                        <li><a href="adminhome.jsp">Blood Bank</a></li>
                        <li><a href="bloodbanks.jsp">Search Blood Bank</a></li>
                        <li><a href="bloodgroups.jsp">Search Blood Groups</a></li>
                        <li><a href="suggestions.jsp">Search Suggestions</a></li>
                        <li class="active"><a href="donors.jsp">Search Donors</a></li>
                        <li><a href="appdetails.jsp">Appointment Details</a></li>
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
                   
                    <h1>Search Donors</h1>
                    
                    <form action="codedonors.jsp" method="post">
          
                      <table align="center" border="0px" width="100px">

                          <tr style="color: red;">
                              <td>Blood Group:</td><td><input type="text" name="bloodgroup" size="45px"/>*</td>
                          </tr>

                          <tr>
                              <td>&nbsp;</td>
                              <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
                          </tr>
                         
                      </table>

                   </form>
                    
                   <h1>Donors Details</h1>
                    
                    <% 
                        Log objLog  = objLog = new Log();                                          
                        Vector<Object> rsp = null;
                        Statement st = null;
                        ResultSet rs = null;
                        Connection con = null;
                        String sqlquery = "";
                        
                        try
                        {
                                int g = 1;
                             
                                 out.println("<table border='2px'  style='text-align: center;' width='100%'>");
                                 out.println("<tr>");
                                 out.println("<th>Sno</th>");
                                 out.println("<th>User Name</th>");                               
                                 out.println("<th>Gender</th>");
                                 out.println("<th>Phone No</th>");
                                 out.println("<th>Email Id</th>");
                                 out.println("<th>Blood Group</th>");                                 
                                 out.println("<th>Address</th>");                                                                                                                                                                                                                                                                                   
                                 out.println("<th>Created Date</th>");                                                                                                                                                                                                
                                 out.println("</tr>");

                                 String sql = "SELECT u.User_Name, u.Gender, u.User_PhoneNo, u.User_Email, bt.blood_type_name, u.User_Addres, u.Created_Date "
                                         + "FROM userdetails as u "
                                         + "LEFT JOIN blood_type AS bt ON bt.blood_type_id = u.BloodType "
                                         + "WHERE ";

                                 if((request.getParameter("bloodgroup") != null) && (!request.getParameter("bloodgroup").toString().trim().equalsIgnoreCase(""))
                                         && (!request.getParameter("bloodgroup").toString().trim().equalsIgnoreCase("null")))
                                 {
                                     sql += "bt.blood_type_name = '"+request.getParameter("bloodgroup").toString().trim()+"' AND   ";
                                 }
                                 
                                 sqlquery = sql.substring(0, sql.length() - 6);
                                         
                                 sqlquery += "ORDER BY u.User_Name ASC";

                                 Log.logger.info("sql:"+sqlquery);
                                
                                rsp = DatabaseFile.getInstance().codeselect(sqlquery);

                                st = (Statement) rsp.get(0);
                                rs = (ResultSet) rsp.get(1);
                                con = (Connection) rsp.get(2);
                                 
                                while(rs.next())
                                {
                                     out.println("<tr>"
                                             + "<td>" + g++ + "</td>"
                                             + "<td>" + rs.getString(1) + "</td>"  
                                             + "<td>" + rs.getString(2) + "</td>"                                                  
                                             + "<td>" + rs.getString(3) + "</td>" 
                                             + "<td>" + rs.getString(4) + "</td>" 
                                             + "<td>" + rs.getString(5) + "</td>" 
                                             + "<td>" + rs.getString(6) + "</td>" 
                                             + "<td>" + rs.getString(7) + "</td>" 
                                             + "</tr>");
                                }
                                
                                if(g == 1)
                                {
                                     out.println("<tr>"
                                             + "<td></td>"
                                             + "<td></td>"
                                             + "<td></td>"
                                             + "<td></td>"                                                                                         
                                             + "<td style='color:red;'>"+AppBundle.getInstance().loadpropertyfile("103", Constants.Config)+"</td>"                                                  
                                             + "<td></td>"
                                             + "<td></td>"  
                                             + "<td></td>"                                                                                                                                                                           
                                             + "</tr>");
                                }
                                                                                                                                                         
                                out.println("</table>");
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
