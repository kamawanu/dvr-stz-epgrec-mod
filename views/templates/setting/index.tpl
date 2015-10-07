{include file='header.tpl'}

<div class="container">
<h2>{$sitetitle}</h2>
{if $message|default:'' != ''}
{$message}
{else}
<p><a href="{$home_url}index">設定せずに番組表に戻る</a> / <a href="{$home_url}setting/system">システム設定へ</a> / <a href="{$home_url}setting/viewLog">動作ログを見る</a></p>
{/if}
</div>

<div class="container">
<form id="env_setting" method="post" action="{$post_to}">

<h2>デジタルチューナー設定</h2>

<h3>地デジチューナーの台数</h3>
<div class="setting">
<div class="caption">サーバーに接続されている地デジチューナーの台数を設定してください。地デジチューナーを持っていない場合、0にします。</div>
<input type="text" name="gr_tuners" value="{$settings->gr_tuners}" size="3" class="required digits" />
</div>

<h3>BSチューナーの台数</h3>
<div class="setting">
<div class="caption">サーバーに接続されているBSチューナーの台数を設定してください。BSチューナーを持っていない場合、0にします。</div>
<input type="text" name="bs_tuners" value="{$settings->bs_tuners}" size="3" class="required digits" />
</div>

<h3>CS録画の有無</h3>
<div class="setting">
<div class="caption">この設定を「行う」にするとCS放送を加味した動作となります。CS放送を使用しない方は「使わない」に設定してください。</div>
<select name="cs_rec_flg" id="id_cs_rec_flg">
  <option value="0" {if $settings->cs_rec_flg == 0} selected="selected"{/if}>行わない</option>
  <option value="1" {if $settings->cs_rec_flg == 1} selected="selected"{/if}>行う</option>
</select>
</div>

<h2>録画関連設定</h2>

<h3>録画開始の余裕時間（秒）</h3>
<div class="setting">
<div class="caption">epgrecは番組開始時間より早く録画を開始します。どのくらい録画開始を早めるかを秒で設定してください。<br />
早める時間を短くしすぎると、番組冒頭がとぎれる恐れがあります。設定できる時間は0秒以上180秒未満です。</div>
<input type="text" name="former_time" value="{$settings->former_time}" size="4" class="required digits" />
</div>

<h3>録画時間を長めにする（秒）</h3>
<div class="setting">
<div class="caption">下の欄に0以上の秒数を設定すると、すべての番組に対して設定した秒数分だけ録画時間を延ばします。<br />
この設定は「連続した番組の予約」設定と相性が良くありません。0以外の秒を設定する場合、<br />
連続した番組の予約が行いづらくなることに注意してください。推奨値は0です。</div>
<input type="text" name="extra_time" value="{$settings->extra_time}" size="4" class="required digits" />
</div>

<h3>連続した番組の予約</h3>
<div class="setting">
<div class="caption">この設定を「行う」にするとepgrecが自動的に直前の時間に予約されている番組の録画時間を短縮して時間が連続している番組の予約を可能にします。<br />
録画時間を短縮する時間は「録画開始の余裕時間」＋「録画コマンドの切り替え時間」です。<br />
この機能を使って連続した番組を予約する場合、前の時間の番組の最後がとぎれる可能性がありますが、<br />
チューナーが1台しか無くてもキーワード自動録画による連続した番組の予約が可能になります。<br />
メリットとデメリットをよく考えて設定してください。</div>
<select name="force_cont_rec" id="id_force_cont_rec" onchange="javascript:PRG.force_cont()">
  <option value="0" {if $settings->force_cont_rec == 0} selected="selected"{/if}>行わない</option>
  <option value="1" {if $settings->force_cont_rec == 1} selected="selected"{/if}>行う</option>
</select>
</div>

<h3>録画コマンドの切り替え時間（秒）</h3>
<div class="setting">
<div class="caption">連続した番組を予約するとき、録画が終了して次の録画を開始するまでの余裕時間（秒）を設定します。<br />
1以上の秒数を設定してください。設定する秒数が短いほど録画時間を短縮する時間が短くなりますが、<br />
この時間を短くしすぎると連続した番組の予約に失敗する恐れがあります。<br />
失敗するかどうかは使用している録画コマンドやチューナーに依存します。</div>
<input type="text" name="rec_switch_time" id="id_rec_switch_time" value="{$settings->rec_switch_time}" size="4" class="required digits" />
</div>

<h3>優先する録画モード</h3>
<div class="setting">
<div class="caption">キーワード自動録画や簡易録画を行う番組の録画モードを設定します。<br />
config.phpの$RECORD_MODEに複数の録画モードを登録し、do-record.shをカスタマイズているのであれば、その録画モードを優先して利用できます。<br />
キーワード自動録画はキーワード登録時に録画モードを設定することもできます。デフォルトはモード0です。</div>
<select name="autorec_mode" id="id_autorec_mode">
{html_options options=$record_mode selected=$settings->autorec_mode}
</select>
</div>

