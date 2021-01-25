<?php

const MR = "http://127.0.0.1:40772/api/";

@array_shift($argv);
$select_ch = @array_shift($argv);

$ch = json_decode(file_get_Contents(MR."channels"),TRUE);
##var_dump($ch[0]);
$prg = json_decode(file_get_contents(MR."programs"),TRUE);
#var_dump($prg);
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
echo "<!DOCTYPE tv SYSTEM \"xmltv.dtd\">\n\n";

echo "<tv generator-info-name=\"tsEPG2xml\" generator-info-url=\"http://localhost/\">\n";

$svs = array();

$GENRES = array(
    # https://stabucky.com/wp/archives/6118
    0 => [ "ニュース／報道", "news", ],
    1 => [ "スポーツ", "sports", ],
    2 => [ "情報／ワイドショー", "information", ],
    3 => [ "ドラマ", "drama", ],
    4 => [ "音楽", "music", ],
    5 => [ "バラエティ", "variety", ],
    6 => [ "映画", "cinema", ],
    7 => [ "アニメ／特撮", "anime", ],
    8 => [ "ドキュメンタリー／教養", "documentary", ],
    9 => [ "劇場／公演", "", ],
    10 => [ "趣味／教育", "education", ],
    11 => [ "福祉", "society", ],
    14 => [ "拡張", "extra", ],
    15 => [ "その他", "etc", ],
);

$BLOCK_SV = array(
	23992,23993,25016,1440,1183,1456,1448,1424,1416,1408
);

foreach($ch as $ch1){
    $tp = $ch1["channel"];
    if($select_ch != "" && $tp != $select_ch ){
        continue;
    }
    ##print_r($ch1);
    foreach($ch1["services"] as $sv1) {
        $n = $sv1["name"];
        $id = $sv1["networkId"];
        $svid = $sv1["serviceId"];
	if( array_search($svid,$BLOCK_SV) !== false ){
		continue;
	}
        echo <<<"___XML___"
  <channel id="GR_$svid" tp="$tp">
    <display-name lang="ja_JP">$n</display-name>
    <transport_stream_id>$id</transport_stream_id>
    <original_network_id>$id</original_network_id>
    <service_id>$svid</service_id>
  </channel>\n
___XML___
        ;
        $svs[] = $svid;
    }
    ##break;
}

if(count($svs)==0){
    exit("empty chanells");
}

foreach($prg as $pg1){
    if(array_search($pg1["serviceId"],$svs) === false ){
        continue;
    }
    ###echo "<!--";
    ###print_r($pg1);
    ###echo "-->";

    $subch = $pg1["serviceId"];

    $s_tm = $pg1["startAt"] / 1000;
    $s_tm_tx = strftime("%Y%m%d%H%M00",$s_tm);

    $dr = $pg1["duration"] / 1000;
    $e_tm = $s_tm + $dr;
    $e_tm_tx = strftime("%Y%m%d%H%M00",$e_tm);

    $evid = $pg1["eventId"];

    $t = @$pg1["name"];
    $d1 = @$pg1["description"];

    if( $t == null ){
        continue;
    }

    echo "<programme start=\"$s_tm_tx +0900\" stop=\"$e_tm_tx +0900\" channel=\"GR_$subch\" event_id=\"$evid\">\n";

    if( is_array(@$pg1["extended"])){
        foreach($pg1["extended"] as $key => $ex){
            if(strstr($key,"内容") >= 0 || strstr($key,"出演") >= 0 ){
                $d1 .= "\n$key $ex";
            }
        }
    }

    $t = htmlspecialchars($t);
    $d1 = htmlspecialchars($d1);

    echo <<<"___XML___"
    <title lang="ja_JP">$t</title>
    <desc lang="ja_JP">$d1</desc>
___XML___;
	if( is_array(@$pg1["genres"]) ){
    foreach(@$pg1["genres"] as $g1 ){
        list($jp,$en) = $GENRES[$g1["lv1"]];
        echo <<<"___XML___"
        <category lang="ja_JP">$jp</category>
        <category lang="en">$en</category>
___XML___;
    }
}
    
    echo "</programme>\n";
    ###break;

    ###}
}
echo "</tv>";
