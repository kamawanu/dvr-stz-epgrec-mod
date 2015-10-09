{include file='header.tpl'}

<div class="container">
<h2>{$sitetitle}</h2>
<p><a href="{$home_url}setting">環境設定へ</a> / <a href="{$home_url}setting/system">システム設定へ</a> / <a href="{$home_url}setting/userList">ユーザ一覧へ</a></p>
</div>

<div class="container nonborderbox">
{if count($logs)}
<table id="log_table" class="table">
<thead>
 <tr>
  <th>レベル</th>
  <th>日時</th>
  <th>内容</th>
 </tr>
</thead>
<tbody>
{foreach from=$logs item=log}
 <tr>
  <td class="errorlevel{$log.level}">
    {if $log.level == 0}情報
    {elseif $log.level == 1}警告
    {elseif $log.level == 2}エラー
    {/if}
  </td>
  <td>{$log.logtime}</td>
  <td>{$log.message|escape}</td>
 </tr>
{/foreach}
</tbody>
</table>
{else}
<p>該当するログはありません</p>
{/if}
</div>
{include file='INISet.tpl'}
{include file='footer.tpl'}
