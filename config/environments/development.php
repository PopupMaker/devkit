<?php
/**
 * Application development config.
 *
 * @package App
 *
 * phpcs:disable WordPress.NamingConventions.PrefixAllGlobals
 */

declare( strict_types = 1 );

define( 'SAVEQUERIES', true );
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'SCRIPT_DEBUG', true );
define( 'WP_DEBUG_DISPLAY', true );

if ( defined( 'WP_CLI' ) && WP_CLI && env( 'MYSQLI_DEFAULT_SOCKET' ) ) {
	ini_set( 'mysqli.default_socket', env( 'MYSQLI_DEFAULT_SOCKET' ) ); // phpcs:ignore
}

define( 'FS_METHOD', 'direct' );
