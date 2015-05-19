<?php

class banners_algorithm_test_set extends ocp_test_case
{

	public $DATA=array();
	const HITS_PER_BANNER_ROTATION_CYCLE = 50;

public function setUp()
{
		parent::setUp();
}




public function get_test_data()
{
    return array(
        'test1'=>0.2,
        'test2'=>0.3,
        'test3'=>0.3,
        'test4'=>0.3,
    );
}

public function test_case__importance_bias_random()
{
    $banner_set=$this->get_test_data();

    $n=1000;

    $precedence_total=array_sum($banner_set);
    $scaler=1.0/$precedence_total;

    $expected_choices=array(
        'test1'=>$n*0.2*$scaler,
        'test2'=>$n*0.3*$scaler,
        'test3'=>$n*0.3*$scaler,
        'test4'=>$n*0.3*$scaler,
    );

    $choices=array();
    for ($i=0;$i<$n;$i++)
    {
        $choice=$this->choose_banner($banner_set,'importance_bias_random');
        if (!isset($choices[$choice])) $choices[$choice]=0;
        $choices[$choice]++;
    }
    ksort($choices);

    $is_correct=true;
    foreach ($choices as $banner_code=>$choice_count)
    {
        // Find difference between how many times the banner came up, and how many times we'd expect it to come up on average
        $dif=$choice_count-$expected_choices[$banner_code];

        // If the difference for any of the banners is more than 10%, this suggests our randomised choices are not valid
       if (abs($dif)>0.1*$n) $is_correct=false;
        
    }
    var_dump($is_correct);
    
}

// function test_case__importance_bias_rotation()
// {
//     $n=HITS_PER_BANNER_ROTATION_CYCLE*3*2; 
//     $is_correct=$this->_test_case__precedence($n,'importance_bias_rotation',0.0);
//     var_dump($is_correct);
// }

function test_case__precedence_random()
{
    $is_correct=$this->_test_case__precedence(100,'precedence_random',0.1);
    var_dump($is_correct);
}

function test_case__precedence_rotation()
{
    $n=SELF::HITS_PER_BANNER_ROTATION_CYCLE*3*2; // Let it go through the rotation 2 full times
    $is_correct=$this->_test_case__precedence($n,'precedence_rotation',0.0);
    var_dump($is_correct);
}

function _test_case__precedence($n,$algorithm,$tolerance)
{
    $banner_set=$this->get_test_data();

    $acceptable_choices=array('test2','test3','test4');

    // We will do this $n times, then check it matches expected statistical spread
    $choices=array();
    for ($i=0;$i<$n;$i++)
    {
        $choice=$this->choose_banner($banner_set,$algorithm);
        if (!isset($choices[$choice])) $choices[$choice]=0;
        $choices[$choice]++;
    }
    ksort($choices);

    $is_correct=true;
    foreach ($choices as $choice_count)
    {
        // Find difference between how many times the banner came up, and how many times we'd expect it to come up on average
        $dif=$choice_count-($n/count($acceptable_choices));

        // If the difference for any of the banners is more than 10%, this suggests our randomised choices are not valid
        if (abs($dif)>$tolerance*$n) $is_correct=false;
    }
    return $is_correct;
}



public function choose_banner($banner_set,$algorithm)
{
    if (count($banner_set)==0) return NULL;

    $rotation_identifier=md5(serialize(func_get_args()));

    switch ($algorithm)
    {
        case 'importance_bias_random':
            $banner=$this->choose_banner__importance_bias_random($banner_set);
            break;

        case 'importance_bias_rotation':
            $banner=$this->choose_banner__importance_bias_rotation($banner_set,$rotation_identifier);
            break;

        case 'precedence_random':
            $banner=$this->choose_banner__precedence_random($banner_set);
            break;

        case 'precedence_rotation':
            $banner=$this->choose_banner__precedence_rotation($banner_set,$rotation_identifier);
            break;
    }
 
    return $banner;
}

public function choose_banner__importance_bias_random($banner_set)
{
    // Find the total of all the precedences
    $total=array_sum($banner_set);
    
    // Pick a random number between zero and the total
    $spot_on_number_line=(rand()/getrandmax())*$total;

    // If all the banners are *imagined* laid out in a sequence, with number range width equal to precedence, on which banner on the number line is our random number?
    $position_on_number_line=0;
    foreach ($banner_set as $banner_code=>$precedence)
    {
        $position_on_number_line+=$precedence;
        if ($position_on_number_line>=$spot_on_number_line)
        {
            //echo 'total='.$total.' spot_on_number_line='.$spot_on_number_line.' position_on_number_line='.$position_on_number_line.' banner '.$banner_code;exit();    Useful for debugging
            return $banner_code;
        }
    }
    exit('Should never get here ('.strval($position_on_number_line).' of '.strval($spot_on_number_line).')');

 
}

function choose_banner__importance_bias_rotation($banner_set,$rotation_identifier)
{
    
    $banner_set = $this->get_test_data();

    // Find the total of all the precedences
    $total=array_sum($banner_set);

    
    // Find our current cycle in the rotation / initialise if new
    $_pos=$this->get_long_value($rotation_identifier.'_position');
    if ($_pos===NULL)
    {
        $pos=0;
    } else
    {
        $pos=intval($_pos);
    }


    // Advance cycle if necessary
    $_hits=$this->get_long_value($rotation_identifier.'_hits');
    if ($_hits===NULL)
    {
        $hits=0;
    } else
    {
        $hits=intval($_hits);
    }

    if ($hits==SELF::HITS_PER_BANNER_ROTATION_CYCLE)
    {
        // Advance cycle
        $hits=1;
        $this->set_long_value($rotation_identifier.'_hits',strval($hits));
        $pos++;
        if($pos>=$total)
        {
            // Reset cycle, as it passed the end
            $pos=0;
        }
        $this->set_long_value($rotation_identifier.'_position',strval($pos));
    } else
    {
        // Continue cycle
        $hits++;
        $this->set_long_value($rotation_identifier.'_hits',strval($hits));
    }

    // Pick banner
    $banner_set_values=array_keys($banner_set);
    $result=$banner_set_values[$pos];
    return $result;




}

function choose_banner__precedence_random($banner_set)
{
    return array_rand($this->find_all_highest_precedence_banners($banner_set));
}

function choose_banner__precedence_rotation($banner_set,$rotation_identifier)
{
    $banner_set=$this->find_all_highest_precedence_banners($banner_set);

    // Find the maximum number of banners in the rotation
    $max=count($banner_set);

    // Find our current cycle in the rotation / initialise if new
    $_pos=$this->get_long_value($rotation_identifier.'_position');
    if ($_pos===NULL)
    {
        $pos=0;
    } else
    {
        $pos=intval($_pos);
    }

    // Advance cycle if necessary
    $_hits=$this->get_long_value($rotation_identifier.'_hits');
    if ($_hits===NULL)
    {
        $hits=0;
    } else
    {
        $hits=intval($_hits);
    }
    if ($hits==SELF::HITS_PER_BANNER_ROTATION_CYCLE)
    {
        // Advance cycle
        $hits=1;
        $this->set_long_value($rotation_identifier.'_hits',strval($hits));
        $pos++;
        if ($pos>=$max)
        {
            // Reset cycle, as it passed the end
            $pos=0;
        }
        $this->set_long_value($rotation_identifier.'_position',strval($pos));
    } else
    {
        // Continue cycle
        $hits++;
        $this->set_long_value($rotation_identifier.'_hits',strval($hits));
    }

    // Pick banner
    $banner_set_values=array_keys($banner_set);
    $result=$banner_set_values[$pos];
    return $result;
}

function find_all_highest_precedence_banners($banner_set)
{
    // Filter our banners according to precedence...

    // Find the highest precedence
    $highest=NULL;
    foreach ($banner_set as $precedence)
    {
        if ((is_null($highest)) || ($precedence>$highest))
        {
            $highest=$precedence;
        }
    }

    // Get array of banners of highest precedence
    $banner_set_filtered=array();
    foreach ($banner_set as $banner_codename=>$precedence)
    {
        if ($precedence==$highest)
        {
            $banner_set_filtered[$banner_codename]=$precedence;
        }
    }

    return $banner_set_filtered;
}

function set_long_value($name,$value)
{
 
    $this->DATA[$name]=$value;    
}

function get_long_value($name)
{
    if (!isset($this->DATA[$name])) return NULL;
    return $this->DATA[$name];
}



public function tearDown()
	{		
		parent::tearDown();
	}


}

?>