user { 'joe' :
   ensure     => present  
   uid        => '2000',
   gid        => '1000',
   comment    => 'Joe the User', 
   managehome => 'false',
/}