<?php
/**
 * Google Translator
 * @package WebService :: GTranslate
 * @author ntf
 * @copyright Creative Commons Attribution-Non-Commercial 3.0 Hong Kong http://creativecommons.org/licenses/by-nc/3.0/hk/
 * Modified for Google Translate 2 API by ocProducts, and generally tidied up.
 */

class GTranslate
{
	protected $lang_from='en';
	protected $lang_to;

	protected $key = null;

	protected $language_list = array( 'ar'=>'Arabic', 'bg'=>'Bulgarian', 'zh-CN'=>'Simplified Chinese', 'zh-TW'=>'Traditional Chinese', 'hr'=>'Croatian', 'cs'=>'Czech', 'da'=>'Danish', 'nl'=>'Dutch', 'en'=>'English', 'fi'=>'Finnish', 'fr'=>'French', 'de'=>'German', 'el'=>'Greek', 'hi'=>'Hindi', 'it'=>'Italian', 'ja'=>'Japanese', 'ko'=>'Korean', 'pl'=>'Polish', 'pt'=>'Portuguese', 'ro'=>'Romanian', 'ru'=>'Russian', 'es'=>'Spanish', 'sv'=>'Swedish');
        
	protected $translateContent;

	function From($language)
	{
		if( $this->_in_language_list($language) !== false ){
		 	$this->lang_from = $this->_in_language_list($language);
		}else{
			throw new Exception(__METHOD__ .' Required Language not in the Translation list');
			$this->lang_from = 'auto';
		}

		return $this;
	}

	function To($language)
	{
		if( $this->_in_language_list($language) !== false ){
		 	$this->lang_to = $this->_in_language_list($language);		
			return  $this->_Translate();		
		}else{
			throw new Exception(__METHOD__ .' Required Language not in the Translation list');
			return false;
		}
	}

	function Key($key)
	{
		$this->key = $key;
		return $this;
	}

	function Text($translateContent)
	{
		$this->translateContent = $translateContent;
		return $this;
	}

	function GetLanguageList()
	{
		return $this->language_list;
	}

	protected function _in_language_list( $language )
	{
		if( array_key_exists($language , $this->language_list) ){
			return $language;
		}elseif( in_array( $language , $this->language_list ) ){
			return array_search ( $language , $this->language_list );
		}else{
			return false;
		}
	}

	protected function _Translate()
	{
		require_code('files');
		$text=str_split($this->translateContent,4900); // Google can't translate too much at once
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
			$url='https://www.googleapis.com/language/translate/v2';
			$url.='?q='.urlencode($t);
			$url.='&prettyprint='.urlencode('false');
			$url.='&source='.urlencode($this->lang_from);
			$url.='&target='.urlencode($this->lang_to);
			$url.='&format='.urlencode('html');
			$url.='&key='.urlencode($this->key);

			$json = http_download_file($url,NULL,true,false,get_site_name());

			$json = str_replace('\u003c','<',$json);
			$json = str_replace('\u003d','=',$json);
			$json = str_replace('\u003e','>',$json);
			$json = str_replace("\n",'\n',$json);
			$json = str_replace("\t",'\t',$json);
			$translate_object = json_decode($json);

			if (!isset($translate_object->data->translations[0]->translatedText)) return NULL;//fatal_exit($json.serialize($translate_object));

			$out.=$translate_object->data->translations[0]->translatedText;
		}

		return $out;
	}
}
