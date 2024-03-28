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
                        <li><a href="donors.jsp">Search Donors</a></li>
                        <li class="active"><a href="appdetails.jsp">Appointment Details</a></li>
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
                                        
                   <h1>History Details</h1>
                    
                    <% 
                        Log objLog  = objLog = new Log();                                          
                        Vector<Object> rsp = null;
                        Statement st = null;
                        ResultSet rs = null;
                        Connection con = null;
                        
                        try
                        {
                                int g = 1;
                             
                                 out.println("<table border='2px'  style='text-align: center;' width='100%'>");
                                 out.println("<tr>");
                                 out.println("<th>Sno</th>");
                                 out.println("<th>Name</th>");
                                 out.println("<th>Phone No</th>");
                                 out.println("<th>Email</th>");
                                 out.println("<th>Blood Bank Name</th>");
                                 out.println("<th>Blood Bank Address</th>");
                                 out.println("<th>Blood Bank Phone No</th>");                                                                                                                                                                                                                                                                 
                                 out.println("<th>Status</th>");                                                                                                                                                                                                                                                                                   
                                 out.println("<th>Appoinment Date</th>");                                                                                                                                                                                                
                                 out.println("</tr>");

                                 String sql = "SELECT bb.Blood_bank_name, bb.Blood_bank_address, bb.Blood_bank_ph_no, uapp.Status, uapp.AppoinmentDate, uapp.App_Id, u.User_Name, u.User_PhoneNo, u.User_Email "
                                         + "FROM user_appointment as uapp "
                                         + "LEFT JOIN blood_banks AS bb ON bb.Blood_bank_id = uapp.Blood_bank_id "
                                         + "LEFT JOIN userdetails AS u ON u.User_Id = uapp.User_Id "                                        
                                         + "ORDER BY uapp.AppoinmentDate DESC";

                                rsp = DatabaseFile.getInstance().codeselect(sql);

                                st = (Statement) rsp.get(0);
                                rs = (ResultSet) rsp.get(1);
                                con = (Connection) rsp.get(2);
                                 
                                while(rs.next())
                                {
                                     out.println("<tr>"
                                             + "<td>" + g++ + "</td>"
                                             + "<td>" + rs.getString(7) + "</td>"
                                             + "<td>" + rs.getString(8) + "</td>"
                                             + "<td>" + rs.getString(9) + "</td>"                                                    
                                             + "<td>" + rs.getString(1) + "</td>"  
                                             + "<td>" + rs.getString(2) + "</td>"                                                  
                                             + "<td>" + rs.getString(3) + "</td>");
                                     
                                     if(rs.getString(4).equalsIgnoreCase("Approved"))
                                     {
                                        out.println("<td><a href='codeApprove.jsp?index=" + rs.getInt(6) + "&index1=" + rs.getString(4) +"'><img src='images/UnApprove.png'></img></a></td>");
                                     }
                                     else if(rs.getString(4).equalsIgnoreCase("Un Approved"))
                                     {
                                        out.println("<td><a href='codeApprove.jsp?index=" + rs.getInt(6) + "&index1=" + rs.getString(4) +"'><img src='images/Approve.png'></img></a></td>");
                                     }
                                     
                                     out.println("<td>" + rs.getString(5) + "</td>"                                                                                                                                                                                                                                                                                                    
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
