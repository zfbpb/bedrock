<h4>Spajam se na bazu...</h4>
<?php
  $host = 'local_mysql'; // ime servisa/kontejnera
  $user = 'wordpress';
  $pass = 'wordpress';
  $conn = new mysqli($host, $user, $pass);

  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  } else {
    echo "Konekcija uspješna!";
  }
?>

<?php
  print_r (phpinfo());
?>
