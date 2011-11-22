{TITLE}

{+START,IF_EMPTY,{CATEGORIES}}
	<p class="nothing_here">{!NO_CATEGORIES}</p>
{+END}

{+START,IF_NON_EMPTY,{SHARED_MESSAGES}}
	{!NOTICES}:
	<ul>
		{+START,LOOP,SHARED_MESSAGES}
			<li>{_loop_var}</li>
		{+END}
	</ul>
{+END}

{+START,IF_NON_EMPTY,{CATEGORIES}}
	<form action="{POST_URL*}" method="post">
		<div>
			{HIDDEN}

			{+START,IF,{$NOT,{HAS_MIXED_DATE_TYPES}}}
				<span>{!FROM}</span>
				{+START,INCLUDE,BOOK_DATE_CHOOSE}
					NAME=bookable_date_from
					CURRENT_DAY={DATE_FROM_DAY}
					CURRENT_MONTH={DATE_FROM_MONTH}
					CURRENT_YEAR={DATE_FROM_YEAR}
					MIN_DATE_DAY={MIN_DATE_DAY}
					MIN_DATE_MONTH={MIN_DATE_MONTH}
					MIN_DATE_YEAR={MIN_DATE_YEAR}
					MAX_DATE_DAY={MAX_DATE_DAY}
					MAX_DATE_MONTH={MAX_DATE_MONTH}
					MAX_DATE_YEAR={MAX_DATE_YEAR}
				{+END}
		
				{+START,IF,HAS_DATE_RANGES}
					<span>{!TO}</span>
					{+START,INCLUDE,BOOK_DATE_CHOOSE}
						NAME=bookable_date_to
						CURRENT_DAY={DATE_FROM_DAY}
						CURRENT_MONTH={DATE_FROM_MONTH}
						CURRENT_YEAR={DATE_FROM_YEAR}
						MIN_DATE_DAY={MIN_DATE_DAY}
						MIN_DATE_MONTH={MIN_DATE_MONTH}
						MIN_DATE_YEAR={MIN_DATE_YEAR}
						MAX_DATE_DAY={MAX_DATE_DAY}
						MAX_DATE_MONTH={MAX_DATE_MONTH}
						MAX_DATE_YEAR={MAX_DATE_YEAR}
					{+END}
				{+END}
			{+END}
		
			{+START,LOOP,CATEGORIES}
				<h2>{TITLE}</h2>
		
				<div class="wide_table_wrap">
					<table class="wide_table solidborder">
						<thead>
							<tr>
								<th>{!ITEM}</th>
								<th>{!QUANTITY}</th>
								{+START,IF,{HAS_MIXED_DATE_TYPES}}
									<th>{!FROM}</th>
									<th>{!TO}</th>
								{+END}
								<th>{!DETAILS}</th>
							</tr>
						</thead>
		
						<tbody>
							{+START,LOOP,_loop_var}
								<tr>
									<th>
										{TITLE*}
		
										{$,To show price use {PRICE}}
									</th>
		
									<td>
										<label for="bookable_{ID*}_quantity">{!QUANTITY}, {TITLE*}</label>
										<select name="bookable_{ID*}_quantity" id="bookable_{ID*}_quantity">
											{+START,LOOP,{QUANTITY_AVAILABLE}}
												<option {+START,IF,{$EQ,{QUANTITY},{_loop_var}}}selected="selected" {+END}value="{_loop_var*}">{$INTEGER_FORMAT*,{_loop_var}}</option>
											{+END}
										</select>
									</td>
		
									{+START,IF,{HAS_MIXED_DATE_TYPES}}
										<td>
											{+START,INCLUDE,BOOK_DATE_CHOOSE}
												NAME=bookable_{ID}_date_from
												CURRENT_DAY={DATE_FROM_DAY}
												CURRENT_MONTH={DATE_FROM_MONTH}
												CURRENT_YEAR={DATE_FROM_YEAR}
												MIN_DATE_DAY={MIN_DATE_DAY}
												MIN_DATE_MONTH={MIN_DATE_MONTH}
												MIN_DATE_YEAR={MIN_DATE_YEAR}
												MAX_DATE_DAY={MAX_DATE_DAY}
												MAX_DATE_MONTH={MAX_DATE_MONTH}
												MAX_DATE_YEAR={MAX_DATE_YEAR}
											{+END}
										</td>
		
										<td>
											{+START,IF,{SELECT_DATE_RANGE}}
												{+START,INCLUDE,BOOK_DATE_CHOOSE}
													NAME=bookable_{ID}_date_to
													CURRENT_DAY={DATE_TO_DAY}
													CURRENT_MONTH={DATE_TO_MONTH}
													CURRENT_YEAR={DATE_TO_YEAR}
													MIN_DATE_DAY={MIN_DATE_DAY}
													MIN_DATE_MONTH={MIN_DATE_MONTH}
													MIN_DATE_YEAR={MIN_DATE_YEAR}
													MAX_DATE_DAY={MAX_DATE_DAY}
													MAX_DATE_MONTH={MAX_DATE_MONTH}
													MAX_DATE_YEAR={MAX_DATE_YEAR}
												{+END}
											{+END}
										</td>
									{+END}
		
									<td>
										{DESCRIPTION}
		
										{+START,IF_NON_EMPTY,{MESSAGES}}
											<ul>
												{+START,LOOP,MESSAGES}
													<li>{_loop_var}</li>
												{+END}
											</ul>
										{+END}
									</td>
								</tr>
							{+END}
						</tbody>
					</table>
				</div>
			{+END}
		</div>
	</form>
{+END}

<p>{!ALL_DATES_IN,{$VALUE_OPTION*,timezone}}</p>
