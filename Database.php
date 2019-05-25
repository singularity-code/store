<?php

class Database
{
	const SERVER = 'localhost';
	const USER = 'root';
	const PASSWORD = 'secret';
	const DBNAME = 'store';
	protected $mysqli;

	public static function connect()
	{
		$mysqli = new mysqli(self::SERVER, self::USER, self::PASSWORD, self::DBNAME);
		return $mysqli;
	}
}

?>