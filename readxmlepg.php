<?php
  @array_shift($argv);
  define( "INSTALL_PATH",array_shift($argv));
  include_once( INSTALL_PATH . '/config.php');

  ##$type = $argv[1];	// BS CS1 CS2 GR
  ##$file = $argv[2];	// TSファイル
  $key  = "";

  $xmlfile = array_shift($argv);
  
  // プライオリティ低に
  pcntl_setpriority(20);

  include_once(  INSTALL_PATH .'/DBRecord.class.php' );
  include_once( INSTALL_PATH . '/Reservation.class.php' );
  include_once( INSTALL_PATH . '/Keyword.class.php' );
  include_once( INSTALL_PATH . '/Settings.class.php' );
  include_once( INSTALL_PATH . '/storeProgram.inc.php' );
  include_once( INSTALL_PATH . '/reclib.php' );

  $type = "GR";
  ###var_dump($xmlfile);
  if( file_exists( $xmlfile )) {
	storeProgram( $type, $xmlfile );
  } else {
	exit( "storeProgram:: 正常な".$xmlfile."が作成されなかった模様(放送間帯でないなら問題ありません)" );
  }
  
  ####if( file_exists( $file ) ) @unlink( $file );

  doKeywordReservation();	// キーワード予約
