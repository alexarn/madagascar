<?php

$database = array_at('dbname',
										 Zend_Db_Table::getDefaultAdapter()->getConfig());
$out=[];
if (Class_AdminVar::isToutApprendreEnabled()) {
	$out[]= 'TOUT APPRENDRE';

}

if (Class_AdminVar::isArteVodEnabled()) {
	$out[]= ' ARTEVOD ';

}

if (empty($out))
	return;
echo $database.": ".implode('; ',$out)."\n";
?>