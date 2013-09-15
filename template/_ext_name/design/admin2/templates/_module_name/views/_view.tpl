{if is_set( $content )}

    <table cellspacing="0" class="list">
        <tr>
            <th width="60%">Dummy keys</th>
            <th width="40%">Dummy values</th>
        </tr>
        {foreach
            hash(
	        	'Dummy key', 'Dummy value',
	        	'Dummy key', 'Dummy value'
        	) as $key => $value
            sequence array( 'bglight', 'bgdark' ) as $bg_class
        }
            <tr class="{$bg_class}">
                <td>{$key}</td>
                <td>{$value}</td>
            </tr>
        {/foreach}
    </table>

    <div class="box-bc"><div class="box-ml"><div class="box-content">
        {$content}
    </div></div></div>

{/if}
