<?php

/*
This script improves performance by compiling in code overrides. This cuts down use of 'eval' and dynamic rewrite, and allows opcode caching to fully work.
It also is necessary for Hip Hop PHP compilation.

Usage:
php data_custom/compile_in_includes.php

To undo...
php data_custom/compile_in_includes.php undo


NB: This script must be located in the data_custom directory, otherwise there will be errors.

NB: There is a requirement that overrides that do code re-writing, must not call ocPortal API funcs, such as require_code. They must use pure PHP to do their string replaces.
*/

$cli=(php_sapi_name()=='cli' && empty($_SERVER['REMOTE_ADDR']));
if (!$cli)
{
	header('Content-type: text/plain');
	exit('Must run this script on command line, for security reasons');
}

$undo=(isset($_SERVER['argv'][1]) && $_SERVER['argv'][1]=='undo');

$file_base=dirname(dirname(__FILE__));
$files=get_directory_contents($file_base,'');

foreach ($files as $file)
{
	if ((substr($file,-4)=='.php') && (strpos($file,'_custom')!==false))
	{
		$file_orig=str_replace('_custom','',$file);
		$marked_old=file_exists($file_orig.'.orig-precompile');

		// Find override data
		$matches=array();
		$file_data=file_get_contents($file);
		if (preg_match('#\#PRIOR TO COMPILED>>>(.*)\#<<<PRIOR TO COMPILED#s',$file_data,$matches)!=0) // Must work back to what it was before compilation
		{
			$file_data=$matches[1];
		} else
		{
			$file_data=str_replace(array('?'.'>','<'.'?php'),array('',''),$file_data); // Verbatim
		}

		// UNDO MODE
		if ($undo)
		{
			if ((file_exists($file_orig)) || ($marked_old))
			{
				// Restore original
				if ($marked_old)
				{
					@unlink($file_orig);
					rename($file_orig.'.orig-precompile',$file_orig);
				}

				// Restore override
				$myfile=fopen($file,'wb');
				fwrite($myfile,'<'.'?php'.chr(10).chr(10).preg_replace('#^\##m','',trim($file_data)));
				fclose($myfile);
			}

			continue;
		}

		// COMPILE MODE... continue to work out what our compilation will be

		if ($marked_old) $file_orig.='.orig-precompile';

		if (file_exists($file_orig))
		{
			$orig=str_replace(array('?'.'>','<'.'?php'),array('',''),file_get_contents($file_orig));

			$codename=$file;
			if (substr($codename,0,8)=='sources/')
			{
				$codename=substr($codename,8);
				$codename=substr($codename,0,strlen($codename)-4);
			}
			$init_func='init__'.str_replace('/','__',str_replace('.php','',$codename));

			if (strpos($file_data,'class Mx_')===false)
			{
				$functions_before=get_defined_functions();
				$classes_before=get_declared_classes();
				require($file); // Include our override
				$functions_after=get_defined_functions();
				$classes_after=get_declared_classes();
				$functions_diff=array_diff($functions_after['user'],$functions_before['user']); // Our override defined these functions
				$classes_diff=array_diff($classes_after,$classes_before);

				$pure=true; // We will set this to false if it does not have all functions the main one has. If it does have all functions we know we should not run the original init, as it will almost certainly just have been the same code copy&pasted through.
				$overlaps=false;
				foreach ($functions_diff as $function) // Go through override's functions and make sure original doesn't have them: rename original's to non_overridden__ equivs.
				{
					if (strpos($orig,'function '.$function.'(')!==false) // NB: If this fails, it may be that "function\t" is in the file (you can't tell with a three-width proper tab)
					{
						$orig=str_replace('function '.$function.'(','function non_overridden__'.$function.'(',$orig);
						$overlaps=true;
					} else
					{
						$pure=false;
					}
				}
				foreach ($classes_diff as $class)
				{
					if (substr(strtolower($class),0,6)=='module') $class=ucfirst($class);
					if (substr(strtolower($class),0,4)=='hook') $class=ucfirst($class);

					if (strpos($orig,'class '.$class)!==false)
					{
						$orig=str_replace('class '.$class,'class non_overridden__'.$class,$orig);
						$overlaps=true;
					} else
					{
						$pure=false;
					}
				}

				// See if we can get away with loading init function early. If we can we do a special version of it that supports fancy code modification. Our override isn't allowed to call the non-overridden init function as it won't have been loaded up by PHP in time. Instead though we will call it ourselves if it still exists (hasn't been removed by our own init function) because it likely serves a different purpose to our code-modification init function and copy&paste coding is bad.
				$doing_code_modifier_init=function_exists($init_func);
				$done_code_modifier_init=false;
				if ($doing_code_modifier_init)
				{
					$test=call_user_func_array($init_func,array($orig));
					if (is_string($test))
					{
						$orig=$test;
						$done_code_modifier_init=true;
					}
					$done_init=true;
				}

				if ((!$pure) && ($doing_code_modifier_init) && (function_exists('non_overridden__init__'.str_replace('/','__',str_replace('.php','',$codename)))))
				{
					$second_init_function='non_overridden__init__'.str_replace('/','__',str_replace('.php','',$codename));
					$orig=str_replace($second_init_function,$init_func,$orig);
				}

				$new='<'.'?php'.chr(10).chr(10).'#PRIOR TO COMPILED>>>'.chr(10).preg_replace('#^#m','#',trim($file_data)).chr(10).'#<<<PRIOR TO COMPILED'.chr(10).chr(10).$orig;
				if (!$done_code_modifier_init)
					$new.=chr(10).chr(10).$file_data;
			} else
			{
				$new='<'.'?php'.chr(10).chr(10).'#PRIOR TO COMPILED>>>'.chr(10).preg_replace('#^#m','#',trim($file_data)).chr(10).'#<<<PRIOR TO COMPILED'.chr(10).chr(10).$orig.chr(10).chr(10).$file_data;
			}

			echo 'Done: '.$file.chr(10);

			// Save
			$myfile=fopen($file,'wb');
			fwrite($myfile,$new);
			fclose($myfile);

			// Remove original file, to stop ocPortal trying to load it
			if (!$marked_old)
			{
				rename($file_orig,$file_orig.'.orig-precompile');
			}
		}
	}
}


function get_directory_contents($path,$rel_path='')
{
	$out=array();

	$d=opendir($path);
	while (($file=readdir($d))!==false)
	{
		if (($file=='.') || ($file=='..')) continue;

		$is_file=is_file($path.'/'.$file);
		if ($is_file)
		{
			$out[]=$rel_path.(($rel_path=='')?'':'/').$file;
		} elseif (is_dir($path.'/'.$file))
		{
			$out=array_merge($out,get_directory_contents($path.'/'.$file,$rel_path.(($rel_path=='')?'':'/').$file));
		}
	}
	closedir($d);

	return $out;
}
