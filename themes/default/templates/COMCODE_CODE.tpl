<div class="comcode_code_wrap">
	<div class="comcode_code">
		<h4>{TITLE}</h4>

		{$SET,tag_type,{$?,{$IN_STR,{CONTENT},<div,<p,<table},div,{$?,{$EQ,{TYPE},samp},samp,code}}}
		<div class="xhtml_validator_off"><{$GET,tag_type} class="comcode_code_inner">
			{CONTENT`}
		</{$GET,tag_type}></div>
	</div>
</div>
