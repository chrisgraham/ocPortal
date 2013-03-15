<?php
/*
* Copyright (c) 2008 http://www.webmotionuk.com / http://www.webmotionuk.co.uk
* "PHP & Jquery image upload & crop"
* Date: 2008-11-21
* Ver 1.2
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
* IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
* STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
* THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*/

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$deep='data_custom/upload-crop/';
$FILE_BASE=str_replace($deep,'',$FILE_BASE);
$FILE_BASE=str_replace(str_replace('/','\\',$deep),'',$FILE_BASE);
if (substr($FILE_BASE,-4)=='.php')
{
   $a=strrpos($FILE_BASE,'/');
   $b=strrpos($FILE_BASE,'\\');
   $FILE_BASE=dirname($FILE_BASE);
}
$RELATIVE_PATH='';
@chdir($FILE_BASE);

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<html><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

require_code('developer_tools');
destrictify();

css_enforce('global');

if (!has_zone_access(get_member(),'adminzone')) exit('Security error (did you get logged out?)');

$max_width=800;
$large_image_location=$_GET['file'];
if (get_magic_quotes_gpc()) $large_image_location=stripslashes($large_image_location);
$thumb_image_location=$_GET['thumb'];
if (get_magic_quotes_gpc()) $thumb_image_location=stripslashes($thumb_image_location);
if (substr($large_image_location,0,strlen('uploads/attachments/'))!='uploads/attachments/') exit('Security error');
if (strpos($large_image_location,'..')!==false) exit('Security error');
if (substr($thumb_image_location,0,strlen('uploads/attachments_thumbs/'))!='uploads/attachments_thumbs/') exit('Security error');
if (strpos($thumb_image_location,'..')!==false) exit('Security error');
$thumb_width=intval(isset($_POST['thumb_width'])?$_POST['thumb_width']:$_GET['thumb_width']);						// Width of thumbnail image
$thumb_height=intval(isset($_POST['thumb_height'])?$_POST['thumb_height']:$_GET['thumb_height']);						// Height of thumbnail image
// Only one of these image types should be allowed for upload
$allowed_image_types=array('image/pjpeg'=>"jpg",'image/jpeg'=>"jpg",'image/jpg'=>"jpg",'image/png'=>"png",'image/x-png'=>"png",'image/gif'=>"gif");
$allowed_image_ext=array_unique($allowed_image_types); // do not change this
$image_ext="";	// initialise variable, do not change this.
foreach ($allowed_image_ext as $mime_type=>$ext) {
    $image_ext.= strtoupper($ext)." ";
}


##########################################################################################################
# IMAGE FUNCTIONS																						 #
# You do not need to alter these functions																 #
##########################################################################################################
function resizeImage($image,$width,$height,$scale) {
	list($imagewidth, $imageheight, $imageType)=getimagesize($image);
	$imageType=image_type_to_mime_type($imageType);
	$newImageWidth=ceil($width * $scale);
	$newImageHeight=ceil($height * $scale);
	$newImage=imagecreatetruecolor($newImageWidth,$newImageHeight);
	switch($imageType) {
		case "image/gif":
			$source=imagecreatefromgif($image); 
			break;
		case "image/pjpeg":
		case "image/jpeg":
		case "image/jpg":
			$source=imagecreatefromjpeg($image); 
			break;
	    case "image/png":
		case "image/x-png":
			$source=imagecreatefrompng($image); 
			break;
  	}
	imagecopyresampled($newImage,$source,0,0,0,0,$newImageWidth,$newImageHeight,$width,$height);

	switch($imageType) {
		case "image/gif":
	  		imagegif($newImage,$image); 
			break;
		case "image/pjpeg":
		case "image/jpeg":
		case "image/jpg":
	  		imagejpeg($newImage,$image,90); 
			break;
		case "image/png":
		case "image/x-png":
			imagepng($newImage,$image);  
			break;
    }

	chmod($image, 0777);
	return $image;
}
//You do not need to alter these functions
function resizeThumbnailImage($thumb_image_name, $image, $width, $height, $start_width, $start_height, $scale){
	list($imagewidth, $imageheight, $imageType)=getimagesize($image);
	$imageType=image_type_to_mime_type($imageType);

	$newImageWidth=ceil($width * $scale);
	$newImageHeight=ceil($height * $scale);
	$newImage=imagecreatetruecolor($newImageWidth,$newImageHeight);
	switch($imageType) {
		case "image/gif":
			$source=imagecreatefromgif($image); 
			break;
	    case "image/pjpeg":
		case "image/jpeg":
		case "image/jpg":
			$source=imagecreatefromjpeg($image); 
			break;
	    case "image/png":
		case "image/x-png":
			$source=imagecreatefrompng($image); 
			break;
  	}
	imagecopyresampled($newImage,$source,0,0,$start_width,$start_height,$newImageWidth,$newImageHeight,$width,$height);
	switch($imageType) {
		case "image/gif":
	  		imagegif($newImage,$thumb_image_name); 
			break;
      	case "image/pjpeg":
		case "image/jpeg":
		case "image/jpg":
	  		imagejpeg($newImage,$thumb_image_name,90); 
			break;
		case "image/png":
		case "image/x-png":
			imagepng($newImage,$thumb_image_name);  
			break;
    }
	chmod($thumb_image_name, 0777);
	return $thumb_image_name;
}
//You do not need to alter these functions
function getHeight($image) {
	$size=getimagesize($image);
	$height=$size[1];
	return $height;
}
//You do not need to alter these functions
function getWidth($image) {
	$size=getimagesize($image);
	$width=$size[0];
	return $width;
}

