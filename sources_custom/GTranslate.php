<?php
/**
 * Google Translator
 * @package WebService :: GTranslate
 * @author ntf
 * @version 1.0
 * @copyright Creative Commons Attribution-Non-Commercial 3.0 Hong Kong http://creativecommons.org/licenses/by-nc/3.0/hk/
 */
class GTranslate{
	protected $lang_from='en';
	protected $lang_to;

	protected $language_list = array( 'ar'=>'Arabic', 'bg'=>'Bulgarian', 'zh-CN'=>'Simplified Chinese', 'zh-TW'=>'Traditional Chinese', 'hr'=>'Croatian', 'cs'=>'Czech', 'da'=>'Danish', 'nl'=>'Dutch', 'en'=>'English', 'fi'=>'Finnish', 'fr'=>'French', 'de'=>'German', 'el'=>'Greek', 'hi'=>'Hindi', 'it'=>'Italian', 'ja'=>'Japanese', 'ko'=>'Korean', 'pl'=>'Polish', 'pt'=>'Portuguese', 'ro'=>'Romanian', 'ru'=>'Russian', 'es'=>'Spanish', 'sv'=>'Swedish');
        
	protected $translateContent;
	protected $translateMode=false;

	function __construct(){

	}

	function Text($text){
		$this->translateMode = '_TranslateMode_Text';
		$this->translateContent = $text;
		return $this;
	}
	/* TODO : Debug
	function Url($url){
		$this->translateMode = '_TranslateMode_Url';
		$this->translateContent = $url;
		return $this;
	}
*/
	function From($language){

		if( $this->_in_language_list($language) !== false ){
		 	$this->lang_from = $this->_in_language_list($language);
		}else{
			throw new Exception(__METHOD__ .' Required Language not in the Translation list');
			$this->lang_from = 'auto';
		}

		return $this;
	}

	function To($language){

		if( $this->_in_language_list($language) !== false ){
		 	$this->lang_to = $this->_in_language_list($language);		
			return  $this->Translate();		
		}else{
			throw new Exception(__METHOD__ .' Required Language not in the Translation list');
			return false;
		}

	}

	function GetLanguageList(){
		return $this->language_list;
	}
	function Translate(){

		if(!method_exists( $this , $this->translateMode) ){
			return false;
		}

		$result = call_user_func( array($this , $this->translateMode) );

		$this->translateMode=false;
		return $result;
	}

	protected function _in_language_list( $language ){

		if( array_key_exists($language , $this->language_list) ){
			return $language;
		}elseif( in_array( $language , $this->language_list ) ){
			return array_search ( $language , $this->language_list );
		}else{
			return false;
		}

	}

	protected function _TranslateMode_Text(){
		require_code('files');
		$text=str_split($this->translateContent,3000); // Google can't translate too much at once
		if (count($text)>1)
		{
			for ($i=0;$i<count($text)-1;$i++) // Fiddle things a bit to get correct XHTML in each
			{
				$t=$text[$i];
				$a=substr_count($t,'<');
				$b=substr_count($t,'>');

				if ($a>$b)
				{
					$close_pos=strpos($text[$i+1],'>');
					if ($close_pos!==false)
					{
						$text[$i].=substr($text[$i+1],0,$close_pos+1);
						$text[$i+1]=substr($text[$i+1],$close_pos+1);
					} else break;
				}
			}
		}
		$out='';
		foreach ($text as $t)
		{
			$key=get_value('google_translate_api_key');
			$post_params=array(
				'v'=>'1.0',
				'userip'=>get_ip_address(),
				'q'=>$t,
				'langpair'=>$this->lang_from.'|'.$this->lang_to,
				'format'=>'html',
			);
			if (!is_null($key)) $post_params['key']=$key;
			$json = http_download_file('http://ajax.googleapis.com/ajax/services/language/translate',NULL,true,false,get_site_name(),$post_params,NULL,NULL,NULL,NULL,NULL,ocp_srv('HTTP_REFERER'));
			$json = str_replace('\u003c','<',$json);
			$json = str_replace('\u003d','=',$json);
			$json = str_replace('\u003e','>',$json);
			$json = str_replace("\n",'\n',$json);
			$json = str_replace("\t",'\t',$json);
			$translate_object = json_decode($json);
			if (!isset($translate_object->responseData->translatedText)) return NULL;//fatal_exit($json.serialize($translate_object));
			$out.=$translate_object->responseData->translatedText;
		}

		return $out;
	}
/* TODO Debug , If I use header redirect, google will not response correctly
	protected function _TranslateMode_Url(){
   		header('location: http://66.102.9.104/translate_c?hl=en&safe=off&ie=UTF-8&oe=UTF-8&prev=%2Flanguage_tools&u='.urlencode($this->translateContent).'&langpair='. $this->lang_from .'%7C'. $this->lang_to .';');

	}
*/
}
