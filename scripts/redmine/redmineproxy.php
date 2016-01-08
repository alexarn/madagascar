<?php
/**
 * Copyright (c) 2012-2014, Agence Française Informatique (AFI). All rights reserved.
 *
 * BOKEH is free software; you can redistribute it and/or modify
 * it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE as published by
 * the Free Software Foundation.
 *
 * There are special exceptions to the terms and conditions of the AGPL as it
 * is applied to this software (see README file).
 *
 * BOKEH is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 * You should have received a copy of the GNU AFFERO GENERAL PUBLIC LICENSE
 * along with BOKEH; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
 */
require_once './RedmineClient.php';
$config['redmine_url']= 'http://forge.afi-sa.fr/';
$config['redmine_api_key']='A CHANGER';
$client = new RedmineClient($config['redmine_url'], $config['redmine_api_key']);

echo $client->get('/custom_fields.json', false);



?>