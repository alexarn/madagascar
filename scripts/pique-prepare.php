<?php
require 'console.php';


function removeRandomKioskConfigForModule($config) {
	if ('KIOSQUE' !== $config['type_module'])
		return $config;

	$config['preferences']['aleatoire'] = 0;
	$config['preferences']['nb_notices'] = 5;
	return $config;
}


function removeRandomKioskConfig($page) {
	$cfg_accueil = $page->getCfgAccueilAsArray();

	foreach($cfg_accueil['modules'] as $index => $config) {
		$cfg_accueil['modules'][$index] = removeRandomKioskConfigForModule($config);
	}

	$page->setCfgAccueil($cfg_accueil)->save();
}


foreach (Class_Profil::findAll() as $page) {
	removeRandomKioskConfig($page);
}



?>