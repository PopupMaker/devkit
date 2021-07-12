<?php
/**
 * Config
 *
 * @package App
 */

declare( strict_types = 1 );
require_once dirname( __DIR__ ) . '/vendor/autoload.php';
require_once dirname( __DIR__ ) . '/config/application.php';
require_once ABSPATH . 'wp-settings.php';


/**
 * Automatically handle enqueueing livereload if available.
 */
add_action( 'admin_enqueue_scripts', function () {
	if ( ! defined( WP_ENV ) || 'production' === WP_ENV ) {
		return;
	}

	if ( curl_init( 'http://localhost:35729/livereload.js' ) !== false ) {
		wp_enqueue_script( 'webpack-live-reload', 'http://localhost:35729/livereload.js', [], '0.0.0', false );
	}
} );

if ( has_action( 'shutdown', 'wp_ob_end_flush_all' ) !== false ) {

	// remove original callback
	remove_action( 'shutdown', 'wp_ob_end_flush_all', 1 );

	/**
	 * Add fixed callback.
	 * 
	 * Fixes known core issue: https://core.trac.wordpress.org/ticket/18525, https://core.trac.wordpress.org/ticket/22430
	 * 
	 * Error: PHP Notice:  ob_end_flush(): Failed to send buffer of zlib output compression (0)
	 */
	add_action( 'shutdown', function () {
		$start = (int) ini_get( 'zlib.output_compression' );
		$levels = ob_get_level();
		for ( $i = $start; $i < $levels; $i++ ) {
				ob_end_flush();
		}
	}, 1 );

}