<h3>mediatomb連係機能</h3>
<div class="setting">
<div class="caption">この設定を「使う」にすると録画した番組のタイトルと概要をmediatombに反映させます。<br />
mediatombを使用していない方は「使わない」に設定してください。<br />
なお、この設定を利用するにはmediatomb側の設定も必要になります。詳しくはドキュメントを参照してください。</div>
<select name="mediatomb_update" id="id_mediatomb_update">
  <option value="0" {if $settings->mediatomb_update == 0} selected="selected"{/if}>使わない</option>
  <option value="1" {if $settings->mediatomb_update == 1} selected="selected"{/if}>使う</option>
</select>
</div>

<h3>録画ファイル名の形式</h3>
<div class="setting">
<div class="caption">epgrecは録画ファイル名をカスタマイズすることができます。<br />
下の欄にファイル名のフォーマットを記入してください。フォーマットに使用できる特殊文字列は以下の通りです。

<table cellspacing="1" border="1">
<thead>
<tr>
  <th>特殊文字列</th><th>置換後の内容</th>
</tr>
</thead>
<tbody>
 <tr><td>%TITLE%</td><td>番組タイトル</td></tr>
 <tr><td>%ST%</td><td>開始日時（ex.200907201830)</td></tr>
 <tr><td>%ET%</td><td>終了日時（同上）</td></tr>
 <tr><td>%TYPE%</td><td>GR/BS/CS</td></tr>
 <tr><td>%CH%</td><td>チャンネル番号</td></tr>
 <tr><td>%SID%</td><td>サービスID</td></tr>
 <tr><td>%DOW%</td><td>曜日（英3文字Sun-Mon）</td></tr>
 <tr><td>%DOWJ%</td><td>曜日（漢字1字日-土）</td></tr>
 <tr><td>%YEAR%</td><td>開始年</td></tr>
 <tr><td>%MONTH%</td><td>開始月</td></tr>
 <tr><td>%DAY%</td><td>開始日</td></tr>
 <tr><td>%HOUR%</td><td>開始時</td></tr>
 <tr><td>%MIN%</td><td>開始分</td></tr>
 <tr><td>%SEC%</td><td>開始秒</td></tr>
 <tr><td>%DURATION%</td><td>録画時間（秒）</td></tr>
</tbody>
</table>
たとえば、<p>%YEAR%年%MONTH%月%DAY%日%HOUR%時%MIN%分%SEC%秒_%TYPE%%CH%_%TITLE%</p>と設定すると<br />
<p>2009年07月15日12時49分16秒_GR21_番組タイトル.ts</p>というような形式の録画ファイルが生成されます。<br />
%TYPE%や%CH%などを混ぜ、異なる番組に同じ録画ファイルが生成されないよう注意してください。<br />
なお、ファイルシステムがUTF-8以外の文字コードで、ファイル名に日本語を交ぜる場合、<br />
config.php内の定数FILESYSTEM_ENCODINGに文字コードを設定することができます。<br />
ただし、UTF-8以外の文字コードはテストを行っていないため推奨しません。</div>
<input type="text" name="filename_format" value="{$settings->filename_format}" size="40" class="required" />
</div>

<h2>番組表表示設定</h2>

以下の設定は実際に利用して様子を見ながら設定した方がいいでしょう。

<h3>ページに表示する番組表の長さ（時間）</h3>
<div class="setting">
<div class="caption">1ページに表示する番組表の長さを時間で設定します。標準は8時間分です。</div>
<input type="text" name="program_length" value="{$settings->program_length}" size="2" class="required digits" />
</div>

<h3>1局あたりの幅（px）</h3>
<div class="setting">
<div class="caption">番組表の1局当たりの幅をピクセル数で設定します。標準は150ピクセルです。</div>
<input type="text" id="ch_set_width" name="ch_set_width" value="{$settings->ch_set_width}" size="4" class="required digits" />
</div>

<h3>1時間あたりの高さ（px）</h3>
<div class="setting">
<div class="caption">番組表の1時間あたりの高さをピクセル数で設定します。標準は120ピクセルです。<br />
なお、60で割り切れないピクセル数を指定するとFirefoxを除くブラウザでは番組の高さが揃わなくなり見た目が悪くなるかもしれません。<br />
これはFirefox以外のブラウザでは実数のピクセルを正しくレンダリングしないためです。</div>
<input type="text" id="height_per_hour" name="height_per_hour" value="{$settings->height_per_hour}" size="4" class="required digits" />
</div>

<input type="hidden" name="token" value="{$token}" />
<input type="submit" value="設定を保存する" id="env_setting-submit" />
</form>
</div>
{include file='INISet.tpl'}
<script type="text/javascript" src="{$home_url}js/setting.js"></script>
<script type="text/javascript">
<!--
{literal}
$(document).ready(function(){
	$("#env_setting").validate({
		rules : {
			former_time: { min: 0, max: 179 },
			rec_switch_time: { min: 1 },
			program_length: { min: 2, max: 24 },
			ch_set_width: { min: 20 },
			height_per_hour: { min: 30 }
		}
	});
	PRG.force_cont();
});
{/literal}
-->
</script>
{include file='footer.tpl'}
