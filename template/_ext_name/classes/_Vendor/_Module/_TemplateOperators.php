<?php

namespace classes\_Vendor\_Module;

/**
 *  All methods save `getOperatorNames` are used by eZ.
 *
 *  @author     your name   <user@host.tld>
 */
class _TemplateOperators
{

    public $operators;


    function __construct()
    {
        $this->operators = self::getOperatorNames();
    }


    function operatorList()
    {
        return $this->operators;
    }


    public static function getOperatorNames()
    {
        return array(
            '_operator0',
            '_operator1',
        );
    }


    function namedParameterPerOperator()
    {
        return true;
    }


    function namedParameterList()
    {
        return array(
            '_operator0' => array(
                '_key' => array(
                    'type' => 'string',
                    'required' => true,
                    'default' => '',
                ),
            ),
            '_operator1' => array(
                '_key' => array(
                    'type' => 'integer',
                    'required' => true,
                    'default' => 0,
                ),
            ),
        );
    }


    function modify ( $tpl, $operatorName, $operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        switch ( $operatorName )
        {
            case '_operator0':
                $operatorValue = '0';
                break;
            case '_operator1':
                $operatorValue = '1';
                break;
        }
    }

}