//Check to see if any images with the same name already exist
if (file_exists($large_image_location)){
	if(file_exists($thumb_image_location)){
		$thumb_photo_exists="<img src=\"../../".$thumb_image_location."\" alt=\"Thumbnail Image\"/>";
	}else{
		$thumb_photo_exists="";
	}
	$large_photo_exists="<img src=\"../../".$large_image_location."\" alt=\"Large Image\"/>";
} else {
	$large_photo_exists="";
	$thumb_photo_exists="";
}

// Check our large file is not too large
$width=getWidth($large_image_location);
$height=getHeight($large_image_location);
//Scale the image if it is greater than the width set above
if ($width > $max_width){
	$scale=$max_width/$width;
	$uploaded=resizeImage($large_image_location,$width,$height,$scale);
}else{
	$scale=1;
	$uploaded=resizeImage($large_image_location,$width,$height,$scale);
}

$message='';

if (isset($_POST["upload_thumbnail"]) && strlen($large_photo_exists)>0) {
	//Get the new coordinates to crop the image.
	$x1=$_POST["x1"];
	$y1=$_POST["y1"];
	$x2=$_POST["x2"];
	$y2=$_POST["y2"];
	$w=$_POST["w"];
	$h=$_POST["h"];
	//Scale the image to the thumb_width set above
	$scale=$thumb_width/$w;
	$cropped=resizeThumbnailImage($thumb_image_location, $large_image_location,$w,$h,$x1,$y1,$scale);

	$message='Saved!';
}

?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="generator" content="WebMotionUK" />
	<title>Thumbnail generator</title>
	<link href="../../themes/default/templates_cached/EN/global.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery-pack.js"></script>
	<script type="text/javascript" src="js/jquery.imgareaselect.min.js"></script>
