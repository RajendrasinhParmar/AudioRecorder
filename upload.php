<?php
$msg = " ".var_dump($_FILES)." ";
$new_image_name = $_FILES["userfile"]["name"];
if(move_uploaded_file($_FILES["userfile"]["tmp_name"], getcwd() . "/uploads/" . $new_image_name)){
	echo "The file".basename($_FILES["userfile"]["tmp_name"])." has been uploaded";
}

if(isset($_POST["value1"])){
	$file = 'people.txt';
	$person = "\n".$_POST["value1"]."\n";
	file_put_contents($file, $person, FILE_APPEND | LOCK_EX);
	echo "string assigned successfully";
}
if(isset($_POST["value2"])){
	$file = 'people.txt';
	$person = "\n".$_POST["value2"]."\n\n";
	file_put_contents($file, $person, FILE_APPEND | LOCK_EX);
	echo "string assigned successfully";
}
if(isset($_POST["value3"])){
	$file = 'people.txt';
	$person = "\n".$_POST["value3"]."\n\n";
	file_put_contents($file, $person, FILE_APPEND | LOCK_EX);
	echo "string assigned successfully";
}
?>