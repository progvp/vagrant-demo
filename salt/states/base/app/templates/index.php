<html>
<body>

<?php

$mysql_user = "{{ pillar['app']['db_user'] }}";
$mysql_password = "{{ pillar['app']['db_password'] }}";
$mysql_db = "{{ pillar['app']['db_name'] }}";
$mysql_host = "localhost";

$link = mysqli_connect($mysql_host, $mysql_user, $mysql_password, $mysql_db);
if($link === false){
    print("ERROR: Could not connect. " . mysqli_connect_error());
    exit();
}

$query = "select * from employees where gender='M' and birth_date='1965-02-01' and hire_date>'1990-01-01' order by last_name;";

echo "<p>Executing query '$query' </p> <p />";

if($result = mysqli_query($link, $query)){
    if(mysqli_num_rows($result) > 0){
        echo "<table>";
            echo "<tr>";
                echo "<th>emp_no</th>";
                echo "<th>first_name</th>";
                echo "<th>last_name</th>";
                echo "<th>gender</th>";
                echo "<th>birth_date</th>";
                echo "<th>hire_date</th>";
            echo "</tr>";
        while($row = mysqli_fetch_array($result)){
            echo "<tr>";
                echo "<td>" . $row['emp_no'] . "</td>";
                echo "<td>" . $row['first_name'] . "</td>";
                echo "<td>" . $row['last_name'] . "</td>";
                echo "<td>" . $row['gender'] . "</td>";
                echo "<td>" . $row['birth_date'] . "</td>";
                echo "<td>" . $row['hire_date'] . "</td>";
            echo "</tr>";
        }
        echo "</table>";
        mysqli_free_result($result);
    } else{
        echo "No records matching your query were found.";
    }
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($link);
}
?>

</body>
</html>

