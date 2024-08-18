<%@ page import="com.cyber.notetaking.Model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Notes</title>
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
    <link rel="stylesheet" href="css/notes.css">
    <script src="fontawesome/js/all.min.js"></script>
    <script src="fontawesome/js/all.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-custom nav-custom">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link " aria-current="page" href="index.jsp"><i class="fa-solid fa-house"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="addnotes.jsp"><i class="fa-solid fa-plus"></i> Add Note</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="shownotes.jsp"><i class="fa-solid fa-address-book"></i> Show Note</a>
                </li>
            </ul>
            <form class="form-inline my-2  my-lg-0">
                <a class="btn btn-light my-2 my-sm-0 mr-2" type="submit" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-light my-2 my-sm-0" type="submit" data-bs-toggle="modal" data-bs-target="#staticBackdrop"><i class="fa-solid fa-user"></i> <%=session.getAttribute("fname")%></a>
            </form>
        </div>
    </div>
</nav>
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Profiles</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tbody>
                    <tr>
                        <th>User Name</th>
                        <td><%=session.getAttribute("fname")%> <%=session.getAttribute("lname")%></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%=session.getAttribute("email")%></td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td><%=session.getAttribute("phone")%></td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<form action="add-notes" method="post" >
    <h1 class="text-center">Add Your Notes
    </h1>
    <div class="form-group">
        <label for="exampleFormControlInput1" class="form-label">Notes Title</label>
        <input type="text" class="form-control" id="exampleFormControlInput1" name="title" placeholder="Title ">
    </div>
    <div class="form-group">
        <label for="exampleFormControlTextarea1" class="form-label">Enter Content</label>
        <textarea class="form-control" id="exampleFormControlTextarea1" name="content" rows="10"></textarea>
    </div>
    <div class="container text-center">
        <button type="submit" class="btn btn-primary">Add Notes</button>
    </div>
</form>


<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
<%
    User user = (User)request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    session.setAttribute("uid", user.getId());
    session.setAttribute("user",user);


    if (user != null)
    {%>

    <input type="hidden" value="<%=user.getId()%>" name="uid">
<%}%>
<!-- JS -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type="text/javascript">
    var status=document.getElementById("status").value;
    if(status == "failed")
    {
        swal("sorry","Notes not Add something error","error");
    }
    if(status == "success")
    {
        swal("sorry","Notes Add Successfully","error");
    }

</script>
<script src="js/main.js"></script>
</body>
</html>
