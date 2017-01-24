<?php
require_once 'console.php';


function removeRandomKioskConfig($config) {
	if (isset($config['type_module']) && ('KIOSQUE' !== $config['type_module']))
		return $config;

	$config['preferences']['aleatoire'] = 0;
	$config['preferences']['nb_notices'] = 5;
	return $config;
}


function removeRandomArticleConfig($config) {
	if (isset($config['type_module']) && ('NEWS' !== $config['type_module']))
		return $config;

	$config['preferences']['display_order'] = 'DateCreationDesc';
	$config['preferences']['nb_aff'] = 2;
	return $config;
}


function removeRandomModuleConfig($page) {
	$cfg_accueil = $page->getCfgAccueilAsArray();

	foreach($cfg_accueil['modules'] as $index => $config) {
		$cfg_accueil['modules'][$index] = removeRandomArticleConfig(removeRandomKioskConfig($config));
	}

	$page->setCfgAccueil($cfg_accueil)->save();
}


foreach (Class_Profil::findAll() as $page) {
	removeRandomModuleConfig($page);
}

foreach(Class_IntBib::findAll() as $int_bib){
	$int_bib->setCommParams([])
					->setCommSigb(0)
					->save();
}


Class_AdminVar::set('CNIL_CONSENT_ENABLE', 0);
?>