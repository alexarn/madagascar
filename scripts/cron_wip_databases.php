<?php
class DatabasesCronScript {
	protected $tmp_dir="/var/www/html/vhosts/opac2/www/htdocs/databases/";
	
	public function __construct($user,$server_ip,$path) {
		$this->user = $user;
		$this->server_ip = $server_ip;
		$this->path = $path;

		return $this;
	}

	public function update_all_databases($names) {
		foreach ($names as $db_name) {
			$this->update_database($db_name);
		}
		return $this;
	}

	public function clean_backup_files() {
		passthru('rm '.$this->tmp_dir.'*_backup.sql.gz');
		return $this;
	}
		
	public function update_database($db_name) {
		$filename=$db_name.'_'.date("Ymd").'_OPAC3_MyISAM_backup.sql.gz';
		exec('scp '.$this->user.'@'.$this->server_ip.':'.
					$this->path.$filename.' '.$this->tmp_dir.
					' && zcat '.$this->tmp_dir.$filename.
					'|mysql -uroot -proot '.$db_name);
		return $this;
	}
}


$names = ["astrolabe","calice68","bucarest",
					"casqy","chatre","lagorgue","fiep","derval2","bibliossimo",
					"bibliosud","stomer","balaruc","getigne","blreine","hgoulaine",
					"irigny","clayette","nouvion","limours","machecoul","clermont",
					"paray","pdutouch","roissyenbrie","saintjeanleblanc","stpryve",
					"gevrey","lambre","achards","herbiers","seronais","semur",
					"becon","langon","yerres","biblix","mouries","noisy","bibaix",
					"arques","salaise2","viriat","bocage49","bokeh","ccbs","ccbm",
					"bdp55","loiresillon","nozay","pondensac","valmont","charenton",
					"coeurdubocage","stmartin","cuiseaux","deauville","etalon",
					"ferte","genevois","enghien","dole","fertebernard","lantimordel",
					"lecellier","foix","valdyerres","loireforez","vaulxenvelin",
					"mantes","marnchantereine","annet","allonnes","canejan","casa",
					"ccpsa","ccvd","chabris","chatenay","chatillon","chauffailles",
					"chauny","clisson","merville","warndt","gap","givors3","stclaude",
					"kervignac","labouexiere","ciotat","lamadeleine","lambersart",
					"languidic","chatelet","fousseret","leguevin","lbottereau",
					"marennes","montauban","stgirons","neuilly","pace","plougastel",
					"pstmartin","portet","ramuz","revel","stdenisenval","boiseau",
					"peray","carembault","cluses","lere","chateaugiron","barcelonette",
					"valence","thouars","vlagrand","wormhout","meylan","mortagne",
					"opacce","questembert","enligne","pergame","plaine","pontault",
					"rcmenligne","mirepoix","alboussiere","stcyr","stdizier","sthilaire",
					"talence","biblibre","ambares","bron","BronTest","hazebrouk","luce",
					"maze","migennes","montrouge","nangis","bonnefonds","villeveque",
					"voiron","voreppe","viry","yonne"];
$names=["bucarest"];
$user="backup";
$server_ip="172.16.77.60";
$path="isamdb/";

(new DatabasesCronScript($user,$server_ip,$path))->clean_backup_files()->update_all_databases($names);


?>