</head>
<body>
<!-- 
* Copyright (c) 2008 http://www.webmotionuk.com / http://www.webmotionuk.co.uk
* Date: 2008-11-21
* "PHP & Jquery image upload & crop"
* Ver 1.2
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
* IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
* STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
* THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
-->
<?php
//Only display the javacript if an image has been uploaded
if(strlen($large_photo_exists)>0){
	$current_large_image_width=getWidth($large_image_location);
	$current_large_image_height=getHeight($large_image_location);?>
<script type="text/javascript">
function preview(img, selection) { 
	var scaleX=<?php echo $thumb_width;?> / selection.width; 
	var scaleY=<?php echo $thumb_height;?> / selection.height; 

	$('#thumbnail + div > img').css({ 
		width: Math.round(scaleX * <?php echo $current_large_image_width;?>) + 'px', 
		height: Math.round(scaleY * <?php echo $current_large_image_height;?>) + 'px',
		marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px', 
		marginTop: '-' + Math.round(scaleY * selection.y1) + 'px' 
	});
	$('#x1').val(selection.x1);
	$('#y1').val(selection.y1);
	$('#x2').val(selection.x2);
	$('#y2').val(selection.y2);
	$('#w').val(selection.width);
	$('#h').val(selection.height);
} 

$(document).ready(function () { 
	$('#save_thumb').click(function() {
		var x1=$('#x1').val();
		var y1=$('#y1').val();
		var x2=$('#x2').val();
		var y2=$('#y2').val();
		var w=$('#w').val();
		var h=$('#h').val();
		if(x1=="" || y1=="" || x2=="" || y2=="" || w=="" || h==""){
			alert("You must make a selection first");
			return false;
		}else{
			return true;
		}
	});
}); 

$(window).load(function () { 
	$('#thumbnail').imgAreaSelect({ aspectRatio: '1:<?php echo $thumb_height/$thumb_width;?>', onSelectChange: preview }); 
	<?php
		if (isset($_POST['w']))
			echo 'preview($(\'#thumbnail\'), { width:'.$_POST['w'].', height:'.$_POST['h'].', x1:'.$_POST['x1'].', x2:'.$_POST['x2'].', y1:'.$_POST['y1'].', y2:'.$_POST['y2'].' });';
	?>
});

</script>
<?php }?>
<h1>Thumbnail generator</h1>
<?php
/*if(strlen($large_photo_exists)>0 && strlen($thumb_photo_exists)>0){
	echo $large_photo_exists."&nbsp;".$thumb_photo_exists;
}else*/{
		if(strlen($large_photo_exists)>0){?>
<?php
	echo '<span id="message" style="float: right">'.$message.'</span>';
?>
		<h2>Create Thumbnail</h2>
		<div align="center">
			<img src="../../<?php echo $large_image_location;?>" style="float: left; margin-right: 10px;" id="thumbnail" alt="Create Thumbnail" />
			<div style="border:1px #e5e5e5 solid; float:left; position:relative; overflow:hidden; width:<?php echo $thumb_width;?>px; height:<?php echo $thumb_height;?>px;">
				<img src="../../<?php echo $large_image_location;?>" style="position: relative;" alt="Thumbnail Preview" />
			</div>
			<br style="clear:both;"/>
			<form style="float: left; width: 400px" onsubmit="document.getElementById('message').innerHTML='Changing size';" action="<?php echo htmlentities($_SERVER["PHP_SELF"].'?'.$_SERVER['QUERY_STRING']);?>" method="post">
				<p>
					<input size="5" type="text" name="thumb_width" value="<?php echo $thumb_width; ?>" id="thumb_width" />
					&times;
					<input size="5" type="text" name="thumb_height" value="<?php echo $thumb_height; ?>" id="thumb_height" />
					<input type="submit" name="change_size" value="Change thumbnail size" id="change_size" />
				</p>
			</form>
			<form style="margin-right: 400px" onsubmit="document.getElementById('message').innerHTML='...';" action="<?php echo htmlentities($_SERVER["PHP_SELF"].'?'.$_SERVER['QUERY_STRING']);?>" method="post">
				<input type="hidden" name="thumb_width" value="<?php echo $thumb_width; ?>" id="thumb_width" />
				<input type="hidden" name="thumb_height" value="<?php echo $thumb_height; ?>" id="thumb_height" />
				<input type="hidden" name="x1" value="" id="x1" />
				<input type="hidden" name="y1" value="" id="y1" />
				<input type="hidden" name="x2" value="" id="x2" />
				<input type="hidden" name="y2" value="" id="y2" />
				<input type="hidden" name="w" value="" id="w" />
				<input type="hidden" name="h" value="" id="h" />
				<p><input type="submit" name="upload_thumbnail" value="Save Thumbnail" id="save_thumb" /></p>
			</form>
		</div>
	<?php 	} ?>
<?php } ?>
<!-- Copyright (c) 2008 http://www.webmotionuk.com -->
</body>
</html>